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
		require("nvim-ts-autotag").setup({
			opts = {
				-- Auto close tags when typing >
				enable_close = true,
				-- Auto rename pairs of tags (e.g., <div></div> -> <span></span>)
				enable_rename = true,
				-- Auto close on trailing </
				enable_close_on_slash = false,
			},
			-- Override individual filetype configs if needed
			-- Empty by default, useful if global settings don't work well in a specific filetype
			-- per_filetype = {
			-- 	-- Example: disable auto-close for HTML if needed
			-- 	-- ["html"] = {
			-- 	--   enable_close = false
			-- 	-- }
			-- },
		})
	end,
}

