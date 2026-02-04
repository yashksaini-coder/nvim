return {
	"neovim/nvim-lspconfig",
	config = function()
		-- LSP floating windows use default borders

		vim.lsp.config("lua_ls", require("lsps.lua_ls"))
		vim.lsp.config("ts_ls", require("lsps.ts_ls"))
		vim.lsp.config("ruby-lsp", require("lsps.ruby_lsp"))
		vim.lsp.config("omnisharp", require("lsps.csharp"))

		vim.lsp.enable("pylsp")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("clangd")
		vim.lsp.enable("gopls")
		vim.lsp.enable("ts_ls")
		vim.lsp.enable("tailwindcss")
		vim.lsp.enable("phpactor")
		vim.lsp.enable("dartls")
		vim.lsp.enable("ocamllsp")
		vim.lsp.enable("ruby-lsp")
		vim.lsp.enable("omnisharp")
		vim.lsp.enable("zls")
		vim.lsp.enable("sourcekit")

		vim.keymap.set("n", "<C-i>", vim.lsp.buf.definition, { desc = "Goto definition" })
		-- K for hover is set in config/keymaps/lsp.lua; <S-l> reserved for bufferline next
	end,
}
