-- Installer for LSP servers, linters and formatters.
--
-- Lazy on cmd, not eager. The PATH guarantee lsp.lua's executable() gate relies on
-- comes from the dependency edge in lsp.lua (lazy.nvim loads dependencies before the
-- dependent), so mason.setup()'s PATH prepend still runs first. Eagerness was never
-- what provided it.

return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
			"MasonUpdate",
			"MasonToolsInstall",
			"MasonToolsInstallSync",
			"MasonToolsUpdate",
			"MasonToolsUpdateSync",
			"MasonToolsClean",
		},
		config = function()
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- Most mason packages are downloaded as prebuilt binaries, but a few are
			-- BUILT on install and need their language toolchain present. Asking for
			-- one without it fails on every single startup with a notification:
			-- gopls shells out to `go install`, so with no Go on the box mason logs
			-- `Could not find executable "go" in PATH` and retries forever.
			--
			-- Same executable() philosophy as lsp.lua's enable gate, applied at
			-- install time instead: request the package the moment its toolchain
			-- shows up, and stay quiet until then.
			local needs_toolchain = {
				gopls = "go",
			}

			local function installable(packages)
				local out = {}
				for _, pkg in ipairs(packages) do
					local need = needs_toolchain[pkg]
					if not need or vim.fn.executable(need) == 1 then
						out[#out + 1] = pkg
					end
				end
				return out
			end

			mason_tool_installer.setup({
				ensure_installed = installable({
					-- LSP servers
					"lua-language-server", -- Lua language server
					"rust-analyzer", -- Rust LSP (rustaceanvim starts it; see plugins/rustaceanvim.lua)
					"typescript-language-server", -- TypeScript/JavaScript LSP
					"tailwindcss-language-server", -- Tailwind CSS LSP (used in TS/JSX/HTML projects)
					"eslint-lsp", -- vscode-eslint-language-server; only attaches where an eslint config exists
					"clangd", -- C/C++ LSP
					"gopls", -- Go LSP
					"pyright", -- Python types
					"ruff", -- Python lints, import sorting and formatting (runs as `ruff server`)
					-- Formatters
					"stylua", -- Lua formatter
					"prettier", -- Web development formatter (JS/TS/CSS/HTML/JSON)
					"prettierd", -- Prettier daemon (faster, preferred by conform)
					-- Linters
					-- luacheck is consumed by `make lint`, not by the editor — there is no
					-- nvim-lint here. The Makefile puts this bin dir on $PATH to find it.
					"luacheck",
				}),
			})

			-- mason-tool-installer's auto-install runs from a VimEnter autocmd in its
			-- plugin/ dir. Loading on a file argument gets us in at BufReadPre, before
			-- VimEnter, so that fires normally; loading later (via :Mason) misses it
			-- entirely. Only run it by hand in the second case, or it double-runs.
			if vim.v.vim_did_enter == 1 then
				mason_tool_installer.run_on_start()
			end
		end,
	},
}
