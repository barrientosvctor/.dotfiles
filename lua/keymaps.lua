-- Hotkeys
vim.keymap.set("n", "<C-w>", "<cmd>w<cr>")
vim.keymap.set("n", "<C-q>", "<cmd>q<cr>")
vim.keymap.set("n", "<C-x>", "<cmd>x<cr>")
vim.keymap.set("n", "th", "<cmd>botright new <Bar> :term<cr>")
vim.keymap.set("n", "tv", "<cmd>botright vnew <Bar> :term<cr>")

-- Increment / decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- New tab
vim.keymap.set("n", "te", "<cmd>tabedit<cr>")

-- Split window
vim.keymap.set("n", "ss", "<cmd>split<Return><C-w>w")
vim.keymap.set("n", "sv", "<cmd>vsplit<cr>")

-- Move window
vim.keymap.set("n", "<Space>", "<C-w>w")
vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-k>", "<C-w>k")
vim.keymap.set("", "<C-j>", "<C-w>j")
vim.keymap.set("", "<C-l>", "<C-w>l")

-- Resize window
vim.keymap.set("n", "t<left>", "<C-w><")
vim.keymap.set("n", "t<right>", "<C-w>>")
vim.keymap.set("n", "t<up>", "<C-w>+")
vim.keymap.set("n", "t<down>", "<C-w>-")

-- Telescope
vim.keymap.set("n", "<F1>", "<cmd>Telescope file_browser<cr>")
vim.keymap.set("n", "<F2>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<F3>", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<F4>", "<cmd>Telescope diagnostics<cr>")

-- Lspsaga
vim.keymap.set("n", "ñd", "<cmd>Lspsaga diagnostic_jump_next<cr>")
vim.keymap.set("n", "ññ", "<cmd>Lspsaga hover_doc<cr>")
vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<cr>")
vim.keymap.set("n", "gp", "<cmd>Lspsaga preview_definition<cr>")
vim.keymap.set("n", "cd", "<cmd>Lspsaga code_action<cr>")
