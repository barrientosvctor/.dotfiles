local status, gruvbox = pcall(require, 'gruvbox')
if not status then return end

require('gruvbox').setup {
      undercurl = true,
      underline = true,
      bold = true,
      italic = true,
      strikethrough = true,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = 'hard', -- can be "hard", "soft" or empty string
      overrides = {},
}

vim.cmd [[colorscheme gruvbox]]
