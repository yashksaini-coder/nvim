	return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Setup codelldb adapter for C/C++ debugging
			local mason_registry = require("mason-registry")
			local ok, codelldb = pcall(function()
				return mason_registry.get_package("codelldb"):get_install_path()
			end)

			if ok then
				local codelldb_path = codelldb .. "/extension/adapter/codelldb"
				dap.adapters.codelldb = {
					type = "server",
					port = "${port}",
					host = "127.0.0.1",
					executable = {
						command = codelldb_path,
						args = { "--port", "${port}" },
					},
				}
			end

			dapui.setup({
				controls = {
					element = "repl",
					enabled = true,
					icons = {
						disconnect = "",
						pause = "⏸",
						play = "▶",
						run_last = "↻",
						step_back = "⏮",
						step_into = "⏩",
						step_out = "⏫",
						step_over = "⏭",
						terminate = "⏹",
					},
				},
				element_mappings = {},
				expand_lines = true,
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				force_buffers = true,
				icons = {
					collapsed = "▶",
					current_frame = "▶",
					expanded = "▼",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.50 },
							{ id = "breakpoints", size = 0.20 },
							{ id = "stacks", size = 0.15 },
							{ id = "watches", size = 0.15 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{ id = "repl", size = 0.50 },
							{ id = "console", size = 0.50 },
						},
						position = "bottom",
						size = 10,
					},
				},
				mappings = {
					edit = "e",
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					repl = "r",
					toggle = "t",
				},
				render = {
					indent = 1,
					max_value_lines = 100,
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.fn.sign_define("DapBreakpoint", {
				text = "🔴",
				texthl = "DiagnosticError",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🟡",
				texthl = "DiagnosticWarn",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "⚫",
				texthl = "DiagnosticHint",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapStopped", {
				text = "▶️",
				texthl = "DiagnosticInfo",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapLogPoint", {
				text = "📝",
				texthl = "DiagnosticInfo",
				linehl = "",
				numhl = "",
			})

			dap.configurations.rust = {
				{
					name = "Debug Rust",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = false,
					env = {},
				},
				{
					name = "Debug Rust with arguments",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						local args_str = vim.fn.input("Arguments: ")
						return vim.fn.split(args_str, " ")
					end,
					runInTerminal = false,
				},
			}

			-- C/C++ debug configurations
			dap.configurations.cpp = {
				{
					name = "Debug C/C++ (Auto)",
					type = "codelldb",
					request = "launch",
					program = function()
						local filename = vim.fn.expand("%:t:r")
						local executable = vim.fn.getcwd() .. "/" .. filename
						-- Check if executable exists, if not, try with .out extension
						if vim.fn.filereadable(executable) == 0 then
							executable = executable .. ".out"
						end
						-- If still not found, compile it
						if vim.fn.filereadable(executable) == 0 then
							local source_file = vim.fn.expand("%")
							local compile_cmd = string.format("gcc -g -o %s %s", executable, source_file)
							vim.notify("Compiling with: " .. compile_cmd, vim.log.levels.INFO)
							vim.fn.system(compile_cmd)
						end
						return executable
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = false,
					env = {},
				},
				{
					name = "Debug C++ (Manual)",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
					runInTerminal = false,
					env = {},
				},
				{
					name = "Debug C++ with args",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = function()
						local args_str = vim.fn.input("Arguments: ")
						return vim.fn.split(args_str, " ")
					end,
					runInTerminal = false,
				},
			}

			dap.configurations.c = dap.configurations.cpp
		end,
	},
}
