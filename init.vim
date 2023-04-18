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
" set rnu
set autochdir

" Tab navigation like Firefox.
nnoremap <C-Del> :tabc<CR>

func Terminal()
 : terminal
 : set nonumber
 : resize 10
 : endfunction

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '907th/vim-auto-save'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-smooth-scroll'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'wakatime/vim-wakatime'
Plug 'leafOfTree/vim-matchtag'
Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
" " Plug 'sonph/onehalf', { 'rtp': 'vim/' }
" " Plug 'SirVer/ultisnips'
" " Plug 'honza/vim-snippets'
" " Plug 'junegunn/vim-easy-align'
" " Plug 'valloric/youcompleteme'
Plug 'mattn/emmet-vim'
" Plug 'valloric/matchtagalways'
Plug 'w0rp/ale'
" Plug 'peitalin/vim-jsx-typescript'
" " Plug 'leafgarland/typescript-vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'keremc/asyncomplete-clang.vim'
Plug 'ray-x/lsp_signature.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-autoformat/vim-autoformat'
Plug 'github/copilot.vim'
call plug#end()

colorscheme nightfly

" AutoSave
let g:auto_save=1

" NerdTree
function MirrorNerdTreeIfOneWindow()
  if winnr("$") < 2
    NERDTreeMirror

    " hack to move the focus from the NERDTree to the main window
    wincmd p
    wincmd l
  endif
endfunction

autocmd VimEnter * silent NERDTree | wincmd p
autocmd GuiEnter * silent NERDTree
autocmd TabEnter * silent exe MirrorNerdTreeIfOneWindow()
let NERDTreeShowHidden=1

" vim-smooth-scroll
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 5)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 5)<CR>
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 3)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 3)<CR>

" Set Onehalfdark Theme
" colorscheme onehalfdark
" let g:airline_theme='onedark'

" ALE Settings
let g:ale_open_list = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'c': ['clangtidy', 'clang-format'],
\}
autocmd FileType qf setlocal wrap

" Prettier Settings
" let g:prettier#autoformat = 1
" let g:prettier#autoformat_require_pragma = 0
map <silent> <c-P> :Prettier<CR>

" Asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

" " Asyncomplete clang
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#clang#get_source_options())

" Vim LSP
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END