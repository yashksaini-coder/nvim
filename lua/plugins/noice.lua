return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- opts absorbed from the deleted standalone plugins/notify.lua: a top-level
		-- fragment cleared lazy.nvim's dep flag and made nvim-notify load eagerly.
		{ "rcarriga/nvim-notify", opts = { background_colour = "#3d3c3cff" } },
	},
	opts = {
		-- I. PRESETS ---------------------------
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true, -- <--- Ensures LSP docs (Signature/Hover) have a border
		},

		-- II. POSITIONING (Fixing Completion Menu Overlap) ----------------
		views = {
			cmdline_popup = {
				position = {
					row = 5,
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			popupmenu = {
				-- Key Fix: Remove fixed positioning (row/col/relative)
				-- This allows Noice/Cmp to intelligently position the menu
				-- above or below the cursor based on screen space.
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					-- Use Pmenu/PmenuSel for better visual integration
					winhighlight = { Normal = "Pmenu", FloatBorder = "Pmenu" },
				},
			},
			-- No `documentation` entry here: noice looks views up BY NAME and
			-- `lsp.documentation.view` is the string "hover", so a view called
			-- "documentation" is never read. Hover and signature help render in the
			-- cursor-anchored `hover` view, bordered by the lsp_doc_border preset.
			-- To resize them, override `lsp.documentation.opts`, not `views`.
		},

		-- III. LSP OVERRIDES -----------------------
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				-- CRITICAL: MUST be false. Setting this to true would make Noice draw
				-- a separate doc window *next to* the cmp menu, causing overlap.
				["cmp.entry.get_documentation"] = false,
			},
		},

		-- IV. ROUTES -------------------------------
		-- A route with no `view` is how noice spells "skip": router.lua turns
		-- `view == nil` into `opts.skip = true`. This one swallows the
		-- `"file.lua" 42L, 1024B written` message on every save. Do NOT delete it
		-- thinking it is dead — deleting it brings the write spam back.
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = {},
			},
		},
	},
}
