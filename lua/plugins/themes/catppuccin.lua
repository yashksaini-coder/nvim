-- Catppuccin: pastel theme, 4 flavors (latte=light, frappe/macchiato/mocha=dark)
-- https://github.com/catppuccin/nvim
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- default when first loaded; user can switch via Themery
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      telescope = true,
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    -- Don't set colorscheme here; Themery will set one of the flavors
  end,
}
