local dap = require("dap")

vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP: Set Breakpoint with Condition" })

vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP: Run Last" })
vim.keymap.set("n", "<leader>du", require("dapui").toggle, { desc = "DAP: Toggle UI" })

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "DAP: Step Out" })

vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP: Terminate" })
vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "DAP: Pause" })
