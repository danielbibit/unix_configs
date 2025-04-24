" ------------- Remap ----------------------
nnoremap <SPACE> <Nop>

map <SPACE> <Leader>

" Centralize cursor when vertical navigating
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Add Ctrl P to fzf
nnoremap <silent> <C-p> :FZF<CR>

" Select indent last selected lines
" nnoremap > gv>
nnoremap Q <nop>

" Move lines when visual with C-j and C-v
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" C-o create empity line
nnoremap <C-o> o<ESC>

" C-/ comment lines
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

nnoremap <leader>y "+y
nnoremap <leader>Y "+Y

vnoremap <leader>y "+y
vnoremap <leader>Y "+Y


nnoremap <leader>p "+p
nnoremap <leader>P "+p
