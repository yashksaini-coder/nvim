-- diffview.nvim — a "changed files" panel with per-file line counts, for local
-- work: the working tree, the index, or any git rev. octo.nvim
-- (lua/plugins/octo.lua) shows an equivalent panel for a GitHub PR; this is the
-- offline half and needs no network. Octo's panel is derived from this plugin's,
-- but only octo draws the diffstat as a bar — diffview prints `+N, -M`.
return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewFileHistory",
		"DiffviewRefresh",
	},
	keys = {
		-- <leader>gd/<leader>gr are LSP goto (config/keymaps/lsp.lua) and
		-- <leader>gg is lazygit, so these take the free letters.
		{ "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: changed files" },
		{ "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo history" },
		{
			"<leader>gf",
			function()
				-- `%` expands to nothing useful in the dashboard, the explorer or a
				-- scratch buffer, and DiffviewFileHistory then errors out.
				if vim.bo.buftype ~= "" or vim.fn.expand("%") == "" then
					vim.notify("No file here — <leader>gh for repo history", vim.log.levels.WARN)
					return
				end
				vim.cmd("DiffviewFileHistory %")
			end,
			desc = "Diffview: current file history",
		},
	},
	opts = {
		-- Brighter add/delete highlighting; without it the diff reads much
		-- flatter than the side-by-side view this was modelled on.
		enhanced_diff_hl = true,
		keymaps = {
			-- diffview maps <leader>b to toggle_files in all three panels, which
			-- would swallow this config's whole <leader>b barbar prefix (bd, bp,
			-- bo, bb, b1..b9) inside any diff. Close with <leader>gV instead.
			-- <leader>e (focus file panel) is left alone on purpose: inside a
			-- diff it is the direct analogue of <leader>e opening the explorer.
			view = { { "n", "<leader>b", false } },
			file_panel = { { "n", "<leader>b", false } },
			file_history_panel = { { "n", "<leader>b", false } },
		},
	},
}
