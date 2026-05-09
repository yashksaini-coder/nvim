return {
	"NickvanDyke/opencode.nvim",
	dependencies = { "folke/snacks.nvim" },
	cmd = { "Opencode", "OpencodeAsk", "OpencodeToggle" },
	opts = {
		port = 4096,
		auto_reload = true,
		terminal = { auto_insert = true, win = { position = "right", width = 0.4 } },
	},
	keys = {
		{ "<leader>io", "<cmd>OpencodeToggle<cr>", desc = "OpenCode: toggle" },
		{
			"<leader>ia",
			function()
				require("opencode").ask("@buffer ")
			end,
			desc = "OpenCode: ask about buffer",
		},
		{
			"<leader>iA",
			function()
				require("opencode").ask("@selection ")
			end,
			mode = "v",
			desc = "OpenCode: ask about selection",
		},
		{
			"<leader>iN",
			function()
				require("opencode").command("session_new")
			end,
			desc = "OpenCode: new session",
		},
	},
}
