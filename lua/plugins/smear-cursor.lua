return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  cond = vim.g.neovide == nil, -- Disable in Neovide to avoid conflict
  opts = {
    -- Sets the color of the smear trail.
    -- Matching Tokyo Night's orange accent for a "blazer" feel.
    cursor_color = "#ff9e64",

    -- Controls how quickly the cursor catches up to the target (0.0 - 1.0).
    -- Higher is faster/stiffer (Blazing fast).
    stiffness = 0.8,

    -- Controls how quickly the tail of the smear catches up (0.0 - 1.0).
    trailing_stiffness = 0.5,

    -- The distance at which the animation snaps to the end position.
    distance_stop_animating = 0.5,

    -- Helps prevent the "real" cursor from flickering or being visible at the
    -- target destination before the animation finishes.
    hide_target_hack = false,

    -- Enable particles for the "blazing" fire effect
    particles_enabled = true,
    never_draw_over_target = true, -- Recommended when particles are enabled
  },
}
