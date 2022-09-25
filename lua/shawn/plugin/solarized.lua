local status, solarized = pcall(require, 'solarized')
if not status then return end

solarized.setup({
    transparent = true,
    theme = 'neovim', -- Available themes: vim/neovim and vscode
    mode = 'dark',
    highlights = function(colors)
	return {
	    -- Colorscheme
	    LineNr = { bg = solarized:is_transparent(colors.bg_alt) }, -- bg_alt if solarized is not transparent
	    CursorLineNr = { fg = '#f9ef17', bg = '#00000f' },
	    TSBoolean = { fg = colors.yellow },

	    -- CMP KIND
	    CmpItemKindTabnine = { fg = colors.magenta },
	    CmpItemKindEmoji = { fg = colors.yellow },
	    CmpItemAbbrMatch = { bg = '#00000a', fg = '#e1cd84', reverse = true },

	    -- Telescope
	    TelescopePreviewTitle = { fg = '#2aa19a', bg = solarized:is_transparent(colors.bg_alt) },
	    TelescopeResultsTitle = { fg = '#2aa19a', bg = solarized:is_transparent(colors.bg_alt) },
	    TelescopePromptTitle = { fg = '#2aa19a', bg = solarized:is_transparent(colors.bg_alt) },
	    TelescopeSelection = { fg = '#cb4b16' },
	    TelescopeMatching = { bg = '#00000a', fg = '#e1cd84', reverse = true },
	}
    end,
})

vim.cmd [[colorscheme solarized]]
