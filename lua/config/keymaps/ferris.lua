local opts = { noremap = true, silent = true }

local function make_opts(desc)
	return vim.tbl_extend("force", opts, { desc = desc })
end

-- Expand Macro - Expands the macro under the cursor
vim.keymap.set("n", "<leader>rm", "<cmd>FerrisExpandMacro<cr>", make_opts("Expand Macro"))

-- Join Lines - Join lines in selection or current cursor position
vim.keymap.set("n", "<leader>rj", "<cmd>FerrisJoinLines<cr>", make_opts("Join Lines"))
vim.keymap.set("v", "<leader>rj", "<cmd>FerrisJoinLines<cr>", make_opts("Join Lines"))

-- View HIR - Shows the HIR of the function in the cursor position
vim.keymap.set("n", "<leader>rh", "<cmd>FerrisViewHIR<cr>", make_opts("View HIR"))

-- View MIR - Shows the MIR of the function in the cursor position
vim.keymap.set("n", "<leader>rl", "<cmd>FerrisViewMIR<cr>", make_opts("View MIR"))

-- View Memory Layout - Shows the memory layout of a struct/enum
vim.keymap.set("n", "<leader>rs", "<cmd>FerrisViewMemoryLayout<cr>", make_opts("View Memory Layout"))

-- View Syntax Tree - Shows the syntax tree of the selection or code in cursor position
vim.keymap.set("n", "<leader>rt", "<cmd>FerrisViewSyntaxTree<cr>", make_opts("View Syntax Tree"))
vim.keymap.set("v", "<leader>rt", "<cmd>FerrisViewSyntaxTree<cr>", make_opts("View Syntax Tree"))

-- View Item Tree - Shows the item tree of the current document
vim.keymap.set("n", "<leader>ri", "<cmd>FerrisViewItemTree<cr>", make_opts("View Item Tree"))

-- Open Cargo.toml - Opens the Cargo.toml file of a project
vim.keymap.set("n", "<leader>rc", "<cmd>FerrisOpenCargoToml<cr>", make_opts("Open Cargo.toml"))

-- Open Parent Module - Opens the parent module of the current module
vim.keymap.set("n", "<leader>rp", "<cmd>FerrisOpenParentModule<cr>", make_opts("Open Parent Module"))

-- Open Documentation - Opens the documentation for the symbol under cursor
vim.keymap.set("n", "<leader>rd", "<cmd>FerrisOpenDocumentation<cr>", make_opts("Open Documentation"))

-- Reload Workspace - Reloads the workspace of a project
vim.keymap.set("n", "<leader>rw", "<cmd>FerrisReloadWorkspace<cr>", make_opts("Reload Workspace"))

-- Rebuild Macros - Rebuilds procedural macros in a project
vim.keymap.set("n", "<leader>rb", "<cmd>FerrisRebuildMacros<cr>", make_opts("Rebuild Macros"))
