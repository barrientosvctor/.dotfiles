local status, packer = pcall(require, 'packer')
if not status then
    print('Packer is not installed.')
    return
end

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Themes --
    use {
	'svrana/neosolarized.nvim',
	requires = 'tjdevries/colorbuddy.nvim'
    }
    use '~/AppData/Local/nvim-data/site/pack/local/abyss.nvim'

    -- Web Devicons
    use 'nvim-tree/nvim-web-devicons'

    -- Syntax --
    use {
	'nvim-treesitter/nvim-treesitter',
	requires = 'nvim-treesitter/playground',
	run = ':TSUpdate'
    }
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'norcalli/nvim-colorizer.lua'

    -- LSP --
    use {
	'neovim/nvim-lspconfig',
	-- use "williamboman/nvim-lsp-installer" -- simple to use language server installer
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim'
    }
    use 'glepnir/lspsaga.nvim'

    -- LSP Autocompletion --
    use {
	'hrsh7th/nvim-cmp',
	requires = {
	    'hrsh7th/cmp-nvim-lsp',
	    'hrsh7th/cmp-path',
	    'L3MON4D3/LuaSnip', -- snippet engine
	    'saadparwaiz1/cmp_luasnip', -- cmp luasnip autocompletion
	    'rafamadriz/friendly-snippets'
	},
    }

    -- Snippets --
    use 'honza/vim-snippets'

    -- Utilities --
    use {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	requires = {
	    'nvim-lua/plenary.nvim',
	    'nvim-telescope/telescope-file-browser.nvim'
	},
    }
    use({ 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, })
    use 'lewis6991/gitsigns.nvim'
    use 'numToStr/Comment.nvim'
end)
