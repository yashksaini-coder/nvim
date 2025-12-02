-- Dropbar keymaps

local function dropbar_pick()
    local api = require("dropbar.api")
    api.pick()
end

local function dropbar_context_start()
    local api = require("dropbar.api")
    api.goto_context_start()
end

local function dropbar_select_next_context()
    local api = require("dropbar.api")
    api.select_next_context()
end

vim.keymap.set("n", "<leader>dp", dropbar_pick, { desc = "Dropbar: Pick" })
vim.keymap.set("n", "<leader>ds", dropbar_context_start, { desc = "Dropbar: Go to context start" })
vim.keymap.set("n", "<leader>dn", dropbar_select_next_context, { desc = "Dropbar: Select next context" })
