-- Trimmed to the only two rust-analyzer requests rustaceanvim does not implement:
-- viewRecursiveMemoryLayout and viewItemTree. Everything else ferris exposed is a
-- :RustLsp subcommand now — and FerrisViewSyntaxTree was dead regardless: it still
-- sends "rust-analyzer/syntaxTree", which upstream renamed to viewSyntaxTree.
-- No opts, so setup() never runs: no LspAttach hook racing rustaceanvim's, no
-- :Ferris* commands. The methods are plain functions and work on their own.
return {
	"vxpm/ferris.nvim",
	keys = {
		{
			"<leader>rM",
			function()
				require("ferris.methods.view_memory_layout")()
			end,
			ft = "rust",
			desc = "Rust: view memory layout",
		},
		{
			"<leader>rI",
			function()
				require("ferris.methods.view_item_tree")()
			end,
			ft = "rust",
			desc = "Rust: view item tree",
		},
	},
}
