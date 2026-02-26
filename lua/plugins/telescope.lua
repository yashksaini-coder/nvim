return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1", -- Use stable release
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
			local previewers = require("telescope.previewers")

			-- Custom buffer previewer maker with image support
			local function buffer_previewer_maker(filepath, bufnr, opts)
				opts = opts or {}

				local ok_snacks, snacks = pcall(require, "snacks")
				if ok_snacks and snacks.image and snacks.image.supports_file(filepath) then
					-- No vim.schedule — attach synchronously while bufnr is still valid
					if vim.api.nvim_buf_is_valid(bufnr) then
						local ok, err = pcall(snacks.image.buf.attach, bufnr, {
							src = filepath,
							auto_resize = true,
						})
						if ok then
							return
						else
							return print("Snacks image attach error: " .. err)
						end
					end
				end

				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			end

			telescope.setup({
				defaults = {
					-- Use custom previewer for images
					buffer_previewer_maker = buffer_previewer_maker,

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

			-- Workaround: Telescope's buffer previewer can hold refs to buffers that get
			-- wiped (e.g. when traversing find_files/oldfiles and going back). Guard
			-- win_set_buf_noautocmd so we never pass an invalid buffer id (E5108).
			local tele_utils = require("telescope.utils")
			local orig_win_set_buf = tele_utils.win_set_buf_noautocmd
			if orig_win_set_buf then
				tele_utils.win_set_buf_noautocmd = function(win_id, buf_id)
					if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
						return orig_win_set_buf(win_id, buf_id)
					end
					-- Invalid buffer (e.g. preview buffer was wiped): skip to avoid E5108
				end
			end
		end,
	},
}
