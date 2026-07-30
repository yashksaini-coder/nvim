-- Minimal statusline from mini.nvim family. Replaces lualine.
-- Zero-config defaults; icons come from mini.icons.
return {
	"nvim-mini/mini.statusline",
	event = "VeryLazy",
	dependencies = { "nvim-mini/mini.icons" },
	opts = {
		use_icons = true,
		set_vim_settings = true,
	},
}
