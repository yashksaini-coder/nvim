-- A plugin for mini status line showcase

return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons',
                         'echasnovski/mini.icons', version = '*' 
                       },
    }
}
