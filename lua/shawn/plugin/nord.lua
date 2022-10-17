local status, nord = pcall(require, 'nord')
if not status then return end

-- Example config in lua
vim.g.nord_disable_background = false
vim.g.nord_italic = true

-- Load the colorscheme
nord.set()
