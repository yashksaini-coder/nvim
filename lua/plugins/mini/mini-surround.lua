-- Add/delete/replace surrounding pairs. Mapped under `gs` rather than mini's own
-- `sa/sd/sr` defaults, because flash.nvim owns `s` now — and which-key already
-- declared a `gs` "surround" group with nothing behind it.
return {
	"nvim-mini/mini.surround",
	version = "*",
	keys = {
		{ "gsa", desc = "Add surrounding", mode = { "n", "v" } },
		{ "gsd", desc = "Delete surrounding" },
		{ "gsf", desc = "Find right surrounding" },
		{ "gsF", desc = "Find left surrounding" },
		{ "gsh", desc = "Highlight surrounding" },
		{ "gsr", desc = "Replace surrounding" },
		{ "gsn", desc = "Update n_lines" },
	},
	opts = {
		mappings = {
			add = "gsa",
			delete = "gsd",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "gsr",
			update_n_lines = "gsn",
		},
	},
}
