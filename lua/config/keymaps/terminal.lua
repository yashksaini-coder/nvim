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
	open_mapping = [[<C-\>]],
	direction = "float",
	float_opts = {
		border = "single",
		width = math.floor(vim.o.columns * 0.5),
		height = math.floor(vim.o.lines * 0.4),
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
vim.keymap.set("n", "<leader>th", function()
	open_term("horizontal")
end, { desc = "Terminal horizontal" })
vim.keymap.set("n", "<leader>tv", function()
	open_term("vertical")
end, { desc = "Terminal vertical" })
vim.keymap.set("n", "<leader>tf", function()
	open_term("float")
end, { desc = "Terminal float" })

-- ---------------------------------------------------------------------------
-- Auto-commands: enter terminal → insert mode, leave → normal mode
-- ---------------------------------------------------------------------------
local grp = vim.api.nvim_create_augroup("TermBehaviour", {})
vim.api.nvim_create_autocmd("TermOpen", {
	group = grp,
	command = "setlocal nonumber norelativenumber signcolumn=no | startinsert",
})
vim.api.nvim_create_autocmd("BufLeave", {
	group = grp,
	pattern = "term://*",
	command = "stopinsert",
})

