set encoding=utf8

" Automatic vim-plug install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Setup plugins
call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'preservim/nerdtree'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-surround'
    Plug 'vim-airline/vim-airline'
    Plug 'yggdroot/indentline'
    Plug 'sheerun/vim-polyglot'
call plug#end()

syntax on
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

set number
set relativenumber

set cursorline

set showcmd
set showmatch
set ignorecase
set smartcase
set hidden
set mouse=a

set number
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

cmap w!! w !sudo tee > /dev/null %

set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:.

set clipboard=unnamedplus

set foldmethod=indent

command! -nargs=0 Sw w !sudo tee % > /dev/null

set nofoldenable

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

autocmd BufWritePre * :%s/\s\+$//e "Remove trailing whitespaces on save
