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
					"alpha",
					"dashboard",
					"neo-tree",
					"nvim-tree",
					"Trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
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
			"<leader>is",
			function()
				require("snacks").image.hover()
			end,
			desc = "Show image at cursor",
		},
		{
			"<leader>gl",
			function()
				require("snacks").lazygit.log()
			end,
			desc = "LazyGit log (cwd)",
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
