return {
	"windwp/nvim-ts-autotag",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	ft = {
		"html",
		"javascript",
		"jsx",
		"typescript",
		"tsx",
		"svelte",
		"vue",
		"xml",
		"markdown",
		"php",
		"astro",
		"glimmer",
		"handlebars",
		"liquid",
		"rescript",
		"twig",
	},
	config = function()
		-- nvim-ts-autotag v0.4+ expects options at the top level of setup(), not nested under `opts`.
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		})
	end,
}
