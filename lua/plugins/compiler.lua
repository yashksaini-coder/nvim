-- Simple native C/C++ compiler using Neovim's built-in features
-- No external plugins needed, uses :make and quickfix list

return {
	"Zeioth/compiler.nvim",
	-- Optional: telescope for nice UI (but not required)
	dependencies = { "nvim-telescope/telescope.nvim" },
}
