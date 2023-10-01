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
set termguicolors
set foldmethod=indent
set foldlevel=1
set nofoldenable

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Move between split windows
nmap <C-h>	<C-w>h
nmap <C-j>	<C-w>j
nmap <C-k>	<C-w>k
nmap <C-l>	<C-w>l

" Tab navigation 
nmap <C-t> gt
nmap <C-q> :tabclose<CR>

" GitGutter
nmap <Leader>gu :GitGutterUndoHunk<CR>
nmap <Leader>gp :GitGutterPreviewHunk<CR>

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

