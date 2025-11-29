-- find files with Telescope
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files hidden=true<CR>', { silent = true, desc = 'Telescope: find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { silent = true, desc = 'Telescope: live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { silent = true, desc = 'Telescope: buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { silent = true, desc = 'Telescope: help tags' })
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope grep_string<CR>', { silent = true, desc = 'Telescope: grep string under cursor' })