return {
	"folke/twilight.nvim",
	cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	keys = { { "<leader>uT", "<cmd>Twilight<cr>", desc = "Twilight (dim inactive code)" } },
	opts = { context = 10, treesitter = true },
}
