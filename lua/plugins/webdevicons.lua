-- File-type / language icons. Loaded as a real plugin so `require("nvim-web-devicons")`
-- resolves to the actual implementation instead of mini.icons's mock.
return {
	"nvim-tree/nvim-web-devicons",
	lazy = true,
	opts = {
		color_icons = true,
		default = true,
		strict = true,
	},
}
