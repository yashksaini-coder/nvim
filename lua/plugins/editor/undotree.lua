return {
	"mbbill/undotree",
	cmd = { "UndotreeToggle", "UndotreeShow" },
	keys = {
		{ "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
	},
	config = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_SplitWidth = 35
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
