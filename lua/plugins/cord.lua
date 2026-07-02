-- Discord Rich Presence. Requires a native Discord client running (Vesktop /
-- pacman `discord` / etc.) so that /run/user/$UID/discord-ipc-0 exists.
-- Config uses cord.nvim v2 schema.

-- Show " — N problems" if the current buffer has WARN-or-worse diagnostics.
-- Inlined instead of using cord's `diagnostics` extension because that
-- extension force-overrides `viewing`/`editing` back to "Viewing"/"Editing",
-- which clashes with the "Reading" wording chosen below.
local function problems_suffix(bufnr)
	local n = #vim.diagnostic.get(bufnr or 0, {
		severity = { min = vim.diagnostic.severity.WARN },
	})
	if n == 0 then return "" end
	return " — " .. n .. " " .. (n == 1 and "problem" or "problems")
end

return {
	"vyfor/cord.nvim",
	event = "VeryLazy",
	---@type CordConfig
	opts = {
		editor = {
			-- Show up as Vim on Discord.
			client = "vim",
			icon = "vim",
			tooltip = "The Superior Text Editor",
		},
		display = {
			theme = "default",
			flavor = "dark",
			view = "full", -- large icon = language, small icon = editor
		},
		timestamp = {
			enabled = true,
			-- Reset the "coding for X" counter each time you cd into a new project.
			reset_on_change = true,
			reset_on_idle = false,
		},
		idle = {
			enabled = true,
			timeout = 5 * 60 * 1000, -- 5 minutes of inactivity → idle
			show_status = true,
			ignore_focus = true,
			smart_idle = true,
			details = "Idling",
			tooltip = "💤",
		},
		text = {
			-- Function form gets `opts` with .filename, .workspace, .name, .filetype.
			workspace = function(opts)
				return (opts.workspace and opts.workspace ~= "") and ("In " .. opts.workspace) or "In nvim"
			end,
			viewing = function(opts) return "Reading " .. opts.filename .. problems_suffix() end,
			editing = function(opts) return "Editing " .. opts.filename .. problems_suffix() end,
			file_browser = function(opts) return "Browsing files in " .. opts.name end,
			plugin_manager = function(opts) return "Managing plugins in " .. opts.name end,
			lsp = function(opts) return "Configuring LSP in " .. opts.name end,
			docs = function(opts) return "Reading " .. opts.name .. " docs" end,
			vcs = function(opts) return "Committing changes in " .. opts.name end,
			notes = function(opts) return "Taking notes in " .. opts.name end,
			debug = function(opts) return "Debugging in " .. opts.name end,
			test = function(opts) return "Testing in " .. opts.name end,
			diagnostics = function(opts) return "Fixing problems in " .. opts.name end,
			games = function(opts) return "Playing " .. opts.name end,
			terminal = function(opts) return "In a terminal (" .. opts.name .. ")" end,
			dashboard = "On the dashboard",
		},
		buttons = {
			-- Up to 2 buttons. Discord requires http(s) URLs.
			{ label = "GitHub", url = "https://github.com/yashksaini-coder" },
		},
		hooks = {
			-- Emit a one-time notification when the Discord handshake completes.
			-- Fires when the session enters `ready`; helps confirm setup on first use.
			ready = function()
				vim.schedule(function()
					vim.notify("Connected to Discord", vim.log.levels.INFO, { title = "cord.nvim" })
				end)
			end,
		},
		advanced = {
			discord = {
				-- Retry when Discord starts later or restarts.
				reconnect = { enabled = true, interval = 30000, initial = true },
			},
		},
	},
}
