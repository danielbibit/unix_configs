" Default file encoding
set encoding=utf8

set signcolumn="yes"

let &t_SI = "\<esc>[5 q" " I beam cursor for insert mode
let &t_EI = "\<esc>[2 q" " block cursor for normal mode - Change to 1 for blinking cursor
let &t_SR = "\<esc>[3 q" " underscore cursor for replace

" Setup plugins
call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'vim-airline/vim-airline'
    Plug 'yggdroot/indentline'
    Plug 'sheerun/vim-polyglot'
    Plug 'junegunn/fzf'
    Plug 'ervandew/supertab'
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdcommenter'
call plug#end()

" Add supeior vim arline to open buffers
let g:airline#extensions#tabline#enabled = 1

syntax on
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_invert_selection=0
colorscheme gruvbox

" Show line numbers
set number
set relativenumber

set cursorline

let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
set showcmd
set showmatch
set ignorecase
set smartcase
set hidden
set confirm
set autoread
set ruler

filetype plugin indent on
filetype plugin on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

" Save file as sudo with 'w!!'
cmap w!! w !sudo tee > /dev/null %

" Make 'set: list' show hidden charecters
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:.

set clipboard=unnamedplus

set foldmethod=indent

" command! -nargs=0 Sw w !sudo tee % > /dev/null

set nofoldenable

"Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

"Window mangement
set splitright
set splitbelow

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
vnoremap <leader>y "+y

nnoremap <leader>Y "+Y
vnoremap <leader>Y "+Y
