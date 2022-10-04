-- Basic config
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shell = 'pwsh'
vim.opt.wrap = false
vim.opt.laststatus = 3

-- Spaces and indents
vim.opt.sw = 4
vim.opt.cindent = true
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.breakindent = true

-- Highlights
vim.opt.cursorline = true
vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5

-- Extras
vim.opt.scrolloff = 10
vim.opt.wildignore:append { '*/node_modules/*', '*/.git/*' }

-- Clipboard
if vim.fn.has('win32') then
    vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }
end

if vim.fn.has('macunix') then
    vim.opt.clipboard:append { 'unnamedplus' }
end

require('shawn.requeriments')
