-- mini.icons handles LSP/completion/file icons for mini-family plugins.
-- File-type icons in bufferline/telescope/lualine come from nvim-web-devicons
-- (see plugins/webdevicons.lua) — the preload mock that used to live here
-- shadowed the real plugin, so it's gone.
return {
	"nvim-mini/mini.icons",
	lazy = true,
	opts = function(_, opts)
		if vim.g.icons_enabled == false then
			opts.style = "ascii"
		end
	end,
	specs = {},
}
