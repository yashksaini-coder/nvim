return {
	"echasnovski/mini.completion",
	version = "*",
	event = "InsertEnter",
	config = function()
		require("mini.completion").setup({
			-- Completion delays (ms)
			-- Optimized delays for responsive auto-completion
			delay = {
				completion = 300, -- Auto-trigger completion after 300ms of inactivity
				info = 200, -- Show completion item info after 200ms
				signature = 50, -- Fast signature help for function parameters
			},

			-- Window configuration for completion UI
			window = {
				-- Info window for completion item details
				info = {
					height = 15,
					width = 60,
					border = "rounded",
				},
				-- Signature help window
				signature = {
					height = 25,
					width = 80,
					border = "rounded",
				},
			},

			-- LSP code completion configuration
			lsp_completion = {
				source_func = "completefunc",
				auto_setup = true,
				-- Process completion items for better sorting and filtering
				process_items = function(items, base)
					-- Sort by LSP priority and relevance
					table.sort(items, function(a, b)
						local priority_a = a.sortText or a.label
						local priority_b = b.sortText or b.label
						return priority_a < priority_b
					end)
					return items
				end,
			},

			-- Essential key mappings
			mappings = {
				force_twostep = "<C-Space>", -- Manually trigger completion
				force_fallback = "<A-Space>", -- Force fallback completion
				scroll_down = "<C-f>", -- Scroll info window down
				scroll_up = "<C-b>", -- Scroll info window up
			},

			-- Set completion options for better UX
			set_vim_settings = true, -- Automatically set vim completion options
		})
	end,
}
