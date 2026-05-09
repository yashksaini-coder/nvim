return {
  "p00f/clangd_extensions.nvim",
  ft = { "c", "cpp", "objc", "objcpp" },
  opts = {
    ast = {
      role_icons = {
        type = "🄣",
        declaration = "🄓",
        expression = "🄔",
        statement = ";",
        specifier = "🄢",
        ["template argument"] = "🆃",
      },
    },
    memory_usage = { border = "rounded" },
    symbol_info = { border = "rounded" },
  },
  keys = {
    {
      "<leader>cm",
      "<cmd>ClangdMemoryUsage<cr>",
      desc = "clangd: memory usage",
      ft = { "c", "cpp" },
    },
    {
      "<leader>ch",
      "<cmd>ClangdSwitchSourceHeader<cr>",
      desc = "clangd: switch header/source",
      ft = { "c", "cpp" },
    },
    { "<leader>cT", "<cmd>ClangdAST<cr>", desc = "clangd: AST", ft = { "c", "cpp" } },
    {
      "<leader>cy",
      "<cmd>ClangdSymbolInfo<cr>",
      desc = "clangd: symbol info",
      ft = { "c", "cpp" },
    },
  },
}
