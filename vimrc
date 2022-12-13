set encoding=utf8

syntax on

set background=dark

filetype plugin indent on

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
