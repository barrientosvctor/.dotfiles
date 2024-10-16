""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""
let has_lua_and_abyss = has("lua") && !empty(glob("~/projects/nvim/abyss.nvim"))
let enable_abyss = 0

set bg=dark
set number
set relativenumber
set history=1000
set ruler
set undofile
set colorcolumn=80
set wrap
set hlsearch
set showmatch
set incsearch
set ignorecase
set smartcase
set encoding=utf-8
scriptencoding utf-8
set autoindent
set smartindent
set nowrap
set backspace=indent,eol,start
set hidden
set expandtab
set shiftwidth=4
set softtabstop=4  " Use value of shiftwidth
set smarttab       " Always use shiftwidth
set noswapfile
set nobackup
set wildmenu
set laststatus=2
set scrolloff=5
set list
set cursorline

" Must have coc options
set signcolumn=yes
set updatetime=300
let mapleader = ","
let maplocalleader = ","
if has("patch-8.2.4325") && exists("+wildoptions") | set wildoptions=pum | endif
if exists("+termguicolors") | set termguicolors | endif
if exists("+clipboard") && exists("+clientserver") | set clipboard=unnamedplus | endif
if !has("nvim")
	if has("unix")
		set undodir=~/.vim/undodir
	elseif has("win32")
		set undodir=~/vimfiles/undodir
	endif
endif

""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""
call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'

if has('nvim')
	Plug 'nvim-treesitter/nvim-treesitter'
else
	Plug 'sheerun/vim-polyglot'
endif

if has("patch-9.0.1799")
    packadd! editorconfig
else
    if !has("nvim")
        Plug 'editorconfig/editorconfig-vim'
    endif
endif

if has_lua_and_abyss
    Plug '~/projects/nvim/abyss.nvim'
endif
call plug#end()

""""""""""""""""""""""""""""
" Plugin configuration
""""""""""""""""""""""""""""
if has("nvim")
    lua require("nvim-treesitter.configs").setup({ highlight = { enable = true }, indent = { enable = true } })
endif

" -----------------
" Coc.nvim
" -----------------
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Trigger completion
inoremap <silent><expr> <C-f> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

""""""""""""""""""""""""""""
" Keymaps
""""""""""""""""""""""""""""
nnoremap <Esc> <Cmd>nohlsearch<CR>
nnoremap <Leader>fe <Cmd>Ex<CR>
nnoremap <Leader>tx <Cmd>split<CR><C-w>j
nnoremap <Leader>ty <Cmd>vsp<CR><C-w>l
nnoremap <Leader>th <Cmd>term<CR>
nnoremap <Leader>tv <Cmd>vertical terminal<CR>
nnoremap <Leader>te <Cmd>tabedit<CR>
nnoremap <Leader>tp <Cmd>tabprevious<CR>
nnoremap <Leader>tn <Cmd>tabnext<CR>
tnoremap <Esc><Esc> <C-\><C-n>
nnoremap <Leader>bd <Cmd>bd<CR>
nnoremap <Leader>ff <Cmd>FZF<CR>
nnoremap <Leader>fg <Cmd>Rg<CR>
nnoremap <Leader>fb <Cmd>Buffers<CR>
nnoremap <Leader>fh <Cmd>History<CR>
nnoremap t<Left> <C-w>>
nnoremap t<Right> <C-w><
nnoremap t<Up> <C-w>+
nnoremap t<Down> <C-w>-
command! ToggleBackground execute "set background=" . ( &background == 'dark' ? 'light' : 'dark' )

""""""""""""""""""""""""""""
" Adding packages
""""""""""""""""""""""""""""
if !has("nvim")
    packadd comment
endif

if has_lua_and_abyss && enable_abyss
    lua require("abyss").setup {}
else
    colorscheme gruvbox
endif
