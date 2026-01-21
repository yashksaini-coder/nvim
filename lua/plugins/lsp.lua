return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Diagnostic configuration
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			severity_sort = true,
			float = {
				border = "rounded",
				focusable = true,
				source = true,
			},
		})

		-- LSP floating windows use default borders

		vim.lsp.config("lua_ls", require("lsps.lua_ls"))
		vim.lsp.config("ts_ls", require("lsps.ts_ls"))
		vim.lsp.config("ruby-lsp", require("lsps.ruby_lsp"))

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
		vim.lsp.enable("zls")
		vim.lsp.enable("sourcekit")

		vim.keymap.set("n", "<C-i>", vim.lsp.buf.definition, { desc = "Goto definition" })
		vim.keymap.set("n", "<S-l>", vim.lsp.buf.hover, { desc = "Define the keyword under cursor" })
	end,
}

