-- Feeds lua_ls only the plugin sources a Lua file actually requires, as it
-- requires them. Replaces workspace.library = nvim_get_runtime_file("", true),
-- which made every Lua buffer wait on the whole plugin directory — and which is
-- why lua/lsps/lua_ls.lua is gone: lazydev writes runtime.version, the `vim`
-- global and checkThirdParty itself.
return {
	"folke/lazydev.nvim",
	ft = "lua",
	cmd = "LazyDev",
	opts = {
		library = {
			-- Neither ships in the runtime, so both load on mention rather than always.
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			{ path = "snacks.nvim", words = { "Snacks" } },
		},
	},
}
