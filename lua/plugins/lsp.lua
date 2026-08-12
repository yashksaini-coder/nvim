return {
	"neovim/nvim-lspconfig",
	-- Load once a buffer is actually read. This guarantees mason.setup()
	-- (eager) has already prepended ~/.local/share/nvim/mason/bin to $PATH,
	-- so the `executable()` gate below sees every Mason-installed server.
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"mason-org/mason.nvim", -- must load first so mason bins are on $PATH
		"hrsh7th/cmp-nvim-lsp", -- capabilities forwarded via vim.lsp.config("*", ...)
	},
	config = function()
		-- Forward cmp's default capabilities to every server so completion
		-- gets snippetSupport, additionalTextEdits, etc.
		local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			vim.lsp.config("*", { capabilities = cmp_lsp.default_capabilities() })
		end

		vim.lsp.config("lua_ls", require("lsps.lua_ls"))
		vim.lsp.config("ts_ls", require("lsps.ts_ls"))

		-- Only enable an LSP if its binary is actually on $PATH. Avoids the
		-- noisy "Spawning language server with cmd ... failed" error when a
		-- server is enabled but the binary isn't installed (e.g. opening a
		-- TS file with `tailwindcss-language-server` missing).
		local function enable_if_installed(server, cmd)
			if vim.fn.executable(cmd) == 1 then
				vim.lsp.enable(server)
			end
		end

		-- Map of server-name -> command on $PATH. If you add a new LSP, add
		-- it here too. Mason installs go in ~/.local/share/nvim/mason/bin,
		-- which is on $PATH after mason.setup() runs.
		local servers = {
			lua_ls = "lua-language-server",
			ts_ls = "typescript-language-server",
			rust_analyzer = "rust-analyzer",
			clangd = "clangd",
			pyright = "pyright-langserver",
			gopls = "gopls",
			tailwindcss = "tailwindcss-language-server",
			phpactor = "phpactor",
			dartls = "dart",
			ocamllsp = "ocamllsp",
			zls = "zls",
			sourcekit = "sourcekit-lsp",
		}

		for server, cmd in pairs(servers) do
			enable_if_installed(server, cmd)
		end

		-- Belt & suspenders — nvim-lspconfig's plugin/lspconfig.lua registers
		-- :LspInfo as an alias to `checkhealth vim.lsp`, but lazy.nvim's
		-- plugin-file sourcing under event-loading has been flaky. Guarantee
		-- the command exists no matter what.
		if vim.fn.exists(":LspInfo") ~= 2 then
			vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
				desc = "LSP health check (alias for :checkhealth vim.lsp)",
			})
		end

		-- NOTE: <C-i> is the same keycode as <Tab> in terminals — do NOT map it.
		-- Use <leader>gd or gd instead. K for hover is in config/keymaps/lsp.lua.
	end,
}
