-- Load configuration in order
require("yashksaini-coder.options") -- Options first
require("yashksaini-coder.highlights") -- Highlights before lazy
require("yashksaini-coder.lazy") -- Lazy plugin manager
require("yashksaini-coder.keymaps") -- Keymaps (loads all keymap modules)
require("yashksaini-coder.autocmds") -- Autocmds