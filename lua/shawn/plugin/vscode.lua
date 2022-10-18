local status, vscode = pcall(require, 'vscode')
if not status then return end

vscode.setup({
    italics_comments = true,
})
