-- nvim-treesitter, `main` branch (the v1.0 rewrite).
--
-- `master` is archived: it froze against Neovim 0.11 and needed a hand-written
-- patch here to survive 0.12. `main` ships no feature modules at all -- there is
-- no `nvim-treesitter.configs`. Highlighting, indentation and selection are
-- Neovim's own features; the plugin only installs parsers and provides queries.
-- This file wires Neovim's features up per filetype. See `:h nvim-treesitter`.

local ENSURE_INSTALLED = {
	"rust",
	"python",
	"typescript",
	"javascript",
	"c",
	"cpp",
	"c_sharp",
	"markdown",
	"markdown_inline",
}

-- Was `indent.disable = { "python" }` under master.
local INDENT_DISABLED = { python = true }

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false, -- `main` does not support lazy-loading
		config = function()
			local ts = require("nvim-treesitter")

			-- Async. The handle is kept so the FileType handler can wait on this
			-- install rather than starting a competing one: a second `install()`
			-- for an in-flight language blocks in a 60s `vim.wait`.
			local bootstrap = ts.install(ENSURE_INSTALLED)

			-- `get_available()` broadcasts `User TSUpdate` and sorts ~320 entries,
			-- so it is called once here, not on every FileType event.
			local available = {}
			for _, lang in ipairs(ts.get_available()) do
				available[lang] = true
			end

			local function attach(buf, lang)
				-- Deliberately not wrapped in pcall: a broken parser/query pair
				-- must fail loudly rather than silently drop highlighting.
				vim.treesitter.start(buf, lang)

				-- Only about half the languages ship `indents.scm`; without one,
				-- `indentexpr()` returns 0 for every line, which would flatten
				-- indentation and clobber Neovim's own indent plugin (e.g. `cs`).
				if not INDENT_DISABLED[lang] and vim.treesitter.query.get(lang, "indents") then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				-- master's `incremental_selection`. Neovim 0.12 provides this
				-- natively, so it needs no plugin code. Buffer-local, so <CR>
				-- keeps its normal meaning everywhere else (quickfix, prompts).
				vim.keymap.set({ "n", "x" }, "<CR>", function()
					vim.treesitter.select("parent")
				end, { buffer = buf, desc = "Treesitter: grow selection" })
				vim.keymap.set("x", "<BS>", function()
					vim.treesitter.select("child")
				end, { buffer = buf, desc = "Treesitter: shrink selection" })
			end

			-- Attach once `task` settles. A failed install is reported as a false
			-- result rather than an error, so re-check the parser instead of the
			-- task's outcome; `language.add` returns nil rather than throwing.
			local function attach_after(task, buf, lang)
				task:await(function()
					vim.schedule(function()
						if vim.api.nvim_buf_is_valid(buf) and vim.treesitter.language.add(lang) then
							attach(buf, lang)
						end
					end)
				end)
			end

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
				callback = function(ev)
					-- `get_lang` falls back to returning the filetype itself, so
					-- plugin buffers (neo-tree, lazy, qf, ...) reach here too and
					-- are filtered by the `available` lookup.
					local lang = vim.treesitter.language.get_lang(ev.match)
					if not lang or not available[lang] then
						return
					end

					if vim.treesitter.language.add(lang) then
						attach(ev.buf, lang)
					elseif vim.list_contains(ENSURE_INSTALLED, lang) then
						attach_after(bootstrap, ev.buf, lang)
					else
						-- Replaces master's `auto_install = true`.
						attach_after(ts.install(lang), ev.buf, lang)
					end
				end,
			})
		end,
	},
}
