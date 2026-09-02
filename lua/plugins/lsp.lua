return {
	"neovim/nvim-lspconfig",
	-- Load once a buffer is actually read. The `executable()` gate below needs
	-- ~/.local/share/nvim/mason/bin on $PATH first; that ordering comes from the
	-- dependency edge (lazy.nvim loads dependencies before the dependent), not
	-- from mason being eager — mason is lazy on cmd now.
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

		-- Per-server settings live in lua/lsps/<server>.lua. A server without a
		-- file just uses nvim-lspconfig's defaults — eslint's and ruff's are
		-- already right, and lua_ls's whole settings table is lazydev's job now
		-- (see plugins/lazydev.lua).
		vim.lsp.config("clangd", require("lsps.clangd"))
		vim.lsp.config("gopls", require("lsps.gopls"))
		vim.lsp.config("pyright", require("lsps.pyright"))
		vim.lsp.config("tailwindcss", require("lsps.tailwindcss"))
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
			-- rust_analyzer is deliberately absent: rustaceanvim starts it from its
			-- own ftplugin (lua/plugins/rustaceanvim.lua). Listing it here too puts
			-- two clients on the same buffer.
			clangd = "clangd",
			pyright = "pyright-langserver",
			ruff = "ruff", -- lints + import sorting; pyright keeps types (see lsps/pyright.lua)
			gopls = "gopls",
			tailwindcss = "tailwindcss-language-server",
			eslint = "vscode-eslint-language-server", -- mason package: eslint-lsp
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
