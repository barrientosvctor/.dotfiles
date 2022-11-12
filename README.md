# Shawn's dotfiles configuration

A simple dotfiles's configuration.

## Pre-requeriments
* [Neovim](https://neovim.io/) >= 0.8 version
* [Python](https://www.python.org/downloads/) >= 3.10.5 version
* [Node.js](https://nodejs.org/en/)
* [Git](https://git-scm.com/)
* [Chocolatey](https://chocolatey.org/) (Only for Windows users)
* [Homebrew](https://brew.sh/) (Only for Unix users)
* mingw: This is necessary for [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter). [Unix installation](https://formulae.brew.sh/formula/mingw-w64#default) / [Windows installation](https://community.chocolatey.org/packages/mingw)


## Neovim config

> Plugins

**Note:** Before the plugins installation, you need install [packer.nvim](https://github.com/wbthomason/packer.nvim).

* [gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)
* [autopairs.vim](https://github.com/jiangmiao/auto-pairs) - Insert or delete brackets, parens, quotes in pair.
* [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - A collection of configurations for Neovim's built-in LSP.
* [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP Installer
    * It requires [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim)
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion engine plugin for neovim written in Lua. Completion sources are installed from external repositories and "sourced".
* [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - A [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) source for neovim's built-in language server client.
* [cmp-path](https://github.com/hrsh7th/cmp-path) - A [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) source for filesystem paths.
* [LuaSnip](https://github.com/L3MON4D3/LuaSnip) - These plugins allows create and use custom snippets.
    * These plugins requires [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
* [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim) - LSP UI.
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - telescope.nvim is a highly extendable fuzzy finder over lists.
    * It requires [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim).
 
* [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration for buffers.
* [Comment.nvim](https://github.com/numToStr/Comment.nvim) - Make comments faster.

> Setup

1. Install [packer.nvim](https://github.com/wbthomason/packer.nvim)

2. Install plugins with `PackerInstall`

## PowerShell setup (Windows) 

> Plugins
* [Chocolatey](https://chocolatey.org/) - A command-line installer
* [Git for Windows](https://git-scm.com/)
* [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
* [PSReadLine](https://github.com/PowerShell/PSReadLine) - Cmdlets for customizing the editing environment, used for autocompletion
