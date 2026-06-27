-- LeetCode in Neovim. First-time setup: run `:Leet` and sign in.
-- The :Leet command set replaces the old leetcode-specific commands.
return {
	"kawre/leetcode.nvim",
	cmd = "Leet",
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
	keys = {
		{ "<leader>L", "<cmd>Leet<cr>", desc = "LeetCode: open menu" },
		{ "<leader>Ll", "<cmd>Leet list<cr>", desc = "LeetCode: list problems" },
		{ "<leader>Lr", "<cmd>Leet run<cr>", desc = "LeetCode: run tests" },
		{ "<leader>Ls", "<cmd>Leet submit<cr>", desc = "LeetCode: submit" },
		{ "<leader>Ld", "<cmd>Leet daily<cr>", desc = "LeetCode: daily problem" },
		{ "<leader>LR", "<cmd>Leet reset<cr>", desc = "LeetCode: reset" },
	},
	opts = {
		-- C++ matches your boilerplate at utils/boilerplates/leetcode_boilerplate.cpp.
		lang = "cpp",
		injector = {
			["cpp"] = {
				before = { "#include <bits/stdc++.h>", "using namespace std;" },
			},
		},
	},
}
