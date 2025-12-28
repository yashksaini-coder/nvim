return {
	{
		"IroncladDev/osmium",
		config = function()
			require("osmium").setup({
				integrations = {
					telescope = true,
					-- [...other integrations]
				},
				transparent_bg = false,
				show_end_of_buffer = false,
			})
		end,
	},
}
