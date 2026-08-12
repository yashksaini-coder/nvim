-- "Ninja-cursor" — smooth trailing line when the cursor jumps.
-- Pure lua, no deps. Wayland/tmux both fine; terminals need truecolor.
return {
	"sphamba/smear-cursor.nvim",
	event = "VeryLazy",
	opts = {
		stiffness = 0.6,           -- head speed toward target (0..1, higher = snappier)
		trailing_stiffness = 0.4,  -- tail speed; keep below stiffness so the smear reads
		cursor_color = "none",     -- inherit from colorscheme (recolor via a theme highlight)
		smear_between_buffers = true,
		smear_between_neighbor_lines = true,
		legacy_computing_symbols_support = false,
	},
}
