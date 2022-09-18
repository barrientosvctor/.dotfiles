local status, lsp = pcall(require, 'lspconfig')
if not status then return end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'tsserver', 'cssls', 'jsonls', 'html', 'emmet_ls' }

for _, lang in ipairs(servers) do
    lsp[lang].setup { capabilities = capabilities }
end
