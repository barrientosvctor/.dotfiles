local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then return end

treesitter.setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'html', 'css', 'javascript', 'json' },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
	enable = true,
	disable = {}
    },
    autotag = {
	enable = true
    },
    playground = {
	enable = true,
	updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
	persist_queries = false, -- Whether the query persists across vim sessions
	keybindings = {
	    toggle_query_editor = 'o',
	    toggle_hl_groups = '<C-i>',
	    toggle_injected_languages = 't',
	    toggle_anonymous_nodes = 'a',
	    toggle_language_display = 'I',
	    focus_language = 'f',
	    unfocus_language = 'F',
	    update = 'R',
	    goto_node = '<cr>',
	    show_help = '?',
    },
    }
}
