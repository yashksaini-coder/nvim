-- Diagnostic Configuration
vim.diagnostic.config({
	-- End-of-line one-liner. Kept for at-a-glance on non-cursor lines.
	virtual_text = { prefix = "●", spacing = 2 },
	-- Nvim 0.11+: full diagnostic rendered inline BELOW the current line —
	-- shows automatically as the cursor moves, no float, no waiting.
	virtual_lines = { current_line = true },
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

-- Toggle the inline virtual_lines view (handy when it feels noisy on
-- dense error lists — flips to end-of-line-only).
vim.keymap.set("n", "<leader>xv", function()
	local cur = vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = not cur and { current_line = true } or false })
end, { desc = "Toggle inline virtual diagnostic" })

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
