local opts = { noremap = true, silent = true }

local function make_opts(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

local function make_crates_handler(fn_name)
  return function()
    local crates = require("crates")
    return crates[fn_name]()
  end
end

-- Toggle virtual text and diagnostics
vim.keymap.set("n", "<leader>ct", make_crates_handler("toggle"), make_opts("Toggle crates info"))

-- Reload the crates data
vim.keymap.set("n", "<leader>cr", make_crates_handler("reload"), make_opts("Reload crates"))

-- Show versions popup
vim.keymap.set("n", "<leader>cv", make_crates_handler("show_versions_popup"), make_opts("Show versions"))

-- Show features popup
vim.keymap.set("n", "<leader>cf", make_crates_handler("show_features_popup"), make_opts("Show features"))

-- Show dependencies popup
vim.keymap.set("n", "<leader>cd", make_crates_handler("show_dependencies_popup"), make_opts("Show dependencies"))

-- Update crate on current line
vim.keymap.set("n", "<leader>cu", make_crates_handler("update_crate"), make_opts("Update crate"))

-- Update crates on selected lines
vim.keymap.set("v", "<leader>cu", make_crates_handler("update_crates"), make_opts("Update crates"))

-- Update all crates in the buffer
vim.keymap.set("n", "<leader>ca", make_crates_handler("update_all_crates"), make_opts("Update all crates"))

-- Upgrade crate on current line
vim.keymap.set("n", "<leader>cU", make_crates_handler("upgrade_crate"), make_opts("Upgrade crate"))

-- Upgrade crates on selected lines
vim.keymap.set("v", "<leader>cU", make_crates_handler("upgrade_crates"), make_opts("Upgrade crates"))

-- Upgrade all crates in the buffer
vim.keymap.set("n", "<leader>cA", make_crates_handler("upgrade_all_crates"), make_opts("Upgrade all crates"))

-- Expand plain crate to inline table
vim.keymap.set("n", "<leader>cx", make_crates_handler("expand_plain_crate_to_inline_table"), make_opts("Expand crate to inline table"))

-- Extract crate into table
vim.keymap.set("n", "<leader>cX", make_crates_handler("extract_crate_into_table"), make_opts("Extract crate to table"))

-- Open crate's homepage
vim.keymap.set("n", "<leader>cH", make_crates_handler("open_homepage"), make_opts("Open homepage"))

-- Open crate's repository
vim.keymap.set("n", "<leader>cR", make_crates_handler("open_repository"), make_opts("Open repository"))

-- Open crate's documentation
vim.keymap.set("n", "<leader>cD", make_crates_handler("open_documentation"), make_opts("Open documentation"))

-- Open crate's crates.io page
vim.keymap.set("n", "<leader>cC", make_crates_handler("open_crates_io"), make_opts("Open crates.io"))

-- Open crate's lib.rs page
vim.keymap.set("n", "<leader>cL", make_crates_handler("open_lib_rs"), make_opts("Open lib.rs"))
