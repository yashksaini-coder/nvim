-- Diagnostics/symbols/LSP panel. Every mapping lives in config/keymaps/trouble.lua
-- as <cmd>Trouble …<cr>, so lazy's stub command loads the plugin and re-runs the
-- call — the keymaps do not need to move into this spec.
return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
}
