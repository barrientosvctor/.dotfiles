require('shawn.packer')

-- Keymaps
require('shawn.keymaps')

-- LSP
require('shawn.plugin.lspconfig') -- LSP
require('shawn.plugin.mason') -- LSP
require('shawn.plugin.mason-lspconfig') -- LSP
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
require('shawn.plugin.comment') -- Comments

-- Themes
require('shawn.plugin.ayu')
-- require('shawn.plugin.nord')
