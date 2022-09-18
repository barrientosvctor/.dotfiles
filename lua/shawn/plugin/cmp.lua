local status_cmp, cmp = pcall(require, 'cmp')
local status_kind, kind = pcall(require, 'lspkind')
if not status_cmp then return end
if not status_kind then return end

cmp.setup ({
    mapping = cmp.mapping.preset.insert({
	['<C-j>'] = cmp.mapping.select_next_item(),
	['<C-s>'] = cmp.mapping.select_next_item(),
	['<C-k>'] = cmp.mapping.select_prev_item(),
	['<C-a>'] = cmp.mapping.select_prev_item(),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<cr>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
    }),
    formatting = {
	format = kind.cmp_format({ mode = 'symbol_text', maxwidth = 50 })
    },
    snippet = {
	expand = function(args)
	    vim.fn["UltiSnips#Anon"](args.body) -- For UltiSnips
	end,
    },
    sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'ultisnips' }
    }, {
	{ name = 'path' }
    }),
    window = {
	-- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    }
})
