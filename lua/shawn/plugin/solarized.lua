local status, solarized = pcall(require, 'solarized.nvim')
if not status then return end

solarized.set()
