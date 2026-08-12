-- Diagnostic Configuration
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 2 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	severity_sort = true,
	update_in_insert = false,
	float = {
		border = "rounded",
		focusable = true,
		source = true,
	},
})

-- The previous vim.lsp.util.open_floating_preview monkey-patch is gone. On
-- Neovim 0.11+ hover/signature use vim.lsp.buf.hover / signature_help, and
-- the diagnostic float border above covers the rest. Add per-callsite
-- `border = "rounded"` if you ever drop below 0.11.

-- Show line diagnostics in a float. Placed under <leader>x (trouble/diagnostics)
-- because <leader>d* was the DAP prefix and a leaf on <leader>d added
-- timeoutlen delay before DAP subkeys.
vim.keymap.set("n", "<leader>xd", function()
	vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Show line diagnostics" })
