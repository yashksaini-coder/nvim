return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Image viewer configuration
		image = {
			enabled = true,
			-- Supported image formats
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
			-- Document image rendering
			doc = {
				enabled = true, -- enable image viewer for documents
				inline = true, -- render images inline in the buffer
				float = true, -- render in floating window if inline is not supported
				max_width = 80,
				max_height = 40,
				-- Conceal image text when rendering inline
				conceal = function(type)
					-- Only conceal math expressions
					return type == "math"
				end,
			},
			-- Window options for image buffers
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
			-- Math expression rendering
			math = {
				enabled = true,
				-- LaTeX configuration
				latex = {
					font_size = "Large",
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
				},
			},
			-- Icons for inline image indicators
			icons = {
				math = "󰪚 ",
				chart = "󰄧 ",
				image = " ",
			},
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
		}
	},
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Auto-show images when opening image files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "image",
			callback = function()
				vim.bo.bufhidden = "wipe"
			end,
		})
	end,
}
