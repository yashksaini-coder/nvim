-- Compiler: native :make + quickfix (C/C++). F5–F8 and <leader>mb/mr/mT/mx.
-- Auto-detect and set makeprg for C/C++ files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    local file = vim.fn.expand("%:p")
    local filename = vim.fn.expand("%:t:r") -- Get filename without extension
    local output_dir = vim.fn.getcwd() .. "/bin"
    local output = output_dir .. "/" .. filename

    -- Create bin directory if it doesn't exist
    vim.fn.mkdir(output_dir, "p")

    -- Set compiler based on filetype
    if vim.bo.filetype == "cpp" then
      vim.bo.makeprg = string.format('g++ -Wall -g "%s" -o "%s"', file, output)
    else -- c
      vim.bo.makeprg = string.format('gcc -Wall -g "%s" -o "%s"', file, output)
    end

    -- Set error format for gcc/g++
    vim.bo.errorformat = "%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%f:%l:%c: %tote: %m"
  end,
})

-- Build current C/C++ file
vim.keymap.set("n", "<F5>", function()
  -- Save file first
  vim.cmd("write")
  -- Run make (compile)
  vim.cmd("make")
  -- Open quickfix if there are errors
  vim.cmd("cwindow")
end, { desc = "Build C/C++ Program" })

-- Build and run
vim.keymap.set("n", "<F6>", function()
  -- Save and compile
  vim.cmd("write")
  vim.cmd("make")

  -- Check if compilation was successful
  if vim.fn.empty(vim.fn.getqflist()) == 1 or vim.fn.getqflist({ winid = 0 }).winid == 0 then
    local filename = vim.fn.expand("%:t:r")
    local output = vim.fn.getcwd() .. "/bin/" .. filename
    -- Run in a terminal split
    vim.cmd("vsplit | terminal " .. output)
    vim.cmd("startinsert")
  else
    -- Show errors
    vim.cmd("cwindow")
    vim.notify("Build failed! Fix errors first.", vim.log.levels.ERROR)
  end
end, { desc = "Build & Run C/C++ Program" })

-- Toggle quickfix window (compilation results)
vim.keymap.set("n", "<F7>", function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  if qf_winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle Compilation Results" })

-- Run last compiled program
vim.keymap.set("n", "<F8>", function()
  local filename = vim.fn.expand("%:t:r")
  local output = vim.fn.getcwd() .. "/bin/" .. filename
  if vim.fn.filereadable(output) == 1 then
    vim.cmd("vsplit | terminal " .. output)
    vim.cmd("startinsert")
  else
    vim.notify("Program not found. Build first (F5).", vim.log.levels.WARN)
  end
end, { desc = "Run Program" })

-- Leader alternatives (avoid <leader>c* conflict with crates/leetcode)
vim.keymap.set("n", "<leader>mb", "<F5>", { desc = "Build Program" })
vim.keymap.set("n", "<leader>mr", "<F6>", { desc = "Build & Run" })
vim.keymap.set("n", "<leader>mT", "<F7>", { desc = "Toggle Results" })
vim.keymap.set("n", "<leader>mx", "<F8>", { desc = "Run Program" })
