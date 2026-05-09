return {
  "rafamadriz/friendly-snippets",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = { vim.fn.stdpath("config") .. "/lua/utils/snippets" },
    })
  end,
}
