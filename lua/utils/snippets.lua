-- Insert-at-cursor snippets only. Snippet files live in utils/snippets/.
local snippets_dir = vim.fn.stdpath("config") .. "/lua/utils/snippets"

local function read_snippet(filename, fallback)
  local path = snippets_dir .. "/" .. filename
  local f = io.open(path, "r")
  local content = fallback or ""
  if f then
    content = f:read("*a")
    f:close()
  end
  return content
end

local function insert_at_cursor(filename, fallback)
  local content = read_snippet(filename, fallback)
  vim.api.nvim_put(vim.split(content, "\n"), "c", true, true)
end

-- Insert snippet by filetype (map: ft -> filename)
local function insert_by_ft(ft_files, fallback)
  local ft = vim.bo.filetype
  local filename = ft_files[ft] or ft_files.c or ft_files.cpp
  if not filename then
    vim.notify("Loop snippet: no template for filetype '" .. ft .. "'", vim.log.levels.WARN)
    return
  end
  insert_at_cursor(filename, fallback)
end

-- Commands
vim.api.nvim_create_user_command("Sieve", function()
  insert_at_cursor("primes.cpp", "// sieve / SPF")
end, { desc = "Insert sieve / SPF snippet" })

vim.api.nvim_create_user_command("PBDS", function()
  insert_at_cursor("pbds.cpp", "// policy-based data structures")
end, { desc = "Insert PBDS snippet" })

vim.api.nvim_create_user_command("Pow", function()
  insert_at_cursor("pow.cpp", "// pow")
end, { desc = "Insert pow (exponent) snippet" })

-- Keymaps
vim.keymap.set("n", "<leader>pov", function()
  insert_at_cursor("print_vector.cpp", "// print vector")
end, { desc = "Snippet: print vector" })

vim.keymap.set("n", "<leader>mod", function()
  insert_at_cursor("mod_inverse.cpp", "// mod inverse")
end, { desc = "Snippet: mod inverse" })

vim.keymap.set("n", "<leader>dio", function()
  insert_at_cursor("diophantine.cpp", "// diophantine")
end, { desc = "Snippet: diophantine" })

-- Loop snippets (filetype-aware: C, C++, Rust)
vim.keymap.set("n", "<leader>sfor", function()
  insert_by_ft({ c = "for_loop.c", cpp = "for_loop.cpp", rust = "for_loop.rs" }, "// for loop")
end, { desc = "Snippet: for loop (C/C++/Rust)" })

vim.keymap.set("n", "<leader>swh", function()
  insert_by_ft(
    { c = "while_loop.c", cpp = "while_loop.cpp", rust = "while_loop.rs" },
    "// while loop"
  )
end, { desc = "Snippet: while loop (C/C++/Rust)" })

vim.keymap.set("n", "<leader>sdo", function()
  insert_by_ft({ c = "do_while.c", cpp = "do_while.cpp" }, "// do-while")
end, { desc = "Snippet: do-while (C/C++)" })

vim.keymap.set("n", "<leader>srange", function()
  local ft = vim.bo.filetype
  if ft == "cpp" then
    insert_at_cursor("range_for.cpp", "// range-based for")
  elseif ft == "rust" then
    insert_at_cursor("for_in.rs", "// for-in iterator")
  else
    vim.notify("Snippet: range/for-in only for C++ or Rust", vim.log.levels.WARN)
  end
end, { desc = "Snippet: range-based for (C++) / for-in (Rust)" })
