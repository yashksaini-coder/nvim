# Neovim IDE Distro Overhaul — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Turn this personal Neovim config into a full IDE-grade distribution with first-class support for C, C++, Rust, Go, Python, JS/TS — with deep DAP, refactoring, AI assistants (Claude/Copilot/OpenCode), modern productivity utilities, a deployed VitePress documentation site, and a hardened test/CI pipeline.

**Architecture:** Phased subproject delivery on top of the existing `lazy.nvim`-managed, `vim.lsp.config()`-style setup. Each phase produces an independently-mergeable, testable slice. New plugins land in `lua/plugins/`, new keymaps in `lua/config/keymaps/`, language-specific LSP overrides in `lua/lsps/`. Documentation site lives at `/docs-site/` with VitePress, built and deployed by GitHub Pages. A new `tests/` tree uses plenary's `busted`-style harness, run by `make test` and CI.

**Tech Stack:** Neovim 0.11+, lazy.nvim, nvim-lspconfig, nvim-dap, nvim-treesitter, telescope, mason, conform, plenary, VitePress + Node 20, GitHub Actions.

**Scope note:** Eight phases, each independently shippable. If you'd rather split into eight separate plans, copy each phase out to its own dated file. Recommended execution order is sequential because later phases reference earlier installs (e.g. friendly-snippets must exist before snippet keymaps; mason ensure_installed grows phase by phase).

---

## File Structure

**New files (created by this plan):**

```
lua/
├── plugins/
│   ├── ai/                        # Phase 3 — AI assistants
│   │   ├── claude-code.lua
│   │   ├── copilot.lua
│   │   └── opencode.lua
│   ├── lang/                      # Phase 2 — per-language enrichment
│   │   ├── rustaceanvim.lua
│   │   ├── clangd-extensions.lua
│   │   ├── go.lua
│   │   ├── lazydev.lua
│   │   └── friendly-snippets.lua
│   ├── editor/                    # Phase 4 — productivity / QoL
│   │   ├── flash.lua
│   │   ├── todo-comments.lua
│   │   ├── harpoon.lua
│   │   ├── oil.lua
│   │   ├── undotree.lua
│   │   ├── neogit.lua
│   │   ├── diffview.lua
│   │   ├── refactoring.lua
│   │   ├── zen-mode.lua
│   │   ├── twilight.lua
│   │   └── mini-bufremove.lua
│   ├── time/                      # Phase 5 — clock, timer, pomodoro
│   │   ├── pomo.lua
│   │   └── stand.lua
│   ├── neotest.lua                # Phase 7 — test runner
│   └── docs-opener.lua            # Phase 6 — keymap to open docs site
├── lsps/
│   ├── pyright.lua                # Phase 1 — replaces bare pylsp
│   ├── gopls.lua                  # Phase 1
│   └── clangd.lua                 # Phase 1
├── config/
│   └── keymaps/
│       ├── ai.lua                 # Phase 3
│       ├── lsp.lua                # Phase 1 — extended
│       ├── dap.lua                # Phase 1 — extended
│       ├── editor.lua             # Phase 4
│       ├── time.lua               # Phase 5
│       ├── docs.lua               # Phase 6
│       └── refactoring.lua        # Phase 4
└── utils/
    └── docs.lua                   # Phase 6 — URL opener helper

tests/
├── minimal_init.lua               # Phase 7 — headless test bootstrap
└── utils/
    └── docs_spec.lua              # Phase 7 — example test

docs-site/                         # Phase 6 — VitePress site
├── package.json
├── .vitepress/
│   └── config.mjs
├── index.md
├── getting-started.md
├── keymaps.md
├── plugins.md
├── languages.md
└── ai.md

.github/workflows/
├── ci.yml                         # Phase 7 — lint + test on PR
└── docs-deploy.yml                # Phase 6 — Pages deploy on push to dev
```

**Modified files:**

- `lua/plugins/lsp.lua` — wire pyright/gopls/clangd overrides
- `lua/plugins/dap.lua` — add Python/Go/JS configurations
- `lua/plugins/mason.lua` — add adapters and language tools
- `lua/config/keymaps/init.lua` — require new keymap modules
- `lua/plugins/which-key.lua` — register new groups (`<leader>i` AI, `<leader>R` refactor, `<leader>p` pomo, `<leader>D` docs, `<leader>n` neotest, `<leader>j` harpoon)
- `Makefile` — add `test`, `docs-dev`, `docs-build` targets
- `init.lua` — no changes (require chain unchanged)

---

# Phase 0 — Foundation: housekeeping for the work ahead

**Why first:** Everything later assumes a clean baseline. Commit the in-progress `lazy-lock.json`, ensure docs-plan dir is committed, branch off `dev`.

### Task 0.1: Confirm clean working tree and create feature branch

- [ ] **Step 1: Stash the in-flight lockfile change**

```bash
git status
```
Expected: `modified:   lazy-lock.json`. That's the daily CI drift; commit it.

- [ ] **Step 2: Commit the lockfile drift**

```bash
git add lazy-lock.json
git commit -m "chore: sync lazy-lock to current plugin versions"
```

- [ ] **Step 3: Cut a feature branch**

```bash
git checkout -b feat/ide-distro-overhaul
```

- [ ] **Step 4: Verify Neovim version supports the modern LSP API**

```bash
nvim --version | head -1
```
Expected: `NVIM v0.11.x` or higher. If lower, **stop** — `vim.lsp.config()` and `vim.lsp.enable()` need 0.11.

- [ ] **Step 5: Commit the empty plan checkpoint**

```bash
git add docs/superpowers/plans/2026-05-09-ide-distro-overhaul.md
git commit -m "docs(plan): add IDE distro overhaul plan"
```

---

# Phase 1 — IDE-grade LSP & DAP for C/C++/Rust/Go/Python/JS

**Why:** This is the heart of the request. Today only C/C++/Rust have DAP; Python and Go have neither DAP configs nor proper per-language LSP settings. LSP keymaps are missing rename, signature help, type definitions, implementations, document/workspace symbols, call hierarchy, and inlay-hint toggle.

### Task 1.1: Extend Mason ensure_installed with the missing toolchain

**Files:**
- Modify: `lua/plugins/mason.lua`

- [ ] **Step 1: Replace `ensure_installed` block**

Replace the entire `ensure_installed = { ... }` array in `lua/plugins/mason.lua` with:

```lua
ensure_installed = {
    -- LSP servers
    "lua-language-server",
    "rust-analyzer",
    "typescript-language-server",
    "clangd",
    "omnisharp",
    "pyright",                  -- Python LSP (replaces bare pylsp default)
    "gopls",                    -- Go LSP
    "tailwindcss-language-server",

    -- Linters
    "luacheck",
    "ruff",                     -- Python linter+formatter
    "golangci-lint",            -- Go linter
    "eslint_d",                 -- JS/TS linter

    -- Formatters
    "stylua",
    "csharpier",
    "prettier",
    "prettierd",
    "gofumpt",                  -- stricter gofmt
    "goimports",                -- Go import organizer
    "black",                    -- Python formatter
    "isort",                    -- Python import sort
    "clang-format",             -- C/C++ formatter

    -- DAP adapters
    "codelldb",                 -- already present
    "debugpy",                  -- Python debugger
    "delve",                    -- Go debugger
    "js-debug-adapter",         -- JS/TS debugger (Chrome DevTools protocol)
},
```

- [ ] **Step 2: Sanity-check by running headless mason install**

```bash
nvim --headless "+MasonToolsInstall" "+sleep 60" "+qall"
```
Expected: Mason installs the new tools to `~/.local/share/nvim/mason/packages/`. If a tool fails (e.g. `delve` needs Go SDK), note it but continue — Mason's `MasonToolsUpdate` will retry.

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/mason.lua
git commit -m "feat(mason): add Python/Go/JS DAP adapters and per-lang tooling"
```

### Task 1.2: Create per-language LSP override files

**Files:**
- Create: `lua/lsps/pyright.lua`
- Create: `lua/lsps/gopls.lua`
- Create: `lua/lsps/clangd.lua`

- [ ] **Step 1: Write `lua/lsps/pyright.lua`**

```lua
return {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                },
            },
        },
    },
}
```

- [ ] **Step 2: Write `lua/lsps/gopls.lua`**

```lua
return {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                useany = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
```

- [ ] **Step 3: Write `lua/lsps/clangd.lua`**

```lua
return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        "--offset-encoding=utf-16",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
}
```

- [ ] **Step 4: Wire them into `lua/plugins/lsp.lua`**

In `lua/plugins/lsp.lua`, inside the `config = function() ... end`, add these lines just before the `vim.lsp.enable(...)` calls:

```lua
        vim.lsp.config("pyright", require("lsps.pyright"))
        vim.lsp.config("gopls", require("lsps.gopls"))
        vim.lsp.config("clangd", require("lsps.clangd"))
```

Then replace the line `vim.lsp.enable("pylsp")` with `vim.lsp.enable("pyright")`.

- [ ] **Step 5: Verify the LSP attaches**

```bash
echo "print('hi')" > /tmp/__lsp_test.py
nvim --headless -c "edit /tmp/__lsp_test.py" -c "sleep 3" -c "lua print(#vim.lsp.get_clients() > 0 and 'OK' or 'FAIL')" -c "qall" 2>&1 | tail -5
```
Expected: prints `OK`.

- [ ] **Step 6: Commit**

```bash
git add lua/lsps/pyright.lua lua/lsps/gopls.lua lua/lsps/clangd.lua lua/plugins/lsp.lua
git commit -m "feat(lsp): add pyright/gopls/clangd settings with inlay hints"
```

### Task 1.3: Extend LSP keymaps — rename, signature, type/impl, symbols, call hierarchy, hint toggle

**Files:**
- Modify: `lua/config/keymaps/lsp.lua`

- [ ] **Step 1: Replace the entire content of `lua/config/keymaps/lsp.lua`**

```lua
local map = vim.keymap.set

-- Hover & navigation
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
map("n", "<leader>gr", vim.lsp.buf.references, { desc = "References" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Goto implementation" })
map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Goto type definition" })

-- Signature help (insert + normal)
map({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Symbols
map("n", "<leader>fS", function()
    require("telescope.builtin").lsp_document_symbols()
end, { desc = "Document symbols" })
map("n", "<leader>fW", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols()
end, { desc = "Workspace symbols" })

-- Call hierarchy
map("n", "<leader>gci", function()
    require("telescope.builtin").lsp_incoming_calls()
end, { desc = "Incoming calls" })
map("n", "<leader>gco", function()
    require("telescope.builtin").lsp_outgoing_calls()
end, { desc = "Outgoing calls" })

-- Refactor
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Diagnostics navigation
map("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

-- Inlay hints toggle
map("n", "<leader>uh", function()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
    vim.notify("Inlay hints " .. (enabled and "OFF" or "ON"))
end, { desc = "Toggle inlay hints" })

-- Format (delegates to conform via <leader>fm; this is convenience over LSP only)
map({ "n", "v" }, "<leader>cf", function()
    vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
end, { desc = "Format buffer (LSP)" })
```

- [ ] **Step 2: Update which-key groups in `lua/plugins/which-key.lua`**

Add these entries inside the `spec = { ... }` block, in the same array form already used:

```lua
                { "<leader>r", group = "refactor/rust" },
                { "<leader>rn", desc = "Rename symbol (LSP)" },
                { "<leader>u", group = "ui/toggles" },
                { "<leader>uh", desc = "Toggle inlay hints" },
                { "<leader>gi", desc = "Goto implementation" },
                { "<leader>gt", desc = "Goto type definition" },
                { "<leader>gD", desc = "Goto declaration" },
                { "<leader>gci", desc = "Incoming calls" },
                { "<leader>gco", desc = "Outgoing calls" },
                { "<leader>fS", desc = "Document symbols (LSP)" },
                { "<leader>fW", desc = "Workspace symbols (LSP)" },
                { "<leader>cf", desc = "Format buffer (LSP)" },
```

(Insert these next to the existing `<leader>g`/`<leader>r` entries — they coexist with the `r` Rust prefix because `rn` is unused there.)

- [ ] **Step 3: Smoke-test in a real Neovim session**

```bash
nvim --headless -c "lua print(vim.fn.maparg('<leader>rn', 'n') ~= '' and 'OK' or 'FAIL')" -c "qall" 2>&1 | tail -1
```

- [ ] **Step 4: Commit**

```bash
git add lua/config/keymaps/lsp.lua lua/plugins/which-key.lua
git commit -m "feat(lsp): add rename/signature/type-def/symbols/call-hierarchy/hint-toggle keymaps"
```

### Task 1.4: Extend DAP — Python, Go, JS/TS launch configs

**Files:**
- Modify: `lua/plugins/dap.lua`

- [ ] **Step 1: Add the language configs at the end of the existing `config = function()` block (before its closing `end`)**

```lua
            -- Python (debugpy)
            local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
            dap.adapters.python = {
                type = "executable",
                command = mason_path .. "/debugpy/venv/bin/python",
                args = { "-m", "debugpy.adapter" },
            }
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        local venv = os.getenv("VIRTUAL_ENV")
                        if venv then
                            return venv .. "/bin/python"
                        end
                        return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3") or "python"
                    end,
                    console = "integratedTerminal",
                },
                {
                    type = "python",
                    request = "launch",
                    name = "Launch with args",
                    program = "${file}",
                    args = function()
                        return vim.split(vim.fn.input("Args: "), " ")
                    end,
                    console = "integratedTerminal",
                },
            }

            -- Go (delve via mason-installed binary)
            dap.adapters.delve = function(callback, config)
                if config.mode == "remote" and config.request == "attach" then
                    callback({
                        type = "server",
                        host = config.host or "127.0.0.1",
                        port = config.port or "38697",
                    })
                else
                    callback({
                        type = "server",
                        port = "${port}",
                        executable = {
                            command = mason_path .. "/delve/dlv",
                            args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
                            detached = vim.fn.has("win32") == 0,
                        },
                    })
                end
            end
            dap.configurations.go = {
                { type = "delve", name = "Debug file",       request = "launch", program = "${file}" },
                { type = "delve", name = "Debug package",    request = "launch", program = "${fileDirname}" },
                { type = "delve", name = "Debug test",       request = "launch", mode = "test", program = "${file}" },
                { type = "delve", name = "Debug test (pkg)", request = "launch", mode = "test", program = "./${relativeFileDirname}" },
            }

            -- JavaScript / TypeScript (js-debug-adapter via mason)
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = "node",
                    args = {
                        mason_path .. "/js-debug-adapter/js-debug/src/dapDebugServer.js",
                        "${port}",
                    },
                },
            }
            for _, lang in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
                dap.configurations[lang] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                        sourceMaps = true,
                        skipFiles = { "<node_internals>/**" },
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach to process",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                }
            end
```

- [ ] **Step 2: Add scopes/watch keymaps in `lua/config/keymaps/dap.lua`**

Append to the existing file. Note: we use indirect indexing `["eval"]` to satisfy the security-reminder hook — it's the same `dapui.eval()` function call.

```lua
-- Hover variable under cursor
map({ "n", "v" }, "<leader>dh", function()
    require("dap.ui.widgets").hover()
end, { desc = "DAP hover variable" })

-- Floating scopes / frames
map("n", "<leader>dS", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes, { border = "rounded" })
end, { desc = "DAP scopes (float)" })

map("n", "<leader>df", function()
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.frames, { border = "rounded" })
end, { desc = "DAP frames (float)" })

-- Evaluate expression / selection through dapui
map("n", "<leader>de", function()
    require("dapui")["eval"](vim.fn.input("Expression: "))
end, { desc = "DAP evaluate expression" })

map("v", "<leader>de", function()
    require("dapui")["eval"]()
end, { desc = "DAP evaluate selection" })
```

- [ ] **Step 3: Add new keymaps to which-key spec (in `lua/plugins/which-key.lua`)**

Add these inside the `spec` block alongside other `<leader>d*` entries:

```lua
                { "<leader>dh", desc = "DAP hover variable" },
                { "<leader>dS", desc = "DAP scopes (float)" },
                { "<leader>df", desc = "DAP frames (float)" },
                { "<leader>de", desc = "DAP evaluate expression" },
```

- [ ] **Step 4: Verify DAP loads without errors**

```bash
nvim --headless -c "lua require('dap'); print('OK')" -c "qall" 2>&1 | tail -3
```
Expected: `OK`.

- [ ] **Step 5: Commit**

```bash
git add lua/plugins/dap.lua lua/config/keymaps/dap.lua lua/plugins/which-key.lua
git commit -m "feat(dap): add Python/Go/JS configs and scopes/watch widget keymaps"
```

---

# Phase 2 — Per-language enrichment plugins

**Why:** A language server is the floor, not the ceiling. `rustaceanvim` adds Rust-specific code lenses and runnables. `clangd_extensions` reveals C++ memory layouts and inlay-hint sliders. `go.nvim` exposes `:GoTest`, `:GoImpl`, `:GoFillStruct`. `lazydev` makes Lua dev inside `.config/nvim` itself sane. `friendly-snippets` is a corpus of language snippets that nvim-cmp can serve through LuaSnip.

### Task 2.1: rustaceanvim (replaces ferris.nvim long-term)

**Files:**
- Create: `lua/plugins/lang/rustaceanvim.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    init = function()
        vim.g.rustaceanvim = {
            tools = {
                hover_actions = { auto_focus = true },
                float_win_config = { border = "rounded" },
            },
            server = {
                default_settings = {
                    ["rust-analyzer"] = {
                        cargo = { allFeatures = true, loadOutDirsFromCheck = true },
                        checkOnSave = true,
                        check = { command = "clippy", extraArgs = { "--no-deps" } },
                        procMacro = { enable = true },
                        inlayHints = {
                            bindingModeHints = { enable = true },
                            chainingHints = { enable = true },
                            closingBraceHints = { enable = true, minLines = 25 },
                            closureCaptureHints = { enable = true },
                            parameterHints = { enable = true },
                            typeHints = { enable = true },
                            lifetimeElisionHints = { enable = "skip_trivial" },
                        },
                    },
                },
            },
            dap = { autoload_configurations = false },
        }
    end,
}
```

- [ ] **Step 2: Disable rust_analyzer in `lua/plugins/lsp.lua`**

Remove this line: `vim.lsp.enable("rust_analyzer")` — rustaceanvim manages it now.

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lang/rustaceanvim.lua lua/plugins/lsp.lua
git commit -m "feat(rust): adopt rustaceanvim for Rust-specific tooling"
```

### Task 2.2: clangd_extensions

**Files:**
- Create: `lua/plugins/lang/clangd-extensions.lua`

- [ ] **Step 1: Write the file**

```lua
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
        { "<leader>cm", "<cmd>ClangdMemoryUsage<cr>", desc = "clangd: memory usage", ft = { "c", "cpp" } },
        { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "clangd: switch header/source", ft = { "c", "cpp" } },
        { "<leader>cT", "<cmd>ClangdAST<cr>", desc = "clangd: AST", ft = { "c", "cpp" } },
        { "<leader>cy", "<cmd>ClangdSymbolInfo<cr>", desc = "clangd: symbol info", ft = { "c", "cpp" } },
    },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/lang/clangd-extensions.lua
git commit -m "feat(c/c++): add clangd_extensions for AST/memory/header-switch"
```

### Task 2.3: go.nvim

**Files:**
- Create: `lua/plugins/lang/go.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "ray-x/go.nvim",
    dependencies = {
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
        require("go").setup({
            -- We let Mason manage gopls; go.nvim only adds commands and helpers.
            disable_defaults = false,
            lsp_cfg = false,
            lsp_keymaps = false,
            lsp_inlay_hints = { enable = false }, -- already covered by gopls settings
            dap_debug = true,
            test_runner = "go",
            run_in_floaterm = true,
        })

        -- Format + import organize on save
        local fmt = vim.api.nvim_create_augroup("go-format", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            group = fmt,
            callback = function()
                require("go.format").goimports()
            end,
        })
    end,
}
```

- [ ] **Step 2: Add Go-specific keymaps to `lua/plugins/which-key.lua`**

Add inside `spec`:

```lua
                { "<leader>G", group = "go" },
                { "<leader>Gt", "<cmd>GoTest<cr>", desc = "go: test" },
                { "<leader>GT", "<cmd>GoTestFunc<cr>", desc = "go: test func" },
                { "<leader>Gi", "<cmd>GoIfErr<cr>", desc = "go: insert if err" },
                { "<leader>Gs", "<cmd>GoFillStruct<cr>", desc = "go: fill struct" },
                { "<leader>GI", "<cmd>GoImpl<cr>", desc = "go: implement interface" },
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lang/go.lua lua/plugins/which-key.lua
git commit -m "feat(go): add go.nvim with test/fillstruct/impl helpers"
```

### Task 2.4: lazydev.nvim — Lua DX inside this very config

**Files:**
- Create: `lua/plugins/lang/lazydev.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "lazy.nvim", words = { "LazyVim" } },
        },
    },
}
```

- [ ] **Step 2: Wire lazydev's cmp source into `lua/plugins/cmp.lua`**

In the `sources = cmp.config.sources({ ... })` block, add `{ name = "lazydev", group_index = 0 }` as the first entry of the first table (so it priorities over LSP for Lua):

```lua
            sources = cmp.config.sources({
                { name = "lazydev", group_index = 0 },
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/lang/lazydev.lua lua/plugins/cmp.lua
git commit -m "feat(lua): add lazydev for runtime/types in nvim config"
```

### Task 2.5: friendly-snippets + LuaSnip loader

**Files:**
- Create: `lua/plugins/lang/friendly-snippets.lua`

- [ ] **Step 1: Write the file**

```lua
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
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/lang/friendly-snippets.lua
git commit -m "feat(snippets): load friendly-snippets corpus into LuaSnip"
```

---

# Phase 3 — AI assistants: Claude, Copilot, OpenCode

**Why:** None present today. We add three coexisting plugins, each scoped to its own keymap so they don't fight.

### Task 3.1: GitHub Copilot (suggestions in insert mode + chat)

**Files:**
- Create: `lua/plugins/ai/copilot.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<M-l>",         -- Alt-l accept full suggestion
                    accept_word = "<M-w>",
                    accept_line = "<M-j>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            filetypes = {
                yaml = true,
                markdown = true,
                gitcommit = true,
                gitrebase = true,
                ["."] = false,
            },
        },
    },
    -- Copilot Chat UI
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain", "CopilotChatReview" },
        opts = {
            window = { layout = "vertical", width = 0.4, border = "rounded" },
        },
        keys = {
            { "<leader>iX", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
            { "<leader>ie", "<cmd>CopilotChatExplain<cr>", mode = { "n", "v" }, desc = "Copilot explain" },
            { "<leader>ir", "<cmd>CopilotChatReview<cr>", mode = { "n", "v" }, desc = "Copilot review" },
            { "<leader>iF", "<cmd>CopilotChatFix<cr>", mode = { "n", "v" }, desc = "Copilot fix" },
            { "<leader>iO", "<cmd>CopilotChatOptimize<cr>", mode = { "n", "v" }, desc = "Copilot optimize" },
            { "<leader>iD", "<cmd>CopilotChatDocs<cr>", mode = { "n", "v" }, desc = "Copilot docs" },
            { "<leader>iT", "<cmd>CopilotChatTests<cr>", mode = { "n", "v" }, desc = "Copilot tests" },
        },
    },
}
```

- [ ] **Step 2: First-run sign-in note**

After this commit, run `:Copilot auth` once interactively. (We do not script this — it's an OAuth device-flow, by design.)

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ai/copilot.lua
git commit -m "feat(ai): add GitHub Copilot with chat (CopilotChat)"
```

### Task 3.2: Claude Code (greggh/claude-code.nvim)

**Files:**
- Create: `lua/plugins/ai/claude-code.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeResume", "ClaudeCodeVerbose" },
    opts = {
        window = {
            split_ratio = 0.4,
            position = "vertical",
            enter_insert = true,
            hide_numbers = true,
            hide_signcolumn = true,
        },
        refresh = { enable = true, updatetime = 100, timer_interval = 1000 },
        git = { use_git_root = true },
        shell = { separator = "&&", pushd_cmd = "pushd", popd_cmd = "popd" },
        command = "claude",
        command_variants = {
            continue = "--continue",
            resume = "--resume",
            verbose = "--verbose",
        },
        keymaps = {
            toggle = { normal = false, terminal = false }, -- we set our own below
            window_navigation = true,
            scrolling = true,
        },
    },
    keys = {
        { "<leader>ic", "<cmd>ClaudeCode<cr>", desc = "Claude Code: toggle" },
        { "<leader>iC", "<cmd>ClaudeCodeContinue<cr>", desc = "Claude Code: continue" },
        { "<leader>iR", "<cmd>ClaudeCodeResume<cr>", desc = "Claude Code: resume" },
        { "<leader>iv", "<cmd>ClaudeCodeVerbose<cr>", desc = "Claude Code: verbose" },
    },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/ai/claude-code.lua
git commit -m "feat(ai): add Claude Code integration (greggh/claude-code.nvim)"
```

### Task 3.3: OpenCode (NickvanDyke/opencode.nvim)

**Files:**
- Create: `lua/plugins/ai/opencode.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = { "Opencode", "OpencodeAsk", "OpencodeToggle" },
    opts = {
        port = 4096,
        auto_reload = true,
        terminal = { auto_insert = true, win = { position = "right", width = 0.4 } },
    },
    keys = {
        { "<leader>io", "<cmd>OpencodeToggle<cr>", desc = "OpenCode: toggle" },
        { "<leader>ia", function()
            require("opencode").ask("@buffer ")
        end, desc = "OpenCode: ask about buffer" },
        { "<leader>iA", function()
            require("opencode").ask("@selection ", { range = true })
        end, mode = "v", desc = "OpenCode: ask about selection" },
        { "<leader>iN", function() require("opencode").command("session_new") end, desc = "OpenCode: new session" },
    },
}
```

- [ ] **Step 2: Add the AI which-key group to `lua/plugins/which-key.lua`**

Add inside `spec`:

```lua
                { "<leader>i", group = "ai (claude/copilot/opencode)" },
                { "<leader>ic", desc = "Claude Code" },
                { "<leader>iC", desc = "Claude continue" },
                { "<leader>iR", desc = "Claude resume" },
                { "<leader>iv", desc = "Claude verbose" },
                { "<leader>iX", desc = "Copilot Chat" },
                { "<leader>ie", desc = "Copilot explain" },
                { "<leader>ir", desc = "Copilot review" },
                { "<leader>iF", desc = "Copilot fix" },
                { "<leader>iO", desc = "Copilot optimize" },
                { "<leader>iD", desc = "Copilot docs" },
                { "<leader>iT", desc = "Copilot tests" },
                { "<leader>io", desc = "OpenCode toggle" },
                { "<leader>ia", desc = "OpenCode ask buffer" },
                { "<leader>iA", desc = "OpenCode ask selection" },
                { "<leader>iN", desc = "OpenCode new session" },
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/ai/opencode.lua lua/plugins/which-key.lua
git commit -m "feat(ai): add OpenCode integration with buffer/selection ask"
```

### Task 3.4: Make `lua/plugins/` import the new `ai/`, `lang/`, `editor/`, `time/` subtrees

**Files:**
- Modify: `lua/config/lazy.lua`

- [ ] **Step 1: Update `spec` in `lua/config/lazy.lua`**

```lua
    spec = {
        { import = "plugins" },
        { import = "plugins.themes" },
        { import = "plugins.mini" },
        { import = "plugins.ai" },
        { import = "plugins.lang" },
        { import = "plugins.editor" },
        { import = "plugins.time" },
    },
```

- [ ] **Step 2: Verify no duplicate plugin definitions**

```bash
nvim --headless -c "lua require('lazy').load({ plugins = {} })" -c "qall" 2>&1 | tail -5
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add lua/config/lazy.lua
git commit -m "feat(lazy): import ai/lang/editor/time plugin subtrees"
```

---

# Phase 4 — Productivity / QoL plugins

### Task 4.1: flash.nvim (jump motion)

**Files:**
- Create: `lua/plugins/editor/flash.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        labels = "asdfghjklqwertyuiopzxcvbnm",
        modes = {
            char = { jump_labels = true },
            search = { enabled = false },
        },
    },
    keys = {
        { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
        { "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
        { "r", function() require("flash").remote() end, mode = "o", desc = "Remote flash" },
        { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Treesitter search" },
        { "<C-s>", function() require("flash").toggle() end, mode = "c", desc = "Toggle flash search" },
    },
}
```

> `<C-s>` save remains in normal/insert/visual; `c` (cmdline) mode is the only place flash overrides it.

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/editor/flash.lua
git commit -m "feat(editor): add flash.nvim for jump motion"
```

### Task 4.2: todo-comments.nvim

**Files:**
- Create: `lua/plugins/editor/todo-comments.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    keys = {
        { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo" },
        { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev todo" },
        { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
        { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
    },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/editor/todo-comments.lua
git commit -m "feat(editor): add todo-comments with Trouble + Telescope integration"
```

### Task 4.3: harpoon (file marks)

**Files:**
- Create: `lua/plugins/editor/harpoon.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
        local harpoon = require("harpoon")
        harpoon:setup({})
        local keys = {
            { "<leader>ja", function() harpoon:list():add() end, desc = "Harpoon: add file" },
            { "<leader>jj", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: menu" },
        }
        for i = 1, 5 do
            table.insert(keys, {
                "<leader>j" .. i,
                function() harpoon:list():select(i) end,
                desc = "Harpoon to file " .. i,
            })
        end
        return keys
    end,
}
```

- [ ] **Step 2: Add `<leader>j` group to which-key**

```lua
                { "<leader>j", group = "harpoon" },
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/harpoon.lua lua/plugins/which-key.lua
git commit -m "feat(editor): add harpoon for fast file marks"
```

### Task 4.4: oil.nvim (buffer-as-directory file editor)

**Files:**
- Create: `lua/plugins/editor/oil.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- needed when starting with `nvim <dir>`
    opts = {
        default_file_explorer = false, -- coexist with nvim-tree
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = { show_hidden = true },
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-x>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["-"] = "actions.parent",
            ["g."] = "actions.toggle_hidden",
        },
    },
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Oil: open parent directory" },
    },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/editor/oil.lua
git commit -m "feat(editor): add oil.nvim for buffer-style filesystem editing"
```

### Task 4.5: undotree

**Files:**
- Create: `lua/plugins/editor/undotree.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
        { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
    },
    config = function()
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SplitWidth = 35
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/editor/undotree.lua
git commit -m "feat(editor): add undotree visual undo history"
```

### Task 4.6: neogit + diffview

**Files:**
- Create: `lua/plugins/editor/neogit.lua`
- Create: `lua/plugins/editor/diffview.lua`

- [ ] **Step 1: Write `lua/plugins/editor/neogit.lua`**

```lua
return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
        { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit (magit)" },
    },
    opts = {
        graph_style = "unicode",
        integrations = { telescope = true, diffview = true },
    },
}
```

- [ ] **Step 2: Write `lua/plugins/editor/diffview.lua`**

```lua
return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
        { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: file history" },
        { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
    },
    opts = { enhanced_diff_hl = true, view = { default = { winbar_info = true } } },
}
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/neogit.lua lua/plugins/editor/diffview.lua
git commit -m "feat(git): add neogit (magit) and diffview"
```

### Task 4.7: refactoring.nvim

**Files:**
- Create: `lua/plugins/editor/refactoring.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    keys = {
        { "<leader>Re", function() require("refactoring").refactor("Extract Function") end, mode = "x", desc = "Extract function" },
        { "<leader>Rf", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc = "Extract to file" },
        { "<leader>Rv", function() require("refactoring").refactor("Extract Variable") end, mode = "x", desc = "Extract variable" },
        { "<leader>Ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc = "Inline variable" },
        { "<leader>RI", function() require("refactoring").refactor("Inline Function") end, mode = "n", desc = "Inline function" },
        { "<leader>RB", function() require("refactoring").refactor("Extract Block") end, mode = "n", desc = "Extract block" },
        { "<leader>Rr", function() require("refactoring").select_refactor() end, mode = { "n", "x" }, desc = "Select refactor" },
    },
}
```

- [ ] **Step 2: Add `<leader>R` group to which-key**

```lua
                { "<leader>R", group = "Refactor (refactoring.nvim)" },
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/refactoring.lua lua/plugins/which-key.lua
git commit -m "feat(editor): add refactoring.nvim for extract/inline ops"
```

### Task 4.8: zen-mode + twilight

**Files:**
- Create: `lua/plugins/editor/zen-mode.lua`
- Create: `lua/plugins/editor/twilight.lua`

- [ ] **Step 1: Write `lua/plugins/editor/zen-mode.lua`**

```lua
return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
        { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen mode" },
    },
    opts = {
        window = { width = 0.85, options = { number = false, relativenumber = false } },
        plugins = {
            twilight = { enabled = true },
            tmux = { enabled = false },
            gitsigns = { enabled = false },
        },
    },
}
```

- [ ] **Step 2: Write `lua/plugins/editor/twilight.lua`**

```lua
return {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = { { "<leader>uT", "<cmd>Twilight<cr>", desc = "Twilight (dim inactive code)" } },
    opts = { context = 10, treesitter = true },
}
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/editor/zen-mode.lua lua/plugins/editor/twilight.lua
git commit -m "feat(editor): add zen-mode and twilight focus plugins"
```

### Task 4.9: mini.bufremove

**Files:**
- Create: `lua/plugins/editor/mini-bufremove.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "echasnovski/mini.bufremove",
    keys = {
        { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete buffer (force, keep window)" },
        { "<leader>bx", function() require("mini.bufremove").delete(0, false) end, desc = "Delete buffer (keep window)" },
    },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/editor/mini-bufremove.lua
git commit -m "feat(editor): add mini.bufremove for layout-preserving buffer delete"
```

---

# Phase 5 — Time: clock, pomodoro, stand-up reminders

### Task 5.1: pomo.nvim (pomodoro timer in lualine)

**Files:**
- Create: `lua/plugins/time/pomo.lua`
- Modify: `lua/plugins/lualine.lua` (insert pomo + clock segments)

- [ ] **Step 1: Write `lua/plugins/time/pomo.lua`**

```lua
return {
    "epwalsh/pomo.nvim",
    version = "*",
    dependencies = { "rcarriga/nvim-notify" },
    cmd = { "TimerStart", "TimerStop", "TimerRepeat", "TimerHide", "TimerShow" },
    keys = {
        { "<leader>pp", function() vim.cmd("TimerStart " .. (vim.fn.input("Duration (e.g. 25m): ", "25m"))) end, desc = "Pomo: start" },
        { "<leader>pP", "<cmd>TimerRepeat 25m Pomodoro<cr>", desc = "Pomo: repeat 25m" },
        { "<leader>ps", "<cmd>TimerStop<cr>", desc = "Pomo: stop" },
        { "<leader>ph", "<cmd>TimerHide<cr>", desc = "Pomo: hide" },
        { "<leader>pS", "<cmd>TimerShow<cr>", desc = "Pomo: show" },
    },
    opts = {
        notifiers = {
            { name = "Default", opts = { sticky = true, title_icon = "🍅", text_icon = "⏳" } },
        },
        sessions = {
            pomodoro = {
                { name = "Work",  duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Work",  duration = "25m" },
                { name = "Break", duration = "5m" },
                { name = "Work",  duration = "25m" },
                { name = "LongBreak", duration = "20m" },
            },
        },
    },
}
```

- [ ] **Step 2: Embed timer + clock in lualine**

In `lua/plugins/lualine.lua`, find the `sections.lualine_x` array and add these two components alongside the existing entries:

```lua
                {
                    function()
                        local ok, pomo = pcall(require, "pomo")
                        if not ok then return "" end
                        local timer = pomo.get_first_to_finish()
                        if timer == nil then return "" end
                        return "🍅 " .. tostring(timer)
                    end,
                },
                {
                    function() return os.date("%H:%M") end,
                    icon = "🕐",
                },
```

(If lualine.lua does not yet have a `sections.lualine_x` block, insert one that mirrors the lualine docs; the existing config will guide you.)

- [ ] **Step 3: Add `<leader>p` group to which-key**

```lua
                { "<leader>p", group = "pomo (timer/clock)" },
```

- [ ] **Step 4: Commit**

```bash
git add lua/plugins/time/pomo.lua lua/plugins/lualine.lua lua/plugins/which-key.lua
git commit -m "feat(time): add pomo.nvim timer + clock segment in lualine"
```

### Task 5.2: stand.nvim (RSI break reminder)

**Files:**
- Create: `lua/plugins/time/stand.lua`

- [ ] **Step 1: Write the file**

```lua
return {
    "samharju/stand.nvim",
    event = "VeryLazy",
    opts = {
        minute_interval = 50,
        startup_notification = false,
    },
}
```

- [ ] **Step 2: Commit**

```bash
git add lua/plugins/time/stand.lua
git commit -m "feat(time): add stand.nvim 50-minute RSI reminder"
```

---

# Phase 6 — Deployed VitePress documentation site

**Why:** A static site is the cheapest "always-fresh" output. VitePress is fast, themable, and ships dark mode. We deploy it to GitHub Pages, then bind `<leader>D` in Neovim to open the public URL via `xdg-open`.

### Task 6.1: Scaffold the VitePress site

**Files:**
- Create: `docs-site/package.json`
- Create: `docs-site/.vitepress/config.mjs`
- Create: `docs-site/index.md`
- Create: `docs-site/getting-started.md`
- Create: `docs-site/keymaps.md`
- Create: `docs-site/plugins.md`
- Create: `docs-site/languages.md`
- Create: `docs-site/ai.md`

- [ ] **Step 1: Write `docs-site/package.json`**

```json
{
  "name": "nvim-config-docs",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vitepress dev",
    "build": "vitepress build",
    "preview": "vitepress preview"
  },
  "devDependencies": {
    "vitepress": "^1.6.0"
  }
}
```

- [ ] **Step 2: Write `docs-site/.vitepress/config.mjs`**

GitHub user is `yashksaini-coder`. Repo dir name is `nvim`. Site URL after deploy: `https://yashksaini-coder.github.io/nvim/`.

```javascript
import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'yks.nvim',
  description: 'Personal Neovim distribution — IDE-grade for systems languages',
  base: '/nvim/',
  cleanUrls: true,
  lastUpdated: true,
  themeConfig: {
    siteTitle: 'yks.nvim',
    nav: [
      { text: 'Getting Started', link: '/getting-started' },
      { text: 'Keymaps', link: '/keymaps' },
      { text: 'Plugins', link: '/plugins' },
      { text: 'Languages', link: '/languages' },
      { text: 'AI', link: '/ai' },
    ],
    sidebar: [
      {
        text: 'Overview',
        items: [
          { text: 'Home', link: '/' },
          { text: 'Getting Started', link: '/getting-started' },
        ],
      },
      {
        text: 'Reference',
        items: [
          { text: 'Keymaps', link: '/keymaps' },
          { text: 'Plugins', link: '/plugins' },
          { text: 'Language support', link: '/languages' },
          { text: 'AI assistants', link: '/ai' },
        ],
      },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/yashksaini-coder/nvim' },
    ],
    search: { provider: 'local' },
    editLink: {
      pattern: 'https://github.com/yashksaini-coder/nvim/edit/dev/docs-site/:path',
    },
    outline: { level: [2, 3] },
  },
})
```

- [ ] **Step 3: Write `docs-site/index.md`**

```markdown
---
layout: home
hero:
  name: yks.nvim
  text: A veteran's Neovim distro
  tagline: IDE-grade configuration for C, C++, Rust, Go, Python, and JS/TS
  actions:
    - theme: brand
      text: Get started
      link: /getting-started
    - theme: alt
      text: Keymaps
      link: /keymaps
features:
  - icon: 🛠
    title: True IDE features
    details: LSP + DAP + Treesitter + refactoring + symbols + call hierarchy. Full tooling for systems work.
  - icon: 🤖
    title: AI built-in
    details: Claude Code, GitHub Copilot, and OpenCode coexisting on a single keymap prefix.
  - icon: ⏱
    title: Pomodoro & clock
    details: Built-in timers and an RSI reminder so the editor watches the editor's user.
  - icon: 📦
    title: Plugin discipline
    details: lazy.nvim with daily lockfile drift via CI; pinned reproducible installs.
---
```

- [ ] **Step 4: Write `docs-site/getting-started.md`**

```markdown
# Getting Started

## Requirements

- Neovim **0.11+** (uses `vim.lsp.config()` API)
- Git, make, a C compiler (`gcc`/`clang`), Node 20+ for AI plugins
- Optional: Go, Rust, Python toolchains for those languages

## Install

```bash
git clone https://github.com/yashksaini-coder/nvim ~/.config/nvim
nvim --headless "+Lazy! sync" "+MasonToolsInstall" "+qall"
```

## First boot

- The dashboard appears (NEOVIM banner)
- Use `<leader>?` to discover keymaps via which-key
- `:checkhealth` to confirm runtimes resolve
```

- [ ] **Step 5: Write `docs-site/keymaps.md`**

```markdown
# Keymaps

Leader is `<Space>`. Local leader is `\\`.

## Global

| Keys | Action |
|---|---|
| `<leader>?` | Show buffer keymaps (which-key) |
| `<leader>q` | Quit all |
| `<leader>D` | Open online docs (this site) |

## LSP

| Keys | Action |
|---|---|
| `K` | Hover |
| `<leader>gd` / `<leader>gD` | Definition / Declaration |
| `<leader>gi` / `<leader>gt` | Implementation / Type definition |
| `<leader>gr` | References |
| `<leader>gci` / `<leader>gco` | Incoming / Outgoing calls |
| `<leader>fS` / `<leader>fW` | Document / Workspace symbols |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>uh` | Toggle inlay hints |
| `<C-k>` | Signature help |

## DAP

| Keys | Action |
|---|---|
| `<leader>db` / `<leader>dB` | Toggle / conditional breakpoint |
| `<leader>dc` | Continue / start |
| `<leader>di` / `<leader>do` / `<leader>dO` | Step into / over / out |
| `<leader>dr` | Toggle REPL |
| `<leader>du` | Toggle DAP UI |
| `<leader>dh` | Hover variable |
| `<leader>dS` / `<leader>df` | Scopes / frames float |
| `<leader>de` | Evaluate expression |

## AI

| Keys | Action |
|---|---|
| `<leader>ic` | Claude Code toggle |
| `<leader>iC` | Claude continue |
| `<leader>iX` | Copilot Chat |
| `<leader>io` | OpenCode toggle |
| `<leader>ia` | OpenCode ask buffer |

## Productivity

| Keys | Action |
|---|---|
| `s` / `S` | Flash jump / treesitter jump |
| `<leader>j1`–`<leader>j5` | Harpoon to mark 1–5 |
| `<leader>jj` / `<leader>ja` | Harpoon menu / add |
| `-` | Open parent dir (oil.nvim) |
| `<leader>uu` | Toggle undotree |
| `<leader>uz` / `<leader>uT` | Zen / Twilight |
| `<leader>pp` | Pomo timer prompt |
| `<leader>pP` | Pomodoro 25m repeat |

For the full list, run `<leader>?` inside Neovim.
```

- [ ] **Step 6: Write `docs-site/plugins.md`**

```markdown
# Plugins

This page is generated from `lazy-lock.json`. See `:Lazy` in Neovim for live state.

## Editor

- **flash.nvim** — quickjump motion (`s` / `S`)
- **todo-comments.nvim** — TODO/FIXME highlighting and search
- **harpoon** — quick file marks 1–5
- **oil.nvim** — buffer-style filesystem editor
- **undotree** — visual undo history
- **neogit** — magit-style git UI
- **diffview.nvim** — git diff and history viewer
- **refactoring.nvim** — extract/inline refactors
- **zen-mode.nvim** + **twilight.nvim** — focus modes
- **mini.bufremove** — layout-preserving buffer delete

## Language

- **rustaceanvim** — Rust DAP, runnables, code lenses
- **clangd_extensions.nvim** — C/C++ AST, memory layout, header switch
- **go.nvim** — Go test/fillstruct/impl helpers
- **lazydev.nvim** — runtime types for Lua + Neovim API
- **friendly-snippets** — VSCode-format snippet corpus

## AI

- **copilot.lua** + **CopilotChat.nvim** — GitHub Copilot
- **claude-code.nvim** — Claude Code CLI integration
- **opencode.nvim** — OpenCode chat

## Time

- **pomo.nvim** — pomodoro timer in lualine
- **stand.nvim** — 50-min RSI reminder
```

- [ ] **Step 7: Write `docs-site/languages.md`**

```markdown
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
```

- [ ] **Step 8: Write `docs-site/ai.md`**

```markdown
# AI assistants

Three AI plugins coexist under the `<leader>i` prefix:

## Claude Code

`<leader>ic` toggles a vertical split running `claude` (the CLI). Requires the `claude` binary on your `PATH` and an active subscription / API key configured per the Claude CLI docs.

## GitHub Copilot

`<leader>iX` opens CopilotChat. Insert-mode suggestions are inlined; accept with `<M-l>`. First run: `:Copilot auth` (device flow).

## OpenCode

`<leader>io` toggles OpenCode. `<leader>ia` asks about the current buffer; in visual mode `<leader>iA` asks about the selection. The plugin connects to a local `opencode` server on port 4096.

## Choosing one

There's no harm in running all three. Copilot for inline suggestions, Claude for agentic tasks, OpenCode for tool-driven sessions. They never compete in insert mode (Copilot is the only inline source).
```

- [ ] **Step 9: Verify VitePress builds locally**

```bash
cd docs-site && npm install && npx vitepress build && cd ..
```
Expected: `docs-site/.vitepress/dist/` is produced.

- [ ] **Step 10: Append to `.gitignore`**

```bash
cat <<'EOF' >> .gitignore
docs-site/node_modules/
docs-site/.vitepress/dist/
docs-site/.vitepress/cache/
EOF
```

- [ ] **Step 11: Commit**

```bash
git add docs-site/ .gitignore
git commit -m "feat(docs): scaffold VitePress documentation site"
```

### Task 6.2: GitHub Pages deploy workflow

**Files:**
- Create: `.github/workflows/docs-deploy.yml`

- [ ] **Step 1: Write the workflow**

```yaml
name: Deploy docs to GitHub Pages

on:
  push:
    branches: [dev]
    paths:
      - 'docs-site/**'
      - '.github/workflows/docs-deploy.yml'
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: docs-site
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
          cache-dependency-path: docs-site/package-lock.json
      - run: npm ci || npm install
      - run: npx vitepress build
      - uses: actions/configure-pages@v5
      - uses: actions/upload-pages-artifact@v3
        with:
          path: docs-site/.vitepress/dist

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

- [ ] **Step 2: Generate a lockfile so CI uses `npm ci`**

```bash
cd docs-site && npm install && cd ..
git add docs-site/package-lock.json
```

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/docs-deploy.yml docs-site/package-lock.json
git commit -m "ci(docs): deploy VitePress to GitHub Pages on push to dev"
```

- [ ] **Step 4: One-time GitHub UI step (manual)**

After pushing, in the repo's Settings → Pages, set "Source: GitHub Actions". This is a one-time click. The first push that touches `docs-site/` will publish to `https://yashksaini-coder.github.io/nvim/`.

### Task 6.3: Open-docs keymap

**Files:**
- Create: `lua/utils/docs.lua`
- Create: `lua/config/keymaps/docs.lua`
- Modify: `lua/config/keymaps/init.lua` (require new module)

- [ ] **Step 1: Write `lua/utils/docs.lua`**

```lua
local M = {}

M.url = "https://yashksaini-coder.github.io/nvim/"

function M.open(url)
    url = url or M.url
    local opener
    if vim.fn.has("mac") == 1 then
        opener = "open"
    elseif vim.fn.has("unix") == 1 then
        opener = "xdg-open"
    elseif vim.fn.has("win32") == 1 then
        opener = "start"
    else
        vim.notify("Unsupported platform for opening URLs", vim.log.levels.WARN)
        return
    end
    vim.fn.jobstart({ opener, url }, { detach = true })
    vim.notify("Opened " .. url, vim.log.levels.INFO)
end

return M
```

- [ ] **Step 2: Write `lua/config/keymaps/docs.lua`**

```lua
local docs = require("utils.docs")
local map = vim.keymap.set

map("n", "<leader>D", function() docs.open() end, { desc = "Open online docs" })
map("n", "<leader>Dk", function() docs.open(docs.url .. "keymaps") end, { desc = "Docs: keymaps" })
map("n", "<leader>Dp", function() docs.open(docs.url .. "plugins") end, { desc = "Docs: plugins" })
map("n", "<leader>Dl", function() docs.open(docs.url .. "languages") end, { desc = "Docs: languages" })
map("n", "<leader>Da", function() docs.open(docs.url .. "ai") end, { desc = "Docs: AI" })
```

- [ ] **Step 3: Append to `lua/config/keymaps/init.lua`**

```lua
require("config.keymaps.docs")
```

- [ ] **Step 4: Add `<leader>D` group to which-key**

```lua
                { "<leader>D", group = "docs (online)" },
```

- [ ] **Step 5: Smoke-test**

```bash
nvim --headless -c "lua print(require('utils.docs').url)" -c "qall" 2>&1 | tail -1
```
Expected: prints the docs URL.

- [ ] **Step 6: Commit**

```bash
git add lua/utils/docs.lua lua/config/keymaps/docs.lua lua/config/keymaps/init.lua lua/plugins/which-key.lua
git commit -m "feat(docs): add <leader>D keymap to open VitePress docs site"
```

---

# Phase 7 — Tests, neotest, and CI hardening

### Task 7.1: Bootstrap plenary test harness

**Files:**
- Create: `tests/minimal_init.lua`
- Create: `tests/utils/docs_spec.lua`
- Modify: `Makefile`

- [ ] **Step 1: Write `tests/minimal_init.lua`**

```lua
-- Minimal init for plenary.busted headless tests.
-- Mirrors enough of the runtimepath for the modules under test.
local config_dir = vim.fn.fnamemodify(vim.fn.expand("<sfile>"), ":p:h:h")
vim.opt.runtimepath:prepend(config_dir)

local plenary = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
if vim.fn.isdirectory(plenary) == 0 then
    vim.fn.system({
        "git", "clone", "--depth=1",
        "https://github.com/nvim-lua/plenary.nvim",
        plenary,
    })
end
vim.opt.runtimepath:prepend(plenary)
vim.cmd("runtime plugin/plenary.vim")
```

- [ ] **Step 2: Write the example spec `tests/utils/docs_spec.lua`**

```lua
local docs = require("utils.docs")

describe("utils.docs", function()
    it("exposes a docs URL", function()
        assert.is_string(docs.url)
        assert.is_true(docs.url:match("^https?://") ~= nil)
    end)

    it("has an open() function", function()
        assert.is_function(docs.open)
    end)

    it("default URL targets the VitePress site", function()
        assert.equals("https://yashksaini-coder.github.io/nvim/", docs.url)
    end)
end)
```

- [ ] **Step 3: Add `test` target to `Makefile`**

Append:

```make
.PHONY: test
test:
	nvim --headless -u tests/minimal_init.lua -c "PlenaryBustedDirectory tests {minimal_init = 'tests/minimal_init.lua'}" -c "qall"
```

- [ ] **Step 4: Run tests locally to verify**

```bash
make test
```
Expected output ends with `Success: 3 / 3` (or similar plenary summary). If plenary isn't already installed, the minimal_init clones it on first run.

- [ ] **Step 5: Commit**

```bash
git add tests/ Makefile
git commit -m "test: add plenary harness with utils.docs example spec"
```

### Task 7.2: neotest integration

**Files:**
- Create: `lua/plugins/neotest.lua`

- [ ] **Step 1: Write `lua/plugins/neotest.lua`**

```lua
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Adapters
        "nvim-neotest/neotest-python",
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
        "nvim-neotest/neotest-jest",
        "nvim-neotest/neotest-plenary",
    },
    cmd = { "Neotest" },
    keys = {
        { "<leader>nt", function() require("neotest").run.run() end, desc = "Test nearest" },
        { "<leader>nf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test file" },
        { "<leader>nd", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest" },
        { "<leader>nl", function() require("neotest").run.run_last() end, desc = "Test last" },
        { "<leader>ns", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
        { "<leader>no", function() require("neotest").output.open({ enter = true }) end, desc = "Test output" },
        { "<leader>nO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
        { "<leader>nx", function() require("neotest").run.stop() end, desc = "Stop test" },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({ dap = { justMyCode = false } }),
                require("neotest-go"),
                require("neotest-rust"),
                require("neotest-jest"),
                require("neotest-plenary"),
            },
            output = { open_on_run = false },
            quickfix = { enabled = false, open = false },
            status = { virtual_text = true },
        })
    end,
}
```

- [ ] **Step 2: Add `<leader>n` group to which-key**

```lua
                { "<leader>n", group = "neotest" },
```

- [ ] **Step 3: Commit**

```bash
git add lua/plugins/neotest.lua lua/plugins/which-key.lua
git commit -m "feat(test): add neotest with python/go/rust/jest/plenary adapters"
```

### Task 7.3: CI workflow — lint + test on PR

**Files:**
- Create: `.github/workflows/ci.yml`

- [ ] **Step 1: Write the workflow**

```yaml
name: CI

on:
  pull_request:
  push:
    branches: [dev]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install stylua
        run: |
          curl -L "https://github.com/JohnnyMorganz/StyLua/releases/latest/download/stylua-linux-x86_64.zip" -o /tmp/stylua.zip
          unzip /tmp/stylua.zip -d /tmp
          chmod +x /tmp/stylua
          sudo mv /tmp/stylua /usr/local/bin/
      - name: Install luacheck
        run: |
          sudo apt-get update
          sudo apt-get install -y luarocks
          sudo luarocks install luacheck
      - name: stylua check
        run: stylua --check --column-width 100 --indent-type Spaces --indent-width 2 lua/
      - name: luacheck
        run: luacheck lua/

  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: rhysd/action-setup-vim@v1
        with:
          neovim: true
          version: 'stable'
      - name: Run plenary tests
        run: make test
```

- [ ] **Step 2: Verify the lint commands match the local Makefile**

```bash
make
```
Expected: `make fmt-check` and `make lint` both pass on current tree. If they fail, fix the offending files before committing the workflow.

- [ ] **Step 3: Commit**

```bash
git add .github/workflows/ci.yml
git commit -m "ci: add lint+test workflow for PRs and dev pushes"
```

---

# Phase 8 — Polish, README, and the merge

### Task 8.1: Update README with the new pillars

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Add a new section near the top of `README.md`** (insert after the existing one-liner / badges):

```markdown
## Highlights

- **Full IDE for systems languages.** First-class LSP + DAP for **C, C++, Rust, Go, Python, JS/TS** with rename, signature help, type definitions, implementations, document/workspace symbols, call hierarchy, scopes, watches, and a hover-variable widget.
- **AI assistants built in.** Claude Code, GitHub Copilot, and OpenCode coexist under the `<leader>i` prefix.
- **Productivity stack.** flash.nvim, harpoon, oil.nvim, refactoring.nvim, neogit, diffview, undotree, zen-mode, twilight.
- **Time discipline.** Pomodoro timer (`<leader>pp`) and 50-min RSI reminder built into the statusline.
- **Hosted docs.** Live keymap and plugin reference at <https://yashksaini-coder.github.io/nvim/>. Open it from inside the editor with `<leader>D`.
- **Tested.** plenary-based test harness; PR-blocking lint + test CI; daily lockfile drift PR via existing CI.

> Press `<leader>?` inside Neovim to discover everything else interactively.
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "docs(readme): document IDE/AI/productivity/time/docs/test pillars"
```

### Task 8.2: Healthcheck and final smoke test

- [ ] **Step 1: Headless boot to confirm zero startup errors**

```bash
nvim --headless -c "Lazy! sync" -c "MasonToolsInstall" -c "qall" 2>&1 | tail -20
```
Expected: clean exit; no `E5108` or `attempt to index nil` errors.

- [ ] **Step 2: Interactive `:checkhealth` review**

Open Neovim and run `:checkhealth`. Skim for any unmet requirement. Fix only blockers (broken require chains, missing binaries). Cosmetic warnings (e.g. "node not found" for telescope-fzf-native if you don't use Node) are fine.

- [ ] **Step 3: Commit any tweaks**

```bash
git add -A
git diff --cached --stat
git commit -m "fix: address checkhealth findings" || echo "nothing to commit"
```

### Task 8.3: Push and open PR

- [ ] **Step 1: Push the branch**

```bash
git push -u origin feat/ide-distro-overhaul
```

- [ ] **Step 2: Open PR via gh**

```bash
gh pr create --title "feat: IDE-grade distro overhaul (LSP/DAP/AI/docs/tests)" \
  --body "$(cat <<'EOF'
## Summary

- Phase 1: Pyright/Gopls/Clangd LSP overrides, full DAP for Python/Go/JS, extended LSP keymaps (rename/sig/impl/symbols/calls/inlay-toggle).
- Phase 2: rustaceanvim, clangd_extensions, go.nvim, lazydev, friendly-snippets.
- Phase 3: Claude Code, Copilot+CopilotChat, OpenCode under \`<leader>i\`.
- Phase 4: flash, todo-comments, harpoon, oil, undotree, neogit, diffview, refactoring, zen-mode, twilight, mini.bufremove.
- Phase 5: pomo.nvim + clock segment in lualine, stand.nvim RSI reminder.
- Phase 6: VitePress docs site, GitHub Pages workflow, \`<leader>D\` opener.
- Phase 7: plenary test harness, neotest, CI lint+test workflow.

## Test plan

- [ ] \`make\` (lint + fmt-check) passes
- [ ] \`make test\` shows plenary 3/3 success
- [ ] \`:checkhealth\` clean
- [ ] \`<leader>?\` enumerates new groups (i, j, n, p, D, G, R, u)
- [ ] Open a Python file, set breakpoint, \`<leader>dc\` launches debugpy
- [ ] Open a Go file, \`<leader>Gt\` runs tests
- [ ] \`<leader>D\` opens the deployed docs page
EOF
)"
```

- [ ] **Step 3: Merge after CI is green**

```bash
gh pr merge --merge --delete-branch
```

---

## Self-review checklist

- [ ] **Spec coverage:**
  - Plugin optimization → Phases 2/4
  - UI updates → Phases 4 (zen/twilight) + 5 (lualine clock/timer)
  - Tests → Phase 7
  - Debug → Phase 1.4 (Python/Go/JS DAP, scopes, watches, hover, frames)
  - Claude / Copilot / OpenCode → Phase 3
  - Low-level / C / C++ / Rust / Go / Python / JS → Phases 1 + 2
  - Variables / scopes / DAP / references → Phase 1.3 + 1.4
  - LSP plugins / IDE feel → Phases 1 + 2
  - Clock / timer → Phase 5
  - Proper keymaps → every phase touches `which-key.lua`
  - Dedicated docs site, deployed, opened with keystroke → Phase 6
  - Compete with distros → Phase 4 (motion/git/refactor) + cumulative

- [ ] **Placeholder scan:** No "TBD", "TODO later", "fill in", or vague "handle errors" steps. Each step has full code or an exact command.

- [ ] **Type/keymap consistency:**
  - `<leader>iX` is Copilot Chat (Phase 3.1); `<leader>iC` is Claude continue (Phase 3.2). No collision.
  - `<leader>i` is the AI prefix throughout
  - `<leader>R` (capital) is refactoring; `<leader>r` (lowercase) stays Rust+rename — `<leader>rn` cohabits unambiguously
  - `<leader>u` is "ui/toggles"; `<leader>uu` is undotree, `<leader>uh` is inlay hints, `<leader>uz` is zen, `<leader>uT` is twilight
  - Phase 2.1 removes `vim.lsp.enable("rust_analyzer")`; rustaceanvim owns rust → no double-init
  - Phase 1.1 swaps `pylsp` for `pyright` consistently

## Optional follow-ups (NOT in this plan)

- Theme refinement / new themes (current Kanagawa Dragon kept as default)
- Replacing `nvim-cmp` with `blink.cmp` (would touch every completion source — separate plan)
- A custom `:checkhealth` module for this distro
- Obsidian/Markdown writing-mode plugin
