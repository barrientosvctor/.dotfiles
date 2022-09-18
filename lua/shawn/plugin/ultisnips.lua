local status_ulti, snips = pcall(require, 'ultisnips')
local status_ulti_cmp = pcall(require, 'cmp_nvim_ultisnips')
if not status_ulti then return end
if not status_ulti_cmp then return end

vim.g.UltiSnipsSnippetDirectories = 'c:\\users\\josal\\appdata\\local\\nvim\\snippets'
