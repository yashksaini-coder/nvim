return {
	"echasnovski/mini.completion",
	version = "*",
	event = "InsertEnter",
	config = function()
		require("mini.completion").setup({
			-- Completion delays (ms)
			-- Set completion delay very high to disable auto-completion
			-- Completion will ONLY appear when you press <C-Space> manually
			delay = {
				completion = 10 ^ 7, -- Effectively disable auto-completion (10 million ms)
				info = 10 ^ 7, -- Disable info window completely
				signature = 50, -- Keep signature help for function parameters
			},

			-- Disable info window completely
			window = {
				info = nil, -- Disabled - no info window will appear
				signature = { height = 25, width = 80, border = nil },
			},

			-- LSP code completion only
			lsp_completion = {
				source_func = "completefunc",
				auto_setup = true,
			},

			-- Essential mappings
			mappings = {
				force_twostep = "<C-Space>", -- Press this to manually trigger completion
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
		})

		-- Alternative: If you want auto-completion back but with better positioning,
		-- change completion delay from 10^7 to something like 500 (half a second)
		-- This gives you time to type before completion appears
	end,
}
