set encoding=utf8

syntax on

set background=dark

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

set number                     " Show current line number
set relativenumber             " Show relative line numbers

set cursorline
"hi CursorLine ctermbg=darkgrey term=none cterm=none

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set hidden              " Hide buffers when they are abandoned
set mouse=a             " Enable mouse usage (all modes)

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
