local status, lualine = pcall(require, 'lualine')
if not status then return end

lualine.setup({
    options = {
        theme = 'auto',
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
	    { 'diagnostics', sources = { 'nvim_diagnostic' }, symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } },
        },
        lualine_x = { 'filetype' },
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
