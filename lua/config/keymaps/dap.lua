local map = vim.keymap.set

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue / Start" })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step into" })

map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Step over" })

map("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "Step out" })

map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "Toggle REPL" })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Run last" })

map("n", "<leader>du", function()
  require("dapui").toggle()
end, { desc = "Toggle DAP UI" })

map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Terminate" })

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
