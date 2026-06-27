-- ferris.nvim: rust-analyzer custom commands (expand macro, view HIR/MIR, etc).
-- Works alongside the existing standard rust-analyzer LSP setup in lsps/lsp.lua.
-- Commands are registered buffer-local on LspAttach when rust-analyzer attaches,
-- so the keymaps below are no-ops outside Rust buffers.
return {
	"vxpm/ferris.nvim",
	ft = "rust",
	opts = {
		create_commands = true,
	},
	keys = {
		{ "<leader>rm", "<cmd>FerrisExpandMacro<cr>", desc = "Rust: expand macro" },
		{ "<leader>rj", "<cmd>FerrisJoinLines<cr>", mode = { "n", "v" }, desc = "Rust: join lines" },
		{ "<leader>rh", "<cmd>FerrisViewHIR<cr>", desc = "Rust: view HIR" },
		{ "<leader>rl", "<cmd>FerrisViewMIR<cr>", desc = "Rust: view MIR" },
		{ "<leader>rs", "<cmd>FerrisViewMemoryLayout<cr>", desc = "Rust: view memory layout" },
		{ "<leader>rt", "<cmd>FerrisViewSyntaxTree<cr>", mode = { "n", "v" }, desc = "Rust: view syntax tree" },
		{ "<leader>ri", "<cmd>FerrisViewItemTree<cr>", desc = "Rust: view item tree" },
		{ "<leader>rc", "<cmd>FerrisOpenCargoToml<cr>", desc = "Rust: open Cargo.toml" },
		{ "<leader>rp", "<cmd>FerrisOpenParentModule<cr>", desc = "Rust: parent module" },
		{ "<leader>rd", "<cmd>FerrisOpenDocumentation<cr>", desc = "Rust: open documentation" },
		{ "<leader>rw", "<cmd>FerrisReloadWorkspace<cr>", desc = "Rust: reload workspace" },
		{ "<leader>rb", "<cmd>FerrisRebuildMacros<cr>", desc = "Rust: rebuild proc macros" },
	},
}
