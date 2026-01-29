-- ============================================================================
-- LazyVim-style Terminal Keymaps
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Helper Functions
-- ---------------------------------------------------------------------------

-- Open terminal in specific direction
local function open_term(dir, size)
	local Terminal = require("toggleterm.terminal").Terminal
	local term_config = { direction = dir }

	if size then
		term_config.size = size
	end

	Terminal:new(term_config):toggle()
end

-- Toggle lazygit terminal
local function toggle_lazygit()
	if _G.lazygit then
		_G.lazygit:toggle()
	else
		vim.notify("Lazygit terminal not initialized", vim.log.levels.WARN)
	end
end

-- Toggle Python REPL
local function toggle_python()
	if _G.python then
		_G.python:toggle()
	else
		vim.notify("Python terminal not initialized", vim.log.levels.WARN)
	end
end

-- Toggle Node REPL
local function toggle_node()
	if _G.node then
		_G.node:toggle()
	else
		vim.notify("Node terminal not initialized", vim.log.levels.WARN)
	end
end

-- Toggle system monitor
local function toggle_system_monitor()
	-- Try btop first, fall back to htop
	if _G.btop then
		_G.btop:toggle()
	elseif _G.htop then
		_G.htop:toggle()
	else
		vim.notify("System monitor not available", vim.log.levels.WARN)
	end
end

-- Send lines to terminal
local function send_lines_to_term()
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local text = table.concat(lines, "\n")

	require("toggleterm").exec(text)
end

-- ---------------------------------------------------------------------------
-- Terminal Navigation Keymaps (All modes)
-- ---------------------------------------------------------------------------

-- Basic terminal toggle (Ctrl+\)
vim.keymap.set({ "n", "t" }, [[<C-\>]], "<cmd>ToggleTerm<CR>", {
	desc = "Toggle terminal",
	silent = true,
})

-- Better terminal navigation in terminal mode
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move to bottom window" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move to top window" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move to right window" })

-- Escape terminal mode
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Window command in terminal" })

-- ---------------------------------------------------------------------------
-- Terminal Open Keymaps (Normal mode - <leader>t prefix)
-- ---------------------------------------------------------------------------

-- Standard terminals
vim.keymap.set("n", "<leader>tf", function()
	open_term("float")
end, { desc = "Terminal (float)" })

vim.keymap.set("n", "<leader>th", function()
	open_term("horizontal")
end, { desc = "Terminal (horizontal)" })

vim.keymap.set("n", "<leader>tv", function()
	open_term("vertical")
end, { desc = "Terminal (vertical)" })

-- Specialized terminals
vim.keymap.set("n", "<leader>gg", toggle_lazygit, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>tp", toggle_python, { desc = "Python REPL" })
vim.keymap.set("n", "<leader>tn", toggle_node, { desc = "Node REPL" })
vim.keymap.set("n", "<leader>tm", toggle_system_monitor, { desc = "System Monitor" })

-- Terminal management
vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals" })
vim.keymap.set("n", "<leader>ts", "<cmd>TermSelect<CR>", { desc = "Select terminal" })

-- Send to terminal
vim.keymap.set("v", "<leader>ts", send_lines_to_term, { desc = "Send to terminal" })

-- ---------------------------------------------------------------------------
-- Terminal Numbered Access (Quick toggle terminals 1-4)
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm<CR>", { desc = "Terminal 1" })
vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm<CR>", { desc = "Terminal 2" })
vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm<CR>", { desc = "Terminal 3" })
vim.keymap.set("n", "<leader>t4", "<cmd>4ToggleTerm<CR>", { desc = "Terminal 4" })

-- ---------------------------------------------------------------------------
-- Auto-commands: LazyVim-style Terminal Behavior
-- ---------------------------------------------------------------------------
local grp = vim.api.nvim_create_augroup("LazyVimTerminal", { clear = true })

-- Configure terminal buffers when opened
vim.api.nvim_create_autocmd("TermOpen", {
	group = grp,
	pattern = "term://*",
	callback = function()
		local opts = { buffer = 0 }

		-- Disable UI elements
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.foldcolumn = "0"
		vim.opt_local.spell = false

		-- Start in insert mode
		vim.cmd("startinsert")

		-- Terminal-specific keymaps
		vim.keymap.set("t", "<C-]>", [[<C-\><C-n>]], opts)
	end,
})

-- Automatically enter insert mode when entering terminal buffer
vim.api.nvim_create_autocmd("BufEnter", {
	group = grp,
	pattern = "term://*",
	callback = function()
		vim.cmd("startinsert")
	end,
})

-- Exit insert mode when leaving terminal buffer
vim.api.nvim_create_autocmd("BufLeave", {
	group = grp,
	pattern = "term://*",
	callback = function(event)
		pcall(function()
			if vim.api.nvim_buf_is_valid(event.buf) then
				vim.cmd("stopinsert")
			end
		end)
	end,
})

-- Clean terminal windows on close
vim.api.nvim_create_autocmd("TermClose", {
	group = grp,
	pattern = "term://*",
	callback = function(event)
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(event.buf) then
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end
		end)
	end,
})

-- Close all terminal buffers before quitting
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = grp,
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) then
				local buf_type = vim.api.nvim_get_option_value("buftype", { buf = buf })
				if buf_type == "terminal" then
					pcall(vim.api.nvim_buf_delete, buf, { force = true })
				end
			end
		end
	end,
})
