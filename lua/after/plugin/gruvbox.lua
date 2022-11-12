local status, gruvbox = pcall(require, "gruvbox")
if not status then return end

gruvbox.setup({
    italic = false,
    bold = false,
    contrast = "hard",
    palette_overrides = {},
    overrides = {},
})

vim.cmd [[colorscheme gruvbox]]
