local status, packer = pcall(require, "packer")
if not status then
    print("Packer is not installed.")
    return
end

return packer.startup(function(use)
    use "wbthomason/packer.nvim"

    -- Personalization
    use "ellisonleao/gruvbox.nvim"
    use {
        "nvim-lualine/lualine.nvim"
    }

    -- LSP
    use {
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim"
    }
    use "glepnir/lspsaga.nvim"

    -- Cmp
    use {
	"hrsh7th/nvim-cmp",
	requires = {
	    "hrsh7th/cmp-nvim-lsp",
	    "hrsh7th/cmp-path",
	    "L3MON4D3/LuaSnip",
	    "saadparwaiz1/cmp_luasnip"
	}
    }

    -- Utils
    use {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	requires = {
	    "nvim-lua/plenary.nvim",
	    "nvim-telescope/telescope-file-browser.nvim"
	}
    }

    use "jiangmiao/auto-pairs"
    use "numToStr/Comment.nvim"
    use "lewis6991/gitsigns.nvim"
    use "gpanders/editorconfig.nvim"
end)
