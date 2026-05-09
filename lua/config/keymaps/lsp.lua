local map = vim.keymap.set

-- Hover & navigation
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Goto type definition" })

-- Signature help (insert + normal)
map({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Symbols
map("n", "<leader>fS", function()
	require("telescope.builtin").lsp_document_symbols()
end, { desc = "Document symbols" })
map("n", "<leader>fW", function()
	require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "Workspace symbols" })

-- Call hierarchy
map("n", "<leader>gci", function()
	require("telescope.builtin").lsp_incoming_calls()
end, { desc = "Incoming calls" })
map("n", "<leader>gco", function()
	require("telescope.builtin").lsp_outgoing_calls()
end, { desc = "Outgoing calls" })

-- Refactor
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Diagnostics navigation
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

-- Inlay hints toggle
map("n", "<leader>uh", function()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
	vim.notify("Inlay hints " .. (enabled and "OFF" or "ON"))
end, { desc = "Toggle inlay hints" })

-- Format (delegates to conform via <leader>fm; this is convenience over LSP only)
map({ "n", "v" }, "<leader>cf", function()
	vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
end, { desc = "Format buffer (LSP)" })
