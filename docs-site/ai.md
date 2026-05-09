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
