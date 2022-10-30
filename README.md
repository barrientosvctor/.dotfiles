# Shawn's dotfiles configuration

## Pre-requeriments
* [Neovim](https://neovim.io/) >= 0.7 version
* [Python](https://www.python.org/downloads/) >= 3.10.5 version
* [Node.js](https://nodejs.org/en/)
* [Git](https://git-scm.com/)
* [Chocolatey](https://chocolatey.org/) (Only for Windows users)
* [Homebrew](https://brew.sh/) (Only for Unix users)
* mingw: This is necessary for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter). [Unix installation](https://formulae.brew.sh/formula/mingw-w64#default) / [Windows installation](https://community.chocolatey.org/packages/mingw)


## Neovim config

> Plugins

**Note:** Before the plugins installation, you need install [packer.nvim](https://github.com/wbthomason/packer.nvim).

* [neosolarized.nvim](https://github.com/svrana/neosolarized.nvim)
    * It requires [colorbuddy.nvim](https://github.com/tjdevries/colorbuddy.nvim).
* [abyss.nvim](https://github.com/uShawnTS/abyss.nvim)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - [Treesitter](https://github.com/tree-sitter/tree-sitter) configurations and abstraction layer for Neovim.
* [nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Insert or delete brackets, parens, quotes in pair.
* [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Insert tags.
* [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) - Show colors blocks in hex codes.
* [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) - **(Optional)** A lua fork of [vim-devicons](https://github.com/ryanoasis/vim-devicons). This plugin provides the same icons as well as colors for each icon.
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - A collection of configurations for Neovim's built-in LSP.
* [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP Installer
    * It requires [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
* [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - A [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) source for neovim's built-in language server client.
* [cmp-path](https://github.com/hrsh7th/cmp-path) - A [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) source for filesystem paths.
* [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - These plugins allows create and use custom snippets.
    * These plugins requires [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
* [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim) - LSP UI.
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - telescope.nvim is a highly extendable fuzzy finder over lists.
    * It requires [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim).
 
* [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - Markdown previewer on web for vim and neovim.
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration for buffers.

> Setup

1. Install [packer.nvim](https://github.com/wbthomason/packer.nvim)

2. Install plugins with `PackerSync`

## PowerShell setup (Windows) 

> Plugins
* [Chocolatey](https://chocolatey.org/) - A command-line installer
* [Git for Windows](https://git-scm.com/)
* [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
* [PSReadLine](https://github.com/PowerShell/PSReadLine) - Cmdlets for customizing the editing environment, used for autocompletion
* [Terminal Icons](https://github.com/devblackops/Terminal-Icons) - Icons for files and folders
