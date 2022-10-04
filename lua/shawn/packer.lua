local status, packer = pcall(require, 'packer')
if not status then
    print('Packer is not installed.')
    return
end

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Themes --
    use 'maxmx03/solarized.nvim'
    use 'Shatur/neovim-ayu'
    use 'morhetz/gruvbox'
    use 'shaunsingh/nord.nvim'
    use '~/AppData/Local/nvim-data/site/pack/local/start'
    use '~/AppData/Local/nvim-data/site/pack/local/vscode.nvim/'

    -- Syntax --
    use {
	'nvim-treesitter/nvim-treesitter',
	requires = 'nvim-treesitter/playground',
	run = ':TSUpdate'
    }
    use 'windwp/nvim-autopairs'
    use 'windwp/nvim-ts-autotag'
    use 'norcalli/nvim-colorizer.lua'

    -- Customization --
    use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- LSP --
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind.nvim'
    use {
	'glepnir/lspsaga.nvim',
	commit = 'ae099d5844b005cec66a66ab30a44d3bf8867af9',
    }
    use {
	'williamboman/nvim-lsp-installer',
	requires = { 'neovim/nvim-lspconfig' }
    }

    -- LSP Autocompletion --
    use {
	'hrsh7th/nvim-cmp',
	requires = {
	    'hrsh7th/cmp-nvim-lsp',
	    'hrsh7th/cmp-path',
	    'SirVer/ultisnips',
	    'quangnguyen30192/cmp-nvim-ultisnips'
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
