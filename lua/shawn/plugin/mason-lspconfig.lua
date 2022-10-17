local status, mason = pcall(require, 'mason-lspconfig')
if not status then return end

mason.setup({
    ensure_installed = { 'tsserver', 'pyright', 'html', 'jsonls', 'cssls', 'emmet_ls', 'sumneko_lua' },
    automatic_installation = true,
})
