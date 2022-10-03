require('shawn.packer')

-- Keymaps
require('shawn.keymaps')

-- Status line
require('shawn.plugin.lualine') -- Status line

-- LSP
require('shawn.plugin.lspconfig') -- LSP
require('shawn.plugin.lspinstaller') --- LSP Installer
require('shawn.plugin.cmp') -- LSP Autocompletion
require('shawn.plugin.lspsaga') -- LSP UI

-- Syntax / Syntax highlighting
require('shawn.plugin.treesitter') -- Syntax highlighting
require('shawn.plugin.colorizer') -- Hex codes
require('shawn.plugin.autopairs')

-- Utilities
require('shawn.plugin.telescope') -- Fuzzy finder
require('shawn.plugin.gitsigns') -- Git signs
require('shawn.plugin.ultisnips') -- Snippets

-- Themes
-- require('shawn.plugin.solarized')
-- require('shawn.plugin.gruvbox')
-- require('shawn.plugin.ayu')
require('shawn.plugin.abyss')
-- require('shawn.plugin.nord')
