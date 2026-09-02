-- Comment.nvim is gone: Neovim 0.11+ ships gc/gcc/gc{motion} natively, and the
-- built-in resolves 'commentstring' from treesitter capture metadata — so JSX/TSX
-- comments come out as {/* … */} without a context-commentstring plugin.
-- What that loses: gb/gbc blockwise comments and gco/gcO/gcA. Nothing here uses them.
return {
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
}
