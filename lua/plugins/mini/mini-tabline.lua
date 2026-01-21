return {
	"nvim-mini/mini.tabline",
	version = "*",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("mini.tabline").setup({
			-- Whether to show file icons (requires 'mini.icons')
			show_icons = true,

			-- Function which formats the tab label
			-- By default surrounds with space and possibly prepends with icon
			format = nil,

			-- Whether to set Vim's settings for tabline (make it always shown and
			-- allow hidden buffers)
			set_vim_settings = true,

			-- Where to show tabpage section in case of multiple vim tabpages.
			-- One of 'left', 'right', 'center'. If set to 'right', also sets
			-- 'tabline' to be at the right edge.
			tabpage_section = "left",
		})
	end,
}
