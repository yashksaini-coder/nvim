local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>h', mark.add_file,{desc="Add file to harpoon"})
vim.keymap.set('n', '<leader>hr', mark.rm_file,{desc="Remove file from harpoon"})
vim.keymap.set('n', '<leader>H', ui.toggle_quick_menu,{desc="Show harpoon files"})

for i = 1, 9 do
    vim.keymap.set('n', '<leader>' .. i, function() ui.nav_file(i) end, { desc = "Harpoon to File " .. i })
end

vim.keymap.set('n', '<S-k>', ui.nav_next,{desc="Go to Prev file"})
vim.keymap.set('n', '<S-j>', ui.nav_prev,{desc="Go to next file"})              