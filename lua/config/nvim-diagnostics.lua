-- Diagnostic Configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	severity_sort = true,
	update_in_insert = true, -- Ensure diagnostics update in insert mode
	float = {
		border = "rounded",
		focusable = true,
		source = true,
	},
})

-- Override floating preview to ensure borders and size
local _open_floating_preview = vim.lsp.util.open_floating_preview
vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded" -- Using rounded instead of double for consistency
	opts.max_width = opts.max_width or 80
	opts.max_height = opts.max_height or 20
	return _open_floating_preview(contents, syntax, opts, ...)
end

-- LSP Floating Window Borders (Redundant with the override above but good for safety)
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

-- Disable all diagnostics for Rust files (krust.nvim handles it)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		-- Disable all diagnostic displays for rust buffers
		vim.diagnostic.config({
			virtual_text = false,
			signs = false,
			underline = false,
			float = false,
		})
	end,
})

-- Auto-show diagnostics on hover (only in normal mode, not during completion, skip Rust)
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		-- Skip Rust files (krust.nvim handles diagnostics)
		if vim.bo.filetype == "rust" then
			return
		end
		-- Don't show diagnostics during insert mode (when completion might be active)
		if vim.api.nvim_get_mode().mode == "i" then
			return
		end
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always",
			prefix = " ",
			scope = "cursor",
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})

-- Keymap to show diagnostics (skip for Rust files)
vim.keymap.set("n", "<leader>d", function()
	if vim.bo.filetype == "rust" then
		return
	end
	vim.diagnostic.open_float(nil, { border = "rounded" })
end, { desc = "Show diagnostics" })