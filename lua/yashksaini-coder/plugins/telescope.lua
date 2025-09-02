return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x", -- actively maintained branch instead of tag
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-symbols.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local themes = require("telescope.themes")

        -- Ivy theme with custom borders
        local ivy_opts = themes.get_ivy({
            borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            layout_config = {
                height = 0.8,
                preview_cutoff = 120,
                width = 0.8,
                anchor = "CENTER",
                prompt_position = "top",
            },
        })

        telescope.setup({
            defaults = {
                prompt_prefix = " 🔍 ",
                selection_caret = " ❯ ",
                path_display = { "truncate" },

                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-c>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                    },
                    n = {
                        ["<C-c>"] = actions.close,
                        ["<CR>"] = actions.select_default,
                    },
                },

                border = true,
                borderchars = ivy_opts.borderchars,
                layout_config = ivy_opts.layout_config,

                preview = {
                    treesitter = true,
                    timeout = 300,
                },

                results_title = false,
                prompt_title = false,

                selection_strategy = "reset",
                sorting_strategy = "ascending",
                scroll_strategy = "cycle",
            },

            pickers = {
                find_files = {
                    theme = "ivy",
                    hidden = true,
                    follow = true,
                },
                live_grep = {
                    theme = "ivy",
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
                grep_string = {
                    theme = "ivy",
                    additional_args = function()
                        return { "--hidden" }
                    end,
                },
                buffers = {
                    theme = "ivy",
                    sort_lastused = true,
                    previewer = false,
                },
                help_tags = { theme = "ivy" },
                commands = { theme = "ivy" },
                keymaps = { theme = "ivy" },
                colorscheme = {
                    theme = "ivy",
                    enable_preview = true,
                },
                lsp_references = { theme = "ivy" },
                lsp_definitions = { theme = "ivy" },
                lsp_implementations = { theme = "ivy" },
                lsp_type_definitions = { theme = "ivy" },
                diagnostics = { theme = "ivy" },
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = themes.get_dropdown(),
                symbols = { theme = "ivy" },
                live_grep_args = {
                    theme = "ivy",
                    auto_quoting = true,
                },
            },
        })

        -- Load extensions safely
        pcall(telescope.load_extension, "fzf")
        pcall(telescope.load_extension, "ui-select")
        pcall(telescope.load_extension, "symbols")
        pcall(telescope.load_extension, "live_grep_args")
    end,
}
