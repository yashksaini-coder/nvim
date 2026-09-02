return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Image viewer configuration
		image = {
			enabled = true,
			formats = {
				"png",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
			},
			doc = {
				enabled = true,
				inline = true,
				float = true,
				max_width = 80,
				max_height = 40,
				conceal = function(type)
					return type == "math"
				end,
			},
			wo = {
				wrap = false,
				number = false,
				relativenumber = false,
				cursorcolumn = false,
				signcolumn = "no",
				foldcolumn = "0",
				list = false,
				spell = false,
				statuscolumn = "",
			},
			math = {
				enabled = true,
				latex = {
					font_size = "Large",
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
				},
			},
			icons = {
				math = "󰪚 ",
				chart = "󰄧 ",
				image = " ",
			},
		},
		-- Skips syntax, treesitter and LSP on huge files so opening one doesn't hang.
		bigfile = { enabled = true },
		-- Renders the file from the command line before plugins finish loading.
		quickfile = { enabled = true },
		-- picker powers <leader>fp (recent projects). Tree lives in neo-tree.
		picker = { enabled = true },
		-- Flag-only: enabling explorer flips snacks.dashboard's `skip` branch,
		-- which is what lets the dashboard render on `nvim .`. But turn off
		-- replace_netrw so snacks doesn't ALSO hijack the directory buffer
		-- and open its own explorer alongside neo-tree.
		explorer = { enabled = true, replace_netrw = false },
		-- Minimal start screen — just a handful of key hints. No ASCII logo,
		-- no plugin-load banner, no long button list. Replaces dashboard-nvim.
		dashboard = {
			enabled = true,
			width = 55,
			preset = {
				keys = {
					{ icon = "󰉋 ", key = "e", desc = "File Explorer", action = ":Neotree toggle" },
					{ icon = "󰈞 ", key = "f", desc = "Find Files", action = ":Telescope find_files" },
					{ icon = "󰭎 ", key = "g", desc = "Live Grep", action = ":Telescope live_grep" },
					{ icon = "󱋢 ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
					{ icon = "󰋚 ", key = "p", desc = "Recent Projects", action = ":lua Snacks.picker.projects()" },
					{
						icon = "󰋖 ",
						key = "k",
						desc = "Keymap Docs",
						action = ":lua vim.ui.open('https://yashksaini-coder.github.io/nvim/')",
					},
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = "󰗼 ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "keys", padding = 4, gap = 1 },
				{
					padding = 2,
					text = {
						{ "leader = ", hl = "SnacksDashboardDir" },
						{ "<Space>", hl = "SnacksDashboardKey" },
						{ "  ·  press ", hl = "SnacksDashboardDir" },
						{ "<leader>?", hl = "SnacksDashboardKey" },
						{ " for the full keymap", hl = "SnacksDashboardDir" },
					},
				},
			},
		},
		-- Indent guides (merged from mini-indentscope — was a separate snacks.nvim spec)
		indent = {
			enabled = true,
			char = "│",
			only_scope = false,
			only_current = false,
			hl = "SnacksIndent",
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "linear",
				duration = {
					step = 20,
					total = 500,
				},
			},
			scope = {
				enabled = true,
				char = "│",
				underline = false,
				only_current = false,
				hl = "SnacksIndentScope",
			},
			chunk = {
				enabled = false,
			},
			filter = function(buf)
				local exclude_ft = {
					"help",
					"snacks_dashboard",
					"snacks_picker_list",
					"Trouble",
					"lazy",
					"mason",
					"notify",
				}
				local ft = vim.bo[buf].filetype
				for _, exclude in ipairs(exclude_ft) do
					if ft == exclude then
						return false
					end
				end
				return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
			end,
		},
	},
	keys = {
		{
			"<leader>gg",
			function()
				require("snacks").lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>fp",
			function()
				require("snacks").picker.projects()
			end,
			desc = "Recent Projects",
		},
		{
			"<leader>is",
			function()
				require("snacks").image.hover()
			end,
			desc = "Show image at cursor",
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "image",
			callback = function()
				vim.bo.bufhidden = "wipe"
			end,
		})
	end,
}
