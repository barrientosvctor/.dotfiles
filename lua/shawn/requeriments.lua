require('shawn.packer')

-- Keymaps
require('shawn.keymaps')

-- Status line
require('shawn.plugin.lualine')

-- LSP
require('shawn.plugin.lspconfig')
require('shawn.plugin.lspinstaller')
require('shawn.plugin.cmp') -- LSP Autocompletion
require('shawn.plugin.lspsaga') -- LSP UI

-- Syntax / Syntax highlighting
require('shawn.plugin.treesitter')
require('shawn.plugin.colorizer') -- Hex codes
require('shawn.plugin.autopairs')

-- Utilities
require('shawn.plugin.telescope')
require('shawn.plugin.gitsigns')
require('shawn.plugin.ultisnips')

-- Themes
-- require('shawn.plugin.solarized')
require('shawn.plugin.gruvbox')
-- require('shawn.plugin.ayu')
