local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Hotkeys
keymap.set('n', '<C-q>', '<Cmd>q<cr>', opts)
keymap.set('n', '<C-w>', '<Cmd>w<cr>', opts)
keymap.set('n', '<C-x>', '<Cmd>x<cr>', opts)
keymap.set('n', 'th', '<Cmd>botright new <Bar> :terminal<cr>', opts)
keymap.set('n', 'tv', '<Cmd>botright vnew <Bar> :terminal<cr>', opts)

-- Telescope
keymap.set('n', '<F1>', '<Cmd>Telescope file_browser<cr>', opts)
keymap.set('n', '<F2>', '<Cmd>Telescope find_files<cr>', opts)
keymap.set('n', '<F3>', '<Cmd>Telescope live_grep<cr>', opts)
keymap.set('n', '<F4>', '<Cmd>Telescope diagnostics<cr>', opts)

-- Lspsaga
keymap.set('n', 'ñd', '<Cmd>Lspsaga diagnostic_jump_next<cr>', opts)
keymap.set('n', 'ññ', '<Cmd>Lspsaga hover_doc<cr>', opts)
keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<cr>', opts)
keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<cr>', opts)
keymap.set('n', 'gr', '<Cmd>Lspsaga rename<cr>', opts)

-- Delete words
keymap.set('n', 'z', '"_x', opts)
keymap.set('n', '{', 'vb"_d', opts)

-- Increment and decrement
keymap.set('n', '+', '<C-a>', opts)
keymap.set('n', '-', '<C-x>', opts)

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G', opts)

-- New tab
keymap.set('n', 'te', '<Cmd>tabedit<cr>', opts)

-- Split window
keymap.set('n', 'ss', '<Cmd>split<Return><C-w>w', opts)
keymap.set('n', 'sv', '<Cmd>vsplit<cr>', opts)

-- Move window
keymap.set('n', '<Space>', '<C-w>w', opts)
keymap.set('', '<C-h>', '<C-w>h', opts)
keymap.set('', '<C-k>', '<C-w>k', opts)
keymap.set('', '<C-j>', '<C-w>j', opts)
keymap.set('', '<C-l>', '<C-w>l', opts)

-- Resize window
keymap.set('n', 't<left>', '<C-w><', opts)
keymap.set('n', 't<right>', '<C-w>>', opts)
keymap.set('n', 't<up>', '<C-w>+', opts)
keymap.set('n', 't<down>', '<C-w>-', opts)

-- Information --
keymap.set('n', '<F12>', '<Cmd>Telescope help_tags<cr>', opts)

-- Additional note
-- To move between tabs use g + t or g + T
-- Source: https://superuser.com/questions/410982/in-vim-how-can-i-quickly-switch-between-tabs
