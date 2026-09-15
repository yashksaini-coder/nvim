-- Generates site/js/keymaps.js — the data behind the KMOS keymap terminal —
-- from the live keymap table.
--
--   :KeymapExport   write site/js/keymaps.js
--   make site       the same, headless
--
-- The site (index.html, js/app.js, css/style.css) is hand-owned and is never
-- touched. Only the data file is generated, whole.
--
-- The site draws a 60% ANSI keyboard and lights ONE physical key per binding —
-- the first keystroke of its sequence — within a mode and a modifier layer. So
-- every lhs is split into keystrokes and the first resolved to a key id on that
-- board plus the modifiers held for it. <leader>gv lights `g` in the LEADER
-- layer; pressing `g` there then lists every <leader>g… binding, which is
-- which-key's model.
--
-- Three tables below are maintained BY HAND, because nothing can derive them:
--
--   GROUPS    order in which bindings are listed inside each mode. The site's
--             list is flat, so this is what keeps related keys adjacent.
--   ROUTE     which group a key belongs to. First match wins.
--   BUFLOCAL  buffer-local maps -- LSP, gitsigns, rustaceanvim, treesitter,
--             diffview panels. `nvim_get_keymap` cannot see these: they do not
--             exist until the right buffer is open, so they must be listed.
--
-- DENY exists because a raw dump is mostly noise: Neovim's own bracket maps
-- (`[A` -> `:rewind`), its built-in LSP defaults (`gra`), and mini.surround's
-- full l/n variant matrix would bury the keys you actually look up.

local M = {}

local ROOT = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":p")
local OUT = ROOT .. "site/js/keymaps.js"

-- ── hand-maintained ─────────────────────────────────────────────────────────

local GROUPS = {
	"crates",
	"git",
	"buffer",
	"rust",
	"find",
	"windows",
	"template",
	"markdown",
	"code",
	"lazy",
	"noice",
	"trouble",
	"docs",
	"themes",
	"mason",
	"misc",
	"globals",
}

-- First match wins. Lua patterns, anchored at the start of the lhs.
local ROUTE = {
	{ "^<leader>c", "crates" },
	{ "^<leader>[gh]", "git" },
	{ "^<leader>b", "buffer" },
	{ "^[HL]$", "buffer" },
	{ "^[%[%]]b$", "buffer" },
	{ "^<leader>r", "rust" },
	{ "^<leader>f", "find" },
	{ "^<C%-P>$", "find" },
	{ "^<C%-W>", "windows" },
	{ "^<C%-[HJKL]>$", "windows" },
	{ "^<C%-[UDLR]", "windows" }, -- <C-Up> <C-Down> <C-Left> <C-Right>
	{ "^<leader>i", "template" },
	{ "^<leader>m", "markdown" },
	{ "^<F[568]>$", "markdown" },
	{ "^<leader>tH$", "themes" },
	{ "^<leader>l", "lazy" },
	{ "^<leader>n", "noice" },
	{ "^<leader>x", "trouble" },
	{ "^[%[%]][dD]$", "trouble" },
	{ "^<leader>k", "docs" },
	{ "^<leader>M$", "mason" },
	{ "^<leader>[eo]$", "code" },
	{ "^g[xO]$", "code" },
	{ "^<leader>[pP]$", "globals" },
	{ "^<Esc>$", "globals" },
	{ "^<C%-S>$", "globals" },
	{ "^[%[%]] ?$", "globals" }, -- `[ ` / `] ` are [<Space> / ]<Space>
}

-- Buffer-local: only exist once the right buffer is open.
local BUFLOCAL = {
	{ "code", "<leader>gd", "Go to definition", "n", "LSP" },
	{ "code", "<leader>gr", "Go to references", "n", "LSP" },
	{ "code", "<leader>ca", "Code action", "n", "LSP" },
	{ "code", "<leader>rn", "Rename symbol", "n", "LSP" },
	{ "code", "K", "Hover", "n", "LSP" },
	{ "code", "gD", "Goto declaration", "n", "LSP" },
	{ "code", "<C-k>", "Signature help", "i s", "LSP" },
	{ "rust", "<leader>rE", "Explain error", "n", "rustaceanvim" },
	{ "rust", "<leader>rI", "View item tree", "n", "rustaceanvim" },
	{ "rust", "<leader>rM", "View memory layout", "n", "rustaceanvim" },
	{ "rust", "<leader>rR", "Re-run last runnable", "n", "rustaceanvim" },
	{ "rust", "<leader>rb", "Rebuild proc macros", "n", "rustaceanvim" },
	{ "rust", "<leader>rc", "Open Cargo.toml", "n", "rustaceanvim" },
	{ "rust", "<leader>rd", "Open documentation", "n", "rustaceanvim" },
	{ "rust", "<leader>rh", "View HIR", "n", "rustaceanvim" },
	{ "rust", "<leader>rj", "Join lines", "n v", "rustaceanvim" },
	{ "rust", "<leader>rl", "View MIR", "n", "rustaceanvim" },
	{ "rust", "<leader>rm", "Expand macro", "n", "rustaceanvim" },
	{ "rust", "<leader>rp", "Parent module", "n", "rustaceanvim" },
	{ "rust", "<leader>rr", "Runnables", "n", "rustaceanvim" },
	{ "rust", "<leader>rt", "View syntax tree", "n", "rustaceanvim" },
	{ "rust", "<leader>rw", "Reload workspace", "n", "rustaceanvim" },
	{ "git", "<leader>hs", "Stage hunk", "n v", "gitsigns" },
	{ "git", "<leader>hr", "Reset hunk", "n v", "gitsigns" },
	{ "git", "<leader>hS", "Stage buffer", "n", "gitsigns" },
	{ "git", "<leader>hR", "Reset buffer", "n", "gitsigns" },
	{ "git", "<leader>hp", "Preview hunk", "n", "gitsigns" },
	{ "git", "<leader>hi", "Preview hunk inline", "n", "gitsigns" },
	{ "git", "<leader>hb", "Blame line", "n", "gitsigns" },
	{ "git", "<leader>hd", "Diff this", "n", "gitsigns" },
	{ "git", "<leader>hD", "Diff against ~", "n", "gitsigns" },
	{ "git", "<leader>hq", "Hunks to quickfix", "n", "gitsigns" },
	{ "git", "<leader>hQ", "All hunks to quickfix", "n", "gitsigns" },
	{ "git", "[c", "Prev git hunk", "n", "gitsigns" },
	{ "git", "]c", "Next git hunk", "n", "gitsigns" },
	{ "git", "<leader>gb", "Toggle full-buffer blame", "n", "gitsigns" },
	{ "git", "<leader>tb", "Toggle line blame", "n", "gitsigns" },
	{ "git", "<leader>tw", "Toggle word diff", "n", "gitsigns" },
	{ "git", "ih", "Select hunk", "o x", "gitsigns" },
	{ "misc", "<CR>", "Grow selection to parent node", "n x", "treesitter" },
	{ "misc", "<BS>", "Shrink selection to child node", "x", "treesitter" },
}

-- Dropped from the generated output. Each entry says why.
local DENY = {
	{ desc = "^:%a", why = "Neovim's own bracket maps (:rewind, :clast, ...)" },
	{ desc = "^vim%.lsp%.", why = "Neovim's built-in LSP defaults (gra, gri, gO...)" },
	{ desc = "^vim%.snippet", why = "built-in snippet jump plumbing" },
	{ desc = "^autopairs", why = "plugin internals" },
	{ lhs = "^gs%a[ln]$", why = "mini.surround l/n variant matrix" },
	{ lhs = "^gs%a%a[ln]$", why = "mini.surround l/n variant matrix" },
	{ lhs = "^[ai][ln]?$", why = "mini.ai bare textobject variants" },
	{ lhs = "^<Plug>", why = "plugin <Plug> maps are not user-facing" },
}

-- ── collection ──────────────────────────────────────────────────────────────

local function denied(lhs, desc)
	for _, rule in ipairs(DENY) do
		if rule.desc and desc:match(rule.desc) then
			return true
		end
		if rule.lhs and lhs:match(rule.lhs) then
			return true
		end
	end
	return false
end

local function group_of(lhs)
	for _, rule in ipairs(ROUTE) do
		if lhs:match(rule[1]) then
			return rule[2]
		end
	end
	return "misc"
end

--- Load every plugin so lazy-loaded `keys` are registered before enumerating.
local function load_all()
	local ok, lazy = pcall(require, "lazy")
	if not ok then
		return
	end
	for _, p in ipairs(lazy.plugins()) do
		pcall(lazy.load, { plugins = { p.name } })
	end
	vim.wait(2000)
end

--- @return table<string, table[]> entries keyed by group id
function M.collect()
	load_all()

	local merged = {} -- lhs|desc -> { lhs, desc, modes = set }
	for _, mode in ipairs({ "n", "v", "x", "o", "i", "t" }) do
		for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
			local desc, lhs = m.desc, (m.lhs:gsub("^ ", "<leader>"))
			if desc and desc ~= "" and not denied(lhs, desc) then
				local id = lhs .. "|" .. desc
				merged[id] = merged[id] or { lhs = lhs, desc = desc, modes = {} }
				merged[id].modes[mode] = true
			end
		end
	end

	local by_group = {}
	for _, id in ipairs(GROUPS) do
		by_group[id] = {}
	end

	local function add(gid, lhs, desc, modes, note)
		by_group[gid] = by_group[gid] or {}
		table.insert(by_group[gid], { lhs = lhs, desc = desc, modes = modes, note = note })
	end

	for _, e in pairs(merged) do
		local modes = {}
		-- x is a subset of v; showing both is noise.
		for _, mode in ipairs({ "n", "v", "x", "o", "i", "t" }) do
			if e.modes[mode] and not (mode == "x" and e.modes.v) then
				modes[#modes + 1] = mode
			end
		end
		add(group_of(e.lhs), e.lhs, e.desc, table.concat(modes, " "))
	end

	for _, b in ipairs(BUFLOCAL) do
		add(b[1], b[2], b[3], b[4], b[5])
	end

	-- Snippets are derived from LuaSnip, not listed by hand: any snippet added
	-- anywhere in the config shows up in INSERT on the next export. pairs()
	-- order does not matter; the sort below is total.
	local ok, ls = pcall(require, "luasnip")
	if ok then
		for _, snippets in pairs(ls.get_snippets()) do
			for _, s in ipairs(snippets) do
				add("template", s.trigger, table.concat(s.description, " "), "i", "snippet")
			end
		end
	end

	for _, list in pairs(by_group) do
		-- Sort must be total: several keys carry more than one mapping (e.g.
		-- <leader>cU is "Upgrade crate" in n and "Upgrade crates" in v). Without
		-- the desc tiebreaker their order follows `pairs()` and the generated
		-- file churns on every run.
		table.sort(list, function(a, b)
			if #a.lhs ~= #b.lhs then
				return #a.lhs < #b.lhs
			end
			if a.lhs ~= b.lhs then
				return a.lhs < b.lhs
			end
			return a.desc < b.desc
		end)
	end
	return by_group
end

-- ── translation to the KMOS board ────────────────────────────────────────────

-- Shifted legends on a US ANSI board, mapped back to the key that produces them.
local SHIFTED = {
	["~"] = "`",
	["!"] = "1",
	["@"] = "2",
	["#"] = "3",
	["$"] = "4",
	["%"] = "5",
	["^"] = "6",
	["&"] = "7",
	["*"] = "8",
	["("] = "9",
	[")"] = "0",
	["_"] = "-",
	["+"] = "=",
	["{"] = "[",
	["}"] = "]",
	["|"] = "\\",
	[":"] = ";",
	['"'] = "'",
	["<"] = ",",
	[">"] = ".",
	["?"] = "/",
}

-- Named keycodes: { board key id, how the site spells it, implied modifier }.
local NAMED = {
	leader = { "space", "SPC" },
	space = { "space", "Space" },
	esc = { "esc", "Esc" },
	tab = { "tab", "Tab" },
	cr = { "enter", "Enter" },
	enter = { "enter", "Enter" },
	["return"] = { "enter", "Enter" },
	bs = { "backspace", "Bksp" },
	backspace = { "backspace", "Bksp" },
	up = { "up", "Up" },
	down = { "down", "Down" },
	left = { "left", "Left" },
	right = { "right", "Right" },
	lt = { ",", "<", "shift" },
	bar = { "\\", "|", "shift" },
	bslash = { "\\", "\\" },
}

local MOD_OF = { C = "ctrl", S = "shift", M = "alt", A = "alt", D = "super" }
local MOD_ORDER = { ctrl = 1, shift = 2, alt = 3, super = 4, fn = 5 }
local MOD_LABEL = { ctrl = "Ctrl", shift = "Shift", alt = "Alt", super = "Super" }

-- 60% boards have no function row: F1–F10 are Fn+1…0, F11 Fn+-, F12 Fn+=.
local FN_KEY = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=" }

local function sorted(mods)
	table.sort(mods, function(a, b)
		return MOD_ORDER[a] < MOD_ORDER[b]
	end)
	return mods
end

--- "Ctrl+s", "Shift+Tab". fn is left out: "F5" already says it.
local function chord(mods, label)
	local out = {}
	for _, m in ipairs(mods) do
		if MOD_LABEL[m] then
			out[#out + 1] = MOD_LABEL[m]
		end
	end
	out[#out + 1] = label
	return table.concat(out, "+")
end

--- Split an lhs into keystrokes: a whole <…> keycode, or one character.
local function keystrokes(lhs)
	local out, i = {}, 1
	while i <= #lhs do
		local code = lhs:match("^<[^<>%s]+>", i)
		out[#out + 1] = code or lhs:sub(i, i)
		i = i + (code and #code or 1)
	end
	return out
end

--- One keystroke -> { key = board id, mods = {…}, label = display text }.
local function resolve(stroke)
	if #stroke == 1 then
		if stroke == " " then
			return { key = "space", mods = {}, label = "Space" }
		elseif stroke:match("%u") then
			return { key = stroke:lower(), mods = { "shift" }, label = stroke }
		elseif SHIFTED[stroke] then
			return { key = SHIFTED[stroke], mods = { "shift" }, label = stroke }
		end
		return { key = stroke, mods = {}, label = stroke }
	end

	local body, mods = stroke:sub(2, -2), {}
	while true do
		local m, rest = body:match("^(%a)%-(.+)$")
		if not (m and MOD_OF[m:upper()]) then
			break
		end
		mods[#mods + 1] = MOD_OF[m:upper()]
		body = rest
	end

	local lower = body:lower()
	local fnum = tonumber(lower:match("^f(%d+)$"))
	if fnum and FN_KEY[fnum] then
		mods[#mods + 1] = "fn"
		return { key = FN_KEY[fnum], mods = sorted(mods), label = chord(mods, body:upper()) }
	end

	local named = NAMED[lower]
	if named then
		if named[3] then
			mods[#mods + 1] = named[3]
		end
		return { key = named[1], mods = sorted(mods), label = chord(mods, named[2]) }
	end

	if #body == 1 then
		-- Ctrl/Alt chords are case-insensitive in Vim (<C-S> is <C-s>), so a
		-- capital inside one does not imply Shift. A shifted symbol still does.
		local key = body:lower()
		if SHIFTED[body] then
			key = SHIFTED[body]
			mods[#mods + 1] = "shift"
		end
		return { key = key, mods = sorted(mods), label = chord(mods, body:lower()) }
	end

	-- A keycode the board has no key for: keep the text so it still lists.
	return { key = lower, mods = sorted(mods), label = stroke }
end

local MODE_OF = { n = "normal", v = "visual", x = "visual", s = "visual", o = "operator", i = "insert" }

local MODES = {
	{ id = "normal", label = "NORMAL" },
	{ id = "insert", label = "INSERT" },
	{ id = "visual", label = "VISUAL" },
	{ id = "operator", label = "OPERATOR" },
	-- Last on purpose: the shell's `man vim` uses the final mode as its
	-- usage example, and this is the one worth showing.
	{ id = "leader", label = "LEADER", prefix = "space" },
}

--- A collected row -> the modes it belongs to, and its binding.
local function to_binding(row)
	local strokes = keystrokes(row.lhs)
	local leader = strokes[1] == "<leader>"
	if leader then
		table.remove(strokes, 1)
	end
	if #strokes == 0 then
		return nil
	end

	-- Plain characters run together ("gsa"); keycodes stand apart ("] Space").
	local parts, prev_plain = {}, false
	for _, st in ipairs(strokes) do
		local plain = #st == 1 and st ~= " "
		local label = resolve(st).label
		if plain and prev_plain then
			parts[#parts] = parts[#parts] .. label
		else
			parts[#parts + 1] = label
		end
		prev_plain = plain
	end

	local first = resolve(strokes[1])
	local binding = {
		seq = (leader and "SPC " or "") .. table.concat(parts, " "),
		key = first.key,
		mods = first.mods,
		action = row.note and ("%s (%s)"):format(row.desc, row.note) or row.desc,
	}

	local modes = {}
	if leader then
		modes.leader = true
	else
		for m in row.modes:gmatch("%a") do
			if MODE_OF[m] then
				modes[MODE_OF[m]] = true
			end
		end
	end
	return modes, binding
end

--- @return table the `window.KEYMAPS` structure the site reads
function M.build(by_group)
	local lists, seen = {}, {}
	for _, mode in ipairs(MODES) do
		lists[mode.id], seen[mode.id] = {}, {}
	end

	-- GROUPS order, then collect()'s own sort: related keys stay adjacent in
	-- the site's flat per-mode list.
	for _, gid in ipairs(GROUPS) do
		for _, row in ipairs(by_group[gid] or {}) do
			local modes, binding = to_binding(row)
			if modes then
				for _, mode in ipairs(MODES) do
					local id = binding.seq .. "\0" .. binding.action
					if modes[mode.id] and not seen[mode.id][id] then
						seen[mode.id][id] = true
						table.insert(lists[mode.id], binding)
					end
				end
			end
		end
	end

	local modes = {}
	for _, mode in ipairs(MODES) do
		if #lists[mode.id] > 0 then
			modes[#modes + 1] = { id = mode.id, label = mode.label, prefix = mode.prefix, bindings = lists[mode.id] }
		end
	end

	return {
		programs = {
			{
				id = "nvim",
				name = "NVIM",
				title = "NEOVIM KEYMAPS",
				aliases = { "neovim" },
				desc = "Neovim — modal editing, leader is Space",
				modes = modes,
			},
		},
	}
end

-- ── serialisation ───────────────────────────────────────────────────────────

-- vim.json.encode would do the whole tree, but Lua tables are unordered, so its
-- key order drifts between runs and the committed file would churn. Structure is
-- written by hand in a fixed order; vim.json.encode only escapes the values.
local q = vim.json.encode

local function strings(list)
	local out = {}
	for _, v in ipairs(list) do
		out[#out + 1] = q(v)
	end
	return "[" .. table.concat(out, ", ") .. "]"
end

function M.serialise(data)
	local o = {
		"// GENERATED by lua/config/keymap-export.lua from the live keymap table.",
		"// Do not edit by hand: run `make site` (or :KeymapExport) instead.",
		"window.KEYMAPS = {",
		'  "programs": [',
	}
	for pi, p in ipairs(data.programs) do
		o[#o + 1] = "    {"
		o[#o + 1] = ('      "id": %s,'):format(q(p.id))
		o[#o + 1] = ('      "name": %s,'):format(q(p.name))
		o[#o + 1] = ('      "title": %s,'):format(q(p.title))
		o[#o + 1] = ('      "aliases": %s,'):format(strings(p.aliases))
		o[#o + 1] = ('      "desc": %s,'):format(q(p.desc))
		o[#o + 1] = '      "modes": ['
		for mi, m in ipairs(p.modes) do
			o[#o + 1] = "        {"
			o[#o + 1] = ('          "id": %s,'):format(q(m.id))
			o[#o + 1] = ('          "label": %s,'):format(q(m.label))
			if m.prefix then
				o[#o + 1] = ('          "prefix": %s,'):format(q(m.prefix))
			end
			o[#o + 1] = '          "bindings": ['
			for bi, b in ipairs(m.bindings) do
				local fields = { ('"seq": %s'):format(q(b.seq)), ('"key": %s'):format(q(b.key)) }
				if #b.mods > 0 then
					fields[#fields + 1] = ('"mods": %s'):format(strings(b.mods))
				end
				fields[#fields + 1] = ('"action": %s'):format(q(b.action))
				o[#o + 1] = ("            { %s }%s"):format(table.concat(fields, ", "), bi < #m.bindings and "," or "")
			end
			o[#o + 1] = "          ]"
			o[#o + 1] = "        }" .. (mi < #p.modes and "," or "")
		end
		o[#o + 1] = "      ]"
		o[#o + 1] = "    }" .. (pi < #data.programs and "," or "")
	end
	o[#o + 1] = "  ]"
	o[#o + 1] = "};"
	return table.concat(o, "\n") .. "\n"
end

-- ── commands ────────────────────────────────────────────────────────────────

function M.export()
	local data = M.build(M.collect())
	local f = assert(io.open(OUT, "w"))
	f:write(M.serialise(data))
	f:close()

	local total = 0
	for _, m in ipairs(data.programs[1].modes) do
		total = total + #m.bindings
	end
	return total
end

vim.api.nvim_create_user_command("KeymapExport", function()
	local ok, res = pcall(M.export)
	if ok then
		vim.notify(("Wrote %d bindings to site/js/keymaps.js"):format(res))
	else
		vim.notify(tostring(res), vim.log.levels.ERROR)
	end
end, { desc = "Regenerate the keymap site data" })

return M
