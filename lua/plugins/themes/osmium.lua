return {{
    "IroncladDev/osmium",
    config = function()
        require("osmium").setup({
            integrations = {
                gitsigns = true,
                telescope = true
                -- [...other integrations]
            },
            transparent_bg = false,
            show_end_of_buffer = false
        })
    end
}}
