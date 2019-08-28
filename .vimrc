set nocompatible              
set noswapfile
filetype off                 

"Plugin Section

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'jalvesaq/Nvim-R'
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()            
filetype plugin indent on    

syntax on
set tabstop=4
set expandtab
set number
set undofile
set undodir=~/.vim/undodir

let R_source = '~/dotfiles/tmux_split.vim'
let R_in_buffer = 0
let R_tmux_split = 1
let vimrplugin_assign = 0

let mapleader = ","
let localleader = "\\"

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

map <Leader>be :MBEOpen<CR>
map <Leader>bc :MBEClose<CR>
map <Leader>bt :MBEToggle<CR>

map <C-n> :NERDTreeToggle<CR>

map <Leader>vp :VimuxPromptCommand<CR>

set splitbelow
set splitright

augroup myvimrc
    au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

