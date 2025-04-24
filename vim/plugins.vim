" Automatic vim-plug install
 let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
 if empty(glob(data_dir . '/autoload/plug.vim'))
     silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
     autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

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

