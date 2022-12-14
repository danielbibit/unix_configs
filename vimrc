" Default file encoding
set encoding=utf8

" Automatic vim-plug install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set signcolumn="yes"

" Setup plugins
call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'preservim/nerdtree'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'yggdroot/indentline'
    Plug 'sheerun/vim-polyglot'
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

set showcmd
set showmatch
set ignorecase
set smartcase
set hidden
set mouse=a

set confirm
set autoread
set ruler

filetype plugin indent on
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

" Centralize cursor when vertical navigating
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

"Remove trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" NERDTree config
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
