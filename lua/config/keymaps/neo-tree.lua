-- Toggle the file explorer
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })

-- Focus the file explorer (opens if closed, moves cursor to it)
vim.keymap.set("n", "<leader>eo", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })

-- Reveal the current file in the explorer
vim.keymap.set("n", "<leader>er", "<cmd>Neotree reveal<cr>", { desc = "Reveal File in Explorer" })

-- Show the filesystem (default view)
vim.keymap.set("n", "<leader>ef", "<cmd>Neotree filesystem reveal left<cr>", { desc = "Filesystem Explorer" })

-- Show the buffers list
vim.keymap.set("n", "<leader>eb", "<cmd>Neotree buffers reveal float<cr>", { desc = "Buffer Explorer" })

-- Show the git status
vim.keymap.set("n", "<leader>eg", "<cmd>Neotree git_status reveal float<cr>", { desc = "Git Status Explorer" })

-- Create a new file relative to the current Neo-tree directory (or project root if not in Neo-tree)
vim.keymap.set("n", "<leader>en", function()
  local project_root = vim.fn.getcwd()
  local base_dir = project_root

  -- Try to get the directory from Neo-tree's current node
  local ok, state = pcall(function()
    return require("neo-tree.sources.manager").get_state("filesystem")
  end)

  if ok and state and state.tree then
    local node = state.tree:get_node()
    if node then
      if node.type == "directory" then
        base_dir = node.path
      elseif node.type == "file" then
        base_dir = vim.fn.fnamemodify(node.path, ":h")
      end
    end
  end

  -- Show path relative to project root (hide full system path)
  local display_path = base_dir
  if base_dir:find(project_root, 1, true) == 1 then
    display_path = "." .. base_dir:sub(#project_root + 1)
    if display_path == "." then
      display_path = "./"
    end
  end

  -- Two-line prompt: show directory first, then input on next line
  local prompt = string.format("Create file in: %s\nFilename: ", display_path)
  local name = vim.fn.input(prompt)
  if name == nil or name == "" then
    return
  end

  local full_path = base_dir .. "/" .. name

  -- Create parent directories if they don't exist
  local parent = vim.fn.fnamemodify(full_path, ":h")
  vim.fn.mkdir(parent, "p")

  vim.cmd("edit " .. vim.fn.fnameescape(full_path))
end, { desc = "Create new file in Neo-tree directory" })
