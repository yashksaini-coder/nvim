# Language support

| Language | LSP | Formatter | Linter | DAP |
|---|---|---|---|---|
| **C / C++** | clangd | clang-format | clangd-tidy | codelldb |
| **Rust** | rust-analyzer (via rustaceanvim) | rustfmt | clippy | codelldb |
| **Go** | gopls | gofumpt + goimports | golangci-lint | delve |
| **Python** | pyright | black + isort | ruff | debugpy |
| **JavaScript / TypeScript** | typescript-language-server | prettierd | eslint_d | js-debug-adapter |
| **Lua** | lua-language-server | stylua | luacheck | — |
| **C#** | omnisharp | csharpier | — | — |

All adapters are auto-installed via `mason-tool-installer.nvim`.
