-- Emacs-style compile buffer: one prompt, one scrollback, errors are hyperlinks.
-- Replaces the makeprg/quickfix loop in the old config/keymaps/compiler.lua and the
-- never-configured Zeioth/compiler.nvim.
-- Chosen over :make for one reason: `use_pseudo_terminal` hands the running program
-- a real tty, so scanf/cin block for input instead of reading EOF on the first call.

-- vim.g.compile_command is sticky for the whole session and wins over
-- default_command at the prompt. Clearing it first re-derives the command from the
-- buffer we are actually in — otherwise opening problem B and hitting compile
-- silently rebuilds problem A.
local function compile()
	vim.g.compile_command = nil
	vim.cmd("Compile")
end

-- Run the binary the last build produced, without rebuilding. The CP loop is one
-- build and many runs against different inputs; Recompile reruns the whole g++ chain.
local function run_last()
	local bin = "./" .. vim.fn.shellescape("bin/" .. vim.fn.expand("%:t:r"))
	vim.api.nvim_cmd({ cmd = "Compile", args = { bin } }, {})
end

-- Compile history. Kept in an ALL-CAPS global so shada persists it across sessions
-- for free (`!` is in Neovim's default 'shada'); no file IO, no load/save.
local function history()
	local hist = vim.g.COMPILE_HISTORY or {}
	if vim.tbl_isempty(hist) then
		vim.notify("No compile history", vim.log.levels.INFO)
		return
	end
	-- snacks.picker owns vim.ui.select in this config (picker.ui_select defaults true),
	-- so this is already a fuzzy picker without hand-rolling a telescope one.
	vim.ui.select(hist, { prompt = "Compile history" }, function(cmd)
		if not cmd then
			return
		end
		-- nvim_cmd, not vim.cmd("Compile " .. cmd): a command string splits on `|`,
		-- and these commands pipe — `./bin/sol < in.txt | diff - out.txt`.
		vim.api.nvim_cmd({ cmd = "Compile", args = { cmd } }, {})
	end)
end

return {
	"ej-shafran/compile-mode.nvim",
	version = "^5.0.0", -- upstream's own recommendation; majors break config
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Pinned to the tag upstream pins. Decodes ANSI so g++/cargo output isn't [0m soup.
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	cmd = { "Compile", "Recompile" },
	keys = {
		{ "<leader>mm", compile, desc = "Compile (prompt)" },
		{ "<leader>mr", "<cmd>Recompile<cr>", desc = "Recompile (last command)" },
		{ "<leader>mh", history, desc = "Compile history" },
		{ "<leader>mq", "<cmd>QuickfixErrors<cr>", desc = "Compile errors to quickfix" },
		{ "<leader>mx", run_last, desc = "Run last build (no rebuild)" },
		-- F5/F6/F8 kept for muscle memory. F7 is gone: the compilation buffer already
		-- binds <C-q> for quickfix.
		{ "<F5>", "<cmd>Recompile<cr>", desc = "Recompile" },
		{ "<F6>", compile, desc = "Compile (prompt)" },
		{ "<F8>", run_last, desc = "Run last build (no rebuild)" },
	},
	-- Options go in init(), not config(): lazy.nvim runs init() at startup, so
	-- vim.g.compile_mode is set no matter which module ends up requiring the
	-- plugin's config first. It is a plain table assignment — nothing loads here.
	init = function()
		---@type CompileModeOpts
		vim.g.compile_mode = {
			-- The whole point of the switch. Without a pty the program's stdin is closed
			-- and cin/scanf hit EOF immediately.
			use_pseudo_terminal = true,
			-- Load-bearing for stdin: the `i` binding below is buffer-local to the
			-- compilation buffer. Without focus you would have to <C-w>w to reach it
			-- while the program sits blocked on cin.
			focus_compilation_buffer = true,
			baleia_setup = true,
			recompile_no_fail = true, -- <F5> in a fresh session prompts instead of erroring
			max_lines = 5000, -- plugin trims its own buffer; a runaway loop can't eat the editor
			input_word_completion = true,
			environment = { MANPAGER = "col -b", PAGER = "col -b" },
			-- `bang_expansion` stays off: it runs expandcmd() against whatever buffer is
			-- current, so :Recompile from inside *compilation* would expand % to the
			-- compilation buffer's name. Expand here instead, once, while the source
			-- buffer is still current.
			default_command = function(ft)
				local file = vim.fn.shellescape(vim.fn.expand("%"))
				local out = vim.fn.shellescape("bin/" .. vim.fn.expand("%:t:r"))
				if ft == "cpp" then
					return ("mkdir -p bin && g++ -Wall -g -o %s %s && ./%s"):format(out, file, out)
				elseif ft == "c" then
					return ("mkdir -p bin && gcc -Wall -g -o %s %s && ./%s"):format(out, file, out)
				end
				return "make -k "
			end,
		}
	end,
	config = function()
		-- Recorded on finish, not by wrapping the prompt, so `:Compile <cmd>` typed
		-- straight into the cmdline and :Recompile land in history too.
		vim.api.nvim_create_autocmd("User", {
			pattern = "CompilationFinished",
			callback = function(ev)
				local cmd = ev.data and ev.data.command
				if not cmd or cmd == "" then
					return
				end
				local hist = vim.tbl_filter(function(v)
					return v ~= cmd
				end, vim.g.COMPILE_HISTORY or {})
				table.insert(hist, 1, cmd)
				-- ponytail: shada caps each item at 10 KiB ('shada' s10), hence 100 entries
				-- and not 10000. Move to a file under stdpath("data") if that ever bites.
				vim.g.COMPILE_HISTORY = vim.list_slice(hist, 1, 100)
			end,
		})

		-- The plugin's ftplugin already binds <cr> (goto error), <C-q>, <C-c>, <C-r>,
		-- q and Tab/S-Tab. stdin is the only thing it doesn't cover. <C-d> is left
		-- alone deliberately — it is half-page scroll, and this buffer is a scrollback.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "compilation",
			callback = function(ev)
				-- `i` is free here: the buffer is unmodifiable, so insert mode is useless.
				vim.keymap.set("n", "i", function()
					local job = vim.g.compile_job_id
					if not job then
						vim.notify("No running compilation", vim.log.levels.WARN)
						return
					end
					local ok, line = pcall(vim.fn.input, "stdin> ")
					if not ok then
						return
					end
					-- Empty line means EOF: on a pty the line discipline turns 0x04 into
					-- EOF for the reader, which is what `while (cin >> x)` needs to stop.
					-- chansend rather than chanclose — closing the master fd would tear
					-- the job down instead of signalling end-of-input.
					vim.fn.chansend(job, line == "" and "\4" or line .. "\n")
				end, { buffer = ev.buf, silent = true, desc = "Send a line to stdin (empty = EOF)" })
			end,
		})
	end,
}
