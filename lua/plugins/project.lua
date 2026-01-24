return {
	"nvim-telescope/telescope-project.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{ "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
	},
	config = function()
		require("telescope").load_extension("project")
	end,
}
