-- ============================================================================
-- ToggleTerm - LazyVim-style Terminal Management
-- ============================================================================

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		-- Size configuration for different terminal directions
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end
		end,

		-- General settings
		open_mapping = [[<c-\>]],
		hide_numbers = true,
		shade_terminals = true,
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		persist_mode = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		auto_scroll = true,

		-- Float window configuration (LazyVim style)
		float_opts = {
			border = "curved",
			width = function()
				return math.floor(vim.o.columns * 0.8)
			end,
			height = function()
				return math.floor(vim.o.lines * 0.8)
			end,
			winblend = 3,
			zindex = 50,
			highlights = {
				border = "FloatBorder",
				background = "NormalFloat",
			},
		},

		-- Winbar configuration with terminal info
		winbar = {
			enabled = true,
			name_formatter = function(term)
				return string.format(" Terminal #%d ", term.id)
			end,
		},

		-- Highlights for better UI
		highlights = {
			Normal = {
				link = "Normal",
			},
			NormalFloat = {
				link = "NormalFloat",
			},
			FloatBorder = {
				link = "FloatBorder",
			},
		},

		-- Terminal window options
		on_create = function()
			vim.opt_local.foldcolumn = "0"
			vim.opt_local.signcolumn = "no"
		end,
	},

	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- Create specialized terminals (LazyVim style)
		local Terminal = require("toggleterm.terminal").Terminal

		-- Lazygit terminal
		_G.lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		-- Python REPL terminal
		_G.python = Terminal:new({
			cmd = "python3",
			direction = "float",
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.7)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.7)
				end,
			},
		})

		-- Node REPL terminal
		_G.node = Terminal:new({
			cmd = "node",
			direction = "float",
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.7)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.7)
				end,
			},
		})

		-- Btop system monitor
		_G.btop = Terminal:new({
			cmd = "btop",
			direction = "float",
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		-- Htop system monitor (fallback)
		_G.htop = Terminal:new({
			cmd = "htop",
			direction = "float",
			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})
	end,
}
