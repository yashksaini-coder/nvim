-- ---------------------------------------------------------------------------
-- Minimal ToggleTerm bootstrap
-- ---------------------------------------------------------------------------
local ok, term = pcall(require, "toggleterm")
if not ok then
	vim.notify("toggleterm.nvim not found", vim.log.levels.ERROR)
	return
end

term.setup({
	size = function(term_)
		if term_.direction == "horizontal" then
			return 15
		elseif term_.direction == "vertical" then
			return math.floor(vim.o.columns * 0.3)
		else
			return nil -- float uses its own size
		end
	end,
	direction = "float",
	close_on_exit = true, -- Close terminal when job exits
	float_opts = {
		border = "single",
		width = math.floor(vim.o.columns * 0.6),
		height = math.floor(vim.o.lines * 0.6),
	},
	start_in_insert = true,
})

-- ---------------------------------------------------------------------------
-- Helper to open a terminal in a specific direction
-- ---------------------------------------------------------------------------
local function open_term(dir)
	local Terminal = require("toggleterm.terminal").Terminal
	Terminal:new({ direction = dir }):toggle()
end

-- ---------------------------------------------------------------------------
-- Key-maps (Normal mode only)
-- ---------------------------------------------------------------------------
vim.keymap.set("n", "<leader>tf", function()
	open_term("float")
end, { desc = "Terminal float" })

-- ---------------------------------------------------------------------------
-- Auto-commands: enter terminal → insert mode, leave → normal mode
-- ---------------------------------------------------------------------------
local grp = vim.api.nvim_create_augroup("TermBehaviour", { clear = true })

-- Configure terminal buffers when opened
vim.api.nvim_create_autocmd("TermOpen", {
	group = grp,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.cmd("startinsert")
	end,
})

-- Exit insert mode when leaving terminal buffer (only if buffer still exists)
vim.api.nvim_create_autocmd("BufLeave", {
	group = grp,
	pattern = "term://*",
	callback = function(event)
		-- Only run if the buffer still exists and is valid
		-- Use pcall to avoid errors if buffer is being deleted
		pcall(function()
			if vim.api.nvim_buf_is_valid(event.buf) then
				vim.cmd("stopinsert")
			end
		end)
	end,
})

-- Close all terminal buffers before quitting to avoid "Job still running" error
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = grp,
	callback = function()
		-- Close all terminal buffers to avoid "Job still running" error
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) then
				local buf_type = vim.api.nvim_get_option_value("buftype", { buf = buf })
				-- Check if it's a terminal buffer
				if buf_type == "terminal" then
					-- Force close terminal buffers (jobs will be killed)
					pcall(function()
						vim.api.nvim_buf_delete(buf, { force = true })
					end)
				end
			end
		end
	end,
})
