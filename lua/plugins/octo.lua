-- octo.nvim — GitHub issues and pull requests inside Neovim. `:Octo review
-- start` opens the "Files changed" panel (per-file line counts + diffstat bars)
-- for a PR. The local-changes equivalent is diffview.nvim; the two do not
-- overlap — diffview cannot see PRs, octo cannot see the uncommitted tree.
--
-- Requires the `gh` CLI, authenticated (`gh auth status`).
return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Octo",
	keys = {
		{ "<leader>go", "<cmd>Octo<cr>", desc = "Octo: command palette" },
		{ "<leader>gp", "<cmd>Octo pr list<cr>", desc = "Octo: pull requests" },
		{ "<leader>gi", "<cmd>Octo issue list<cr>", desc = "Octo: issues" },
	},
	opts = {
		-- Telescope is this config's primary finder (all the <leader>f maps).
		picker = "telescope",
		-- Makes a bare `:Octo` open a picker of every Octo command.
		enable_builtin = true,
		mappings = {
			pull_request = {
				-- Upstream's only <leader> map among otherwise all-<localleader>
				-- PR maps. Its default <leader>qa shadows this config's
				-- <leader>q = :qa, so in a PR buffer <leader>q would stall for
				-- timeoutlen and <leader>q,a would approve the PR for real.
				approve_pr = { lhs = "<localleader>pa", desc = "approve PR" },
			},
		},
	},
}
