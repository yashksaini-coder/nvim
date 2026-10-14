-- Oxocarbon: IBM Carbon palette, one colorscheme with a light and a dark face.
-- https://github.com/nyoom-engineering/oxocarbon.nvim
return {
	"nyoom-engineering/oxocarbon.nvim",
	priority = 1000,
	-- Skip the rockspec. oxocarbon is written in Fennel and ships a rockspec
	-- whose only job is pulling `fennel` to recompile fnl/ -> lua/. lazy sees
	-- the rockspec and tries luarocks, which fails on this box (Lua headers are
	-- 5.1, Lua is 5.5) and prints two errors on every sync. The repo already
	-- ships the compiled colors/oxocarbon.lua and lua/oxocarbon, so there is
	-- nothing to build — `build = false` is checked first in task/plugin.lua.
	build = false,
	-- No opts/config: oxocarbon ships a plain colors/oxocarbon.lua and exposes no
	-- setup() to call. Which face you get is decided entirely by `background`,
	-- so the light/dark split lives in each Themery entry's `before` block
	-- (themes/themery.lua) — the same shape the two Gruvbox entries use.
}
