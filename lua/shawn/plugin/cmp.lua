local status_cmp, cmp = pcall(require, 'cmp')
if not status_cmp then return end

local status_luasnip, luasnip = pcall(require, 'luasnip')
if not status_luasnip then return end

local status_cmp_luasnip, _ = pcall(require, 'cmp_luasnip')
if not status_cmp_luasnip then return end

require('luasnip/loaders/from_vscode').lazy_load()

local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup ({
    mapping = cmp.mapping.preset.insert({
	-- ['<C-j>'] = cmp.mapping.select_next_item(),
	['<C-s>'] = cmp.mapping.select_next_item(),
	-- ['<C-k>'] = cmp.mapping.select_prev_item(),
	['<C-a>'] = cmp.mapping.select_prev_item(),
	-- ['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<cr>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
    }),
    formatting = {
	format = function(entry, vim_item)
	    -- Kind icons
	    vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
	    return vim_item
	end,
    },
    snippet = {
	expand = function(args)
	luasnip.lsp_expand(args.body)
	end,
    },
    sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'luasnip' }
    }, {
	{ name = 'path' }
    }),
    window = {
	-- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})
