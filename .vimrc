set nocompatible              
set noswapfile
syntax enable
set background=dark
colorscheme solarized
filetype off                 
set lazyredraw
set nottyfast
set nocursorline

"Plugin Section

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()

Plugin 'dense-analysis/ale'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'
Plugin 'altercation/vim-colors-solarized'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'jalvesaq/Nvim-R'
Plugin 'ycm-core/YouCompleteMe'

call vundle#end()            
filetype plugin indent on    

set wildmenu
set wildmode=longest,full
set noshowmode
set tabstop=4
set shiftwidth=4
set expandtab
set number
set undofile
set undodir=~/.vim/undodir
set t_Co=256
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'separator': { 'left': "\ue0b8", 'right': "\ue0ba" },
      \ 'subseparator': { 'left': "\ue0b9", 'right': "\ue0bb" }
      \ }

let vimrplugin_assign = 0
let R_assign = 0
let R_esc_term = 1
let R_rconsole_width = winwidth(0) / 4
let R_objbr_w = winwidth(0) / 7

let g:ycm_autoclose_preview_window_after_completion = 1

tnoremap <Esc> <C-W>N
tnoremap <Esc><Esc> <C-W>N
set timeout timeoutlen=1000  " Default
set ttimeout ttimeoutlen=100  " Set by defaults.vim
tnoremap <C-h> <C-W>:TmuxNavigateLeft<CR>
tnoremap <C-j> <C-W>:TmuxNavigateDown<CR>
tnoremap <C-k> <C-W>:TmuxNavigateUp<CR>
tnoremap <C-l> <C-W>:TmuxNavigateRight<CR>

map <Leader>f :Files<CR>
map <Leader>hf :Files ~<CR>
map <Leader>b :Buffers<CR>
map <Leader>l :Lines<CR>

let mapleader = ","
let localleader = "\\"

let ycm_semantic_triggers = { 'r' : ['re!..', '::', '$', '@'] }

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

map <C-n> :NERDTreeToggle<CR>

map <Leader>vp :VimuxPromptCommand<CR>

set splitbelow
set splitright

augroup myvimrc
    au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc nested so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

let g:DoingRSetup=0
function! RSetup()
    if (g:DoingRSetup == 0 && string(g:SendCmdToR) == "function('SendCmdToR_fake')")
        let g:DoingRSetup = 1
        :NERDTreeClose
        call StartR("R")
        sleep 2000m
        call RObjBrowser()
        call SendFileToR("silent") 
        let g:DoingRSetup = 0
    endif
endfunction

autocmd FileType r :call RSetup()

set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set previewheight=7
au BufEnter ?* call PreviewHeightWorkAround()
func! PreviewHeightWorkAround()
    if &previewwindow
        exec 'setlocal winheight='.&previewheight
    endif
endfunc

let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

set fillchars=stl:_,stlnc:_,vert:│,fold:۰,diff:·

highlight folded       cterm=bold ctermbg=none ctermfg=5
highlight vertsplit    cterm=none ctermbg=none ctermfg=9
highlight specialkey   cterm=none ctermbg=none ctermfg=1
highlight matchparen   cterm=none ctermbg=none ctermfg=5
highlight wildmenu     cterm=bold ctermbg=none ctermfg=3
highlight visual       cterm=bold ctermbg=7    ctermfg=none
highlight user1        cterm=none ctermbg=none ctermfg=3
highlight EndOfBuffer  ctermfg=8 ctermbg=none
