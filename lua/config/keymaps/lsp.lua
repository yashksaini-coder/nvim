-- LSP keymaps — buffer-local via LspAttach so they only exist where an LSP
-- client is actually attached (no dead keys in plain-text buffers).
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
	callback = function(args)
		local buf = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "<leader>gd", vim.lsp.buf.definition, "Goto definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
		map("n", "<leader>gr", vim.lsp.buf.references, "References")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map({ "i", "s" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")

		map("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, "Prev diagnostic")
		map("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, "Next diagnostic")
	end,
})
