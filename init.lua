vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.opt.laststatus = 3

-- Spaces / indents
vim.opt.sw = 4 -- Spaces
vim.opt.cindent = true
vim.opt.ai = true -- Auto indent
vim.opt.si = true -- Smart indent
vim.opt.breakindent = true

-- Highlights
vim.opt.cursorline = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5

-- Clipboard
if vim.fn.has("win32") then
    vim.opt.clipboard:prepend { "unnamed", "unnamedplus" }
    vim.opt.shell = "pwsh"
end

if vim.fn.has("macunix") then
    vim.opt.clipboard:append { "unnamedplus" }
end

require("requeriments")
vim.cmd [[set guicursor=n-i-c-v:block]]
