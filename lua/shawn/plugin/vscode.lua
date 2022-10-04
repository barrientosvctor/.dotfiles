local status, vsc = pcall(require, 'vscode')
if not status then return end

vsc.setup({})
