return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons"},
    config = function()
        local has, neotree = pcall(require, "neo-tree")
        if not has then
            return
        end

        neotree.setup({
            close_if_last_window = false,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = false,
            default_component_configs = {
                indent = { padding = 0 },
            },
            filesystem = {
                follow_current_file = true,
                use_libuv_file_watcher = true,
                window = {
                    mappings = {
                        ["a"] = "add", -- create file
                        ["A"] = "add_directory",
                        ["d"] = "delete",
                        ["r"] = "rename",
                        ["y"] = "copy_to_clipboard",
                        ["c"] = "copy",
                        ["x"] = "cut_to_clipboard",
                        ["p"] = "paste_from_clipboard",
                        ["o"] = "open",
                    },
                },
            },
            window = {
                position = "left",
                width = 35,
            },
        })
    end,
}
