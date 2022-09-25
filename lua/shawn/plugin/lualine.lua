local status, lualine = pcall(require, 'lualine')
if not status then return end

lualine.setup({
    options = {
        theme = 'solarized_dark',
        component_separators = '|',
        section_separators = '',
        icons_enabled = true,
        globalstatus = false,
	disabled_filetypes = {},
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
	    { 'branch' },
	    { 'diff', colored = false }
	},
        lualine_c = {
            { 'filename', file_status = true, path = 0 }, -- just filename, 1 = relative path, 2 = absolute path
            { 'diagnostics' },
        },
        lualine_x = {
	    { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
	    'filetype'
	},
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { 'filename' },
	lualine_x = {},
	lualine_y = {},
	lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
})

lualine.get_config()
