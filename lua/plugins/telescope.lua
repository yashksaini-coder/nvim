return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.0", -- Use stable release
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Native fzf sorter for performance
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Treesitter for syntax highlighting in previews
			"nvim-treesitter/nvim-treesitter",
			-- Snacks for image preview
			"folke/snacks.nvim",
		},
		keys = {
			-- File operations
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fR", "<cmd>Telescope oldfiles only_cwd=true<cr>", desc = "Recent files (cwd)" },

			-- Search operations
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string" },

			-- Navigation
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },

			-- Quick access (no leader)
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					-- File ignore patterns
					file_ignore_patterns = { "node_modules", ".git/" },
					
					-- Better UI
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							preview_width = 0.55,
							width = 0.87,
							height = 0.80,
						},
					},
					
					-- Keybindings
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<esc>"] = actions.close,
						},
					},
					
					-- Preview configuration
					preview = {
						treesitter = false, -- Disable to prevent ft_to_lang errors
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = false,
						follow = true,
					},
				},
			})

			-- Load extensions safely with pcall
			pcall(telescope.load_extension, "fzf")
		end,
	},
}
