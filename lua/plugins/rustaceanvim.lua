-- rustaceanvim owns the rust-analyzer client: its ftplugin/rust.lua calls
-- vim.lsp.start() itself. rust_analyzer is therefore gone from the executable()-gated
-- list in lsp.lua — leaving it there silently attaches two clients to the same buffer
-- (vim.lsp.enable registers under augroup nvim.lsp.enable, which rustaceanvim's
-- lspconfig-conflict check does not detect, so nothing would warn you).
-- v9 is the current major and requires Neovim >= 0.12.
return {
	"mrcjkb/rustaceanvim",
	version = "^9",
	-- Upstream suggests lazy = false since the plugin lazy-loads itself through its
	-- ftplugin. ft= lands in the same place and matches every other spec here.
	ft = { "rust" },
	init = function()
		vim.g.rustaceanvim = {
			server = {
				-- No capabilities here: lsp.lua registers cmp's via vim.lsp.config("*"),
				-- and rustaceanvim deep-merges vim.lsp.config over its own server table
				-- when it starts the client — so cmp's arrive without clobbering the
				-- experimental hoverActions/codeActionGroup flags rustaceanvim sets.
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							-- Without this, anything behind a non-default feature reads as
							-- dead code and unresolved imports.
							allFeatures = true,
						},
						-- check/checkOnSave omitted on purpose: tools.enable_clippy (on by
						-- default) sets check = clippy with extraArgs { "--no-deps" } when
						-- cargo-clippy is on $PATH, but only while `check` is unset. Spelling
						-- it out here would silently drop --no-deps.
						inlayHints = {
							-- The one category rust-analyzer ships off that is worth having:
							-- renders the elided ref/ref mut in match and let patterns.
							-- chaining/closingBrace/parameter/type hints already default to
							-- true. Whether hints are displayed at all is a global toggle in
							-- config/options.lua.
							bindingModeHints = { enable = true },
						},
					},
				},
			},
		}
	end,
	-- :RustLsp is a buffer-local command created when rust-analyzer attaches, so these
	-- are ft-scoped rather than global.
	keys = {
		{ "<leader>rr", "<cmd>RustLsp runnables<cr>", ft = "rust", desc = "Rust: runnables" },
		-- The competitive-programming loop: pick the target once with <leader>rr, then
		-- edit and re-run with <leader>rR without going through the picker again.
		{ "<leader>rR", "<cmd>RustLsp! runnables<cr>", ft = "rust", desc = "Rust: re-run last runnable" },
		{ "<leader>rE", "<cmd>RustLsp explainError<cr>", ft = "rust", desc = "Rust: explain error" },
		{ "<leader>rm", "<cmd>RustLsp expandMacro<cr>", ft = "rust", desc = "Rust: expand macro" },
		{ "<leader>rj", "<cmd>RustLsp joinLines<cr>", ft = "rust", desc = "Rust: join lines" },
		-- `:` rather than <cmd> so visual mode prefills the '<,'> range joinLines needs.
		{ "<leader>rj", ":RustLsp joinLines<cr>", mode = "v", ft = "rust", silent = true, desc = "Rust: join lines" },
		{ "<leader>rh", "<cmd>RustLsp view hir<cr>", ft = "rust", desc = "Rust: view HIR" },
		{ "<leader>rl", "<cmd>RustLsp view mir<cr>", ft = "rust", desc = "Rust: view MIR" },
		{ "<leader>rt", "<cmd>RustLsp syntaxTree<cr>", ft = "rust", desc = "Rust: view syntax tree" },
		{ "<leader>rc", "<cmd>RustLsp openCargo<cr>", ft = "rust", desc = "Rust: open Cargo.toml" },
		{ "<leader>rp", "<cmd>RustLsp parentModule<cr>", ft = "rust", desc = "Rust: parent module" },
		{ "<leader>rd", "<cmd>RustLsp openDocs<cr>", ft = "rust", desc = "Rust: open documentation" },
		{ "<leader>rw", "<cmd>RustLsp reloadWorkspace<cr>", ft = "rust", desc = "Rust: reload workspace" },
		{ "<leader>rb", "<cmd>RustLsp rebuildProcMacros<cr>", ft = "rust", desc = "Rust: rebuild proc macros" },
	},
}
