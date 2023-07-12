set laststatus=2
set smartindent
set tabstop=4
set expandtab
set shiftwidth=4
set autowrite
set autoread
set tabpagemax=20
set updatetime=100
set number
set cursorline
set autochdir
set termguicolors
set foldmethod=indent
set backspace=indent,eol,start

" Move between split windows
nmap <C-h>	<C-w>h
nmap <C-j>	<C-w>j
nmap <C-k>	<C-w>k
nmap <C-l>	<C-w>l

" Tab navigation 
nmap <C-t> gt
nmap <C-q> :tabclose<CR>

call plug#begin('~/.local/share/nvim/site/plugged')
" Vim Settings
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '907th/vim-auto-save'
Plug 'terryma/vim-smooth-scroll'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
"
" Tabs
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'romgrk/barbar.nvim'
"
" Editing
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
"
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" 
" Formatting
" Plug 'junegunn/vim-easy-align'
Plug 'vim-autoformat/vim-autoformat'
"
" THEMES
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
" Plug 'sonph/onehalf', { 'rtp': 'vim/' }
" Plug 'bluz71/vim-moonfly-colors', {'as': 'moonfly'}
" Plug 'pacokwon/onedarkhc.vim'
"
" WEB
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'leafOfTree/vim-matchtag'
" Plug 'valloric/matchtagalways'
" Plug 'mattn/emmet-vim'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'leafgarland/typescript-vim'
"
" C/C++
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
"
" Snippets 
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
"
" LSP
" Plug 'w0rp/ale'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'keremc/asyncomplete-clang.vim'
" Plug 'ray-x/lsp_signature.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip' 
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
"
" Autocomplete 
Plug 'github/copilot.vim'
"
" Misc 
Plug 'wakatime/vim-wakatime'

call plug#end()

" AutoSave
let g:auto_save=1

" vim-smooth-scroll
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 5)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 5)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 3)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 3)<CR>

map gn :NvimTreeFocus<CR>

autocmd FileType qf setlocal wrap

" Prettier Settings
" let g:prettier#autoformat = 1
" let g:prettier#autoformat_require_pragma = 0
" map <silent> <c-P> :Prettier<CR>

let g:copilot_no_tab_map = v:true
imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\<Tab>")
