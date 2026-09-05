-- Generates the keymap rows in site/index.html from the live keymap table.
--
--   :KeymapExport     rewrite site/index.html between the GENERATED markers
--   :KeymapCheck      report drift without writing anything
--   make site         both, headless
--
-- Everything between <!-- BEGIN GENERATED --> and <!-- END GENERATED --> is
-- replaced; the shell (hero, search, empty state, footer) is left alone.
--
-- Three tables below are maintained BY HAND, because nothing can derive them:
--
--   GROUPS    the group list, titles, hints and search tags.
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
local PAGE = ROOT .. "site/index.html"

-- ── hand-maintained ─────────────────────────────────────────────────────────

local GROUPS = {
	{
		id = "crates",
		rail = "c",
		prefix = "<leader>c",
		shown = "<leader>c",
		title = "crates",
		suffix = "cargo.toml",
		tags = "crates rust cargo toml versions features dependencies",
		hint = "<code>&lt;leader&gt;c</code> — crates.nvim in Cargo.toml.",
	},
	{
		id = "git",
		rail = "g",
		prefix = "<leader>",
		shown = "<leader>g  <leader>h",
		title = "git",
		tags = "git gitsigns lazygit hunk blame diff stage reset diffview octo github pr pull request issue review changed files panel diffstat history",
		hint = "<code>&lt;leader&gt;g</code> · <code>&lt;leader&gt;h</code> — gitsigns hunks, lazygit, diffview (local changes) &amp; octo (GitHub PRs).",
	},
	{
		id = "buffer",
		rail = "b",
		prefix = "<leader>b",
		shown = "<leader>b",
		title = "buffer",
		tags = "buffer barbar pin delete close move goto",
		hint = "<code>&lt;leader&gt;b</code> — barbar tabs &amp; buffer ops.",
	},
	{
		id = "rust",
		rail = "r",
		prefix = "<leader>r",
		shown = "<leader>r",
		title = "rust",
		suffix = "rustaceanvim",
		tags = "rust rustaceanvim ferris runnable clippy hir mir macro cargo module documentation workspace",
		hint = "<code>&lt;leader&gt;r</code> — rust-analyzer, in .rs files.",
	},
	{
		id = "find",
		rail = "f",
		prefix = "<leader>f",
		shown = "<leader>f",
		title = "file &amp; find",
		tags = "find file search telescope grep buffers help oldfiles todo replace",
		hint = "<code>&lt;leader&gt;f</code> — Telescope pickers.",
	},
	{
		id = "windows",
		rail = "^w",
		prefix = nil,
		shown = "<C-w>  <C-hjkl>",
		title = "windows",
		tags = "window split resize navigate hydra",
		hint = "Navigate &amp; resize splits.",
	},
	{
		id = "terminal",
		rail = "t",
		prefix = "<leader>t",
		shown = "<leader>t",
		title = "terminal",
		tags = "terminal term shell split vsplit exit insert mode",
		hint = "<code>&lt;leader&gt;t</code> — plain <code>:terminal</code>, no plugin.",
	},
	{
		id = "markdown",
		rail = "m",
		prefix = "<leader>m",
		shown = "<leader>m",
		title = "markdown &amp; compile",
		tags = "markdown render compile build run make pty",
		hint = "<code>&lt;leader&gt;m</code> — render-markdown, compile-mode.",
	},
	{
		id = "code",
		rail = "g",
		prefix = nil,
		shown = nil,
		title = "code &amp; lsp",
		tags = "lsp code hover definition references action explorer outline format symbol",
		hint = "LSP actions, explorer, outline.",
	},
	{
		id = "lazy",
		rail = "l",
		prefix = "<leader>l",
		shown = "<leader>l",
		title = "lazy",
		tags = "lazy plugin manager sync update install clean",
		hint = "<code>&lt;leader&gt;l</code> — plugin manager.",
	},
	{
		id = "noice",
		rail = "n",
		prefix = "<leader>n",
		shown = "<leader>n",
		title = "noice",
		tags = "noice notification message history cmdline dismiss",
		hint = "<code>&lt;leader&gt;n</code> — noice.nvim history &amp; messages.",
	},
	{
		id = "trouble",
		rail = "x",
		prefix = "<leader>x",
		shown = "<leader>x",
		title = "trouble &amp; diagnostics",
		tags = "trouble diagnostics quickfix loclist symbols error warning",
		hint = "<code>&lt;leader&gt;x</code> — trouble.nvim panels + line float.",
	},
	{
		id = "docs",
		rail = "k",
		prefix = "<leader>k",
		shown = "<leader>k",
		title = "docs &amp; man",
		tags = "docs man manpage keymap reference help",
		hint = "<code>&lt;leader&gt;k</code> — reach for a manual.",
	},
	{
		id = "themes",
		rail = "t",
		prefix = "<leader>t",
		shown = "<leader>t",
		title = "themes",
		tags = "theme colorscheme themery catppuccin kanagawa gruvbox",
		hint = "Themery picker.",
	},
	{
		id = "mason",
		rail = "M",
		prefix = nil,
		shown = nil,
		title = "mason",
		tags = "mason lsp installer",
		hint = "LSP / DAP / linter / formatter installer.",
	},
	{
		id = "misc",
		rail = "·",
		prefix = nil,
		shown = nil,
		title = "misc",
		tags = "misc surround flash jump textobject fold comment treesitter selection incremental node expand shrink todo",
		hint = "Everything else.",
	},
	{
		id = "globals",
		rail = "·",
		prefix = nil,
		shown = nil,
		title = "globals",
		tags = "global escape save blank line",
		hint = "Always-there keys.",
	},
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
	{ "^<leader>m", "markdown" },
	{ "^<F[568]>$", "markdown" },
	{ "^<leader>tH$", "themes" }, -- must precede the <leader>t terminal prefix
	{ "^<leader>t", "terminal" },
	{ "^<Esc><Esc>$", "terminal" },
	{ "^<leader>l", "lazy" },
	{ "^<leader>n", "noice" },
	{ "^<leader>x", "trouble" },
	{ "^[%[%]][dD]$", "trouble" },
	{ "^<leader>k", "docs" },
	{ "^<leader>M$", "mason" },
	{ "^<leader>[eo]$", "code" },
	{ "^g[xO]$", "code" },
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
	{ "git", "i", "Toggle list/tree layout", "n", "diffview panel" },
	{ "git", "<Tab>", "Cycle to next changed file", "n", "diffview panel" },
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
	for _, g in ipairs(GROUPS) do
		by_group[g.id] = {}
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

-- ── rendering ───────────────────────────────────────────────────────────────

local function esc(s)
	return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

--- A literal space inside a lhs is a real <Space> press (`[ ` is [<Space>);
--- rendered raw it would be an invisible gap on the page.
local function spaces(str)
	return (esc(str):gsub(" ", "<i>&lt;Space&gt;</i>"))
end

function M.render(by_group)
	local rail, out, total = {}, {}, 0

	-- The rail is the leader tree: one entry per group, keyed by the letter you
	-- actually press. Groups with no single prefix show a dot.
	rail[#rail + 1] = '  <nav class="rail" aria-label="Jump to group">'

	for _, g in ipairs(GROUPS) do
		local rows = by_group[g.id] or {}
		if #rows > 0 then
			rail[#rail + 1] = ('    <a href="#%s"><b>%s</b>%s<i>%d</i></a>'):format(g.id, esc(g.rail), g.id, #rows)

			out[#out + 1] = ('    <section class="grp" id="%s" data-tags="%s">'):format(g.id, g.tags)
			out[#out + 1] = '      <header class="grp-h">'
			out[#out + 1] = ("        <h2>%s</h2>"):format(g.title)
			if g.suffix then
				out[#out + 1] = ('        <span class="grp-x">%s</span>'):format(g.suffix)
			end
			if g.shown then
				out[#out + 1] = ('        <span class="grp-p">%s</span>'):format(esc(g.shown))
			end
			out[#out + 1] = ('        <span class="grp-n">%d</span>'):format(#rows)
			out[#out + 1] = "      </header>"
			out[#out + 1] = ('      <p class="grp-note">%s</p>'):format(g.hint)
			out[#out + 1] = '      <ul class="rows">'

			for _, r in ipairs(rows) do
				-- Strip the group prefix so the column shows only what you press
				-- next; the full sequence stays in data-key so the filter and a
				-- copy still see it. Rows outside the prefix keep their whole key.
				local shown_key, lead = r.lhs, false
				if g.prefix and #r.lhs > #g.prefix and r.lhs:sub(1, #g.prefix) == g.prefix then
					shown_key, lead = r.lhs:sub(#g.prefix + 1), true
				end
				local note = r.note and (' <span class="n">%s</span>'):format(esc(r.note)) or ""
				out[#out + 1] = ('        <li class="km" data-key="%s"><span class="k%s">%s</span><span class="d">%s%s</span><span class="m">%s</span></li>'):format(
					esc(r.lhs),
					lead and "" or " k--full",
					spaces(shown_key),
					esc(r.desc),
					note,
					r.modes
				)
				total = total + 1
			end

			out[#out + 1] = "      </ul>"
			out[#out + 1] = "    </section>"
		end
	end

	rail[#rail + 1] = "  </nav>"
	return table.concat(rail, "\n") .. '\n  <div class="col">\n' .. table.concat(out, "\n") .. "\n  </div>", total
end

-- ── commands ────────────────────────────────────────────────────────────────

local BEGIN, FINISH = "<!-- BEGIN GENERATED -->", "<!-- END GENERATED -->"

function M.export()
	local page = io.open(PAGE, "r")
	if not page then
		error("cannot read " .. PAGE)
	end
	local html = page:read("*a")
	page:close()

	-- Plain (non-pattern) find: the markers contain `-`, a Lua pattern quantifier.
	local _, bend = html:find(BEGIN, 1, true)
	local fstart = html:find(FINISH, 1, true)
	if not bend or not fstart or fstart < bend then
		error("markers not found in " .. PAGE .. " -- expected " .. BEGIN .. " / " .. FINISH)
	end
	local head, tail = html:sub(1, bend), html:sub(fstart)

	local body, total = M.render(M.collect())
	local f = assert(io.open(PAGE, "w"))
	f:write(head .. "\n" .. body .. tail)
	f:close()
	return total
end

vim.api.nvim_create_user_command("KeymapExport", function()
	local ok, res = pcall(M.export)
	if ok then
		vim.notify(("Wrote %d keymaps to site/index.html"):format(res))
	else
		vim.notify(tostring(res), vim.log.levels.ERROR)
	end
end, { desc = "Regenerate the keymap reference site" })

return M
