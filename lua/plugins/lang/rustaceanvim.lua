return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			tools = {
				hover_actions = { auto_focus = true },
				float_win_config = { border = "rounded" },
			},
			server = {
				default_settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true, loadOutDirsFromCheck = true },
						checkOnSave = true,
						check = { command = "clippy", extraArgs = { "--no-deps" } },
						procMacro = { enable = true },
						inlayHints = {
							bindingModeHints = { enable = true },
							chainingHints = { enable = true },
							closingBraceHints = { enable = true, minLines = 25 },
							closureCaptureHints = { enable = true },
							parameterHints = { enable = true },
							typeHints = { enable = true },
							lifetimeElisionHints = { enable = "skip_trivial" },
						},
					},
				},
			},
			dap = { autoload_configurations = false },
		}
	end,
}
