set nocompatible              
set noswapfile
syntax enable
set background=dark
colorscheme desert
filetype off                 
set lazyredraw
set nottyfast
set nocursorline

"Plugin Section

set rtp+=~/.fzf
call plug#begin('~/.vim/plugged')

Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"Plug 'lervag/vimtex'
"Plug 'djoshea/vim-autoread'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'VundleVim/Vundle.vim'
Plug 'benmills/vimux'
"Plug 'terryma/vim-smooth-scroll'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'jalvesaq/Nvim-R'

call plug#end()

filetype plugin indent on    

set autoread
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

let g:UltiSnipsExpandTrigger = "<Nop>"
let g:UltiSnipsListSnippets = "<Nop>"


let g:livepreview_previewer = 'zathura'

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
            \ 'colorscheme': 'Tomorrow_Night',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'currentfunction': 'CocCurrentFunction'
            \ }
            \ }

let vimrplugin_assign = 0
let R_assign = 0
let R_esc_term = 1
let R_rconsole_width = winwidth(0) / 4
let R_objbr_w = winwidth(0) / 7

tnoremap <Esc> <C-W>N
tnoremap <Esc><Esc> <C-W>N
set timeout timeoutlen=1000  " Default
set ttimeout ttimeoutlen=100  " Set by defaults.vim
tnoremap <C-h> <C-W>:TmuxNavigateLeft<CR>
tnoremap <C-j> <C-W>:TmuxNavigateDown<CR>
tnoremap <C-k> <C-W>:TmuxNavigateUp<CR>
tnoremap <C-l> <C-W>:TmuxNavigateRight<CR>

let mapleader = ","
let localleader = "\\"

map <leader>ct :tabe<CR>
map <leader>t` :tabe<CR>`
map <leader>t' :tabe<CR>`

nnoremap <silent> <leader>dt :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

map <C-n> :NERDTreeToggle<CR>

map <Leader>f :Files<CR>
map <Leader>hf :Files ~<CR>
map <Leader>g :Rg<CR>
map <Leader>b :Buffers<CR>
map <Leader>l :Lines<CR>

map <Leader>vp :VimuxPromptCommand<CR>

imap <C-@> <C-Space>
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap <S-CR> O<Esc>
nmap ^[0M O<Esc>

nmap <CR> o<Esc>

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

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
        let l:currentWindow=winnr()
        :NERDTreeClose
        call StartR("R")
        while(string(g:SendCmdToR) != "function('SendCmdToR_Buffer')")
            sleep 1m
            redraw
        endwhile
        call RObjBrowser()
        while(string(g:SendCmdToR) != "function('SendCmdToR_Buffer')")
            sleep 1m
            redraw
        endwhile
        exe l:currentWindow . "wincmd w"
        call SendFileToR("silent") 
        let g:DoingRSetup = 0
    endif
endfunction

let g:RStylingFile=0
function! RStyleFile()
    if (g:RStylingFile == 0)
        let g:RStylingFile=1
        call system("Rscript ~/dotfiles/style_file.R " . @%)
        let g:RStylingFile=0
    endif
endfunction

autocmd FileType r :call RSetup()
autocmd FileType r map <buffer> <LocalLeader>sf :call RStyleFile()<CR>

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
let s:palette.normal.middle = [ [ 'NONE', 'NONE', '9', 'NONE' ] ]
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.tabline.middle = s:palette.normal.middle

set fillchars=stl:_,stlnc:_,vert:│,fold:۰,diff:·

highlight folded       cterm=bold ctermbg=none ctermfg=5
highlight vertsplit    cterm=none ctermbg=none ctermfg=9
highlight statusline   cterm=none ctermbg=none ctermfg=9
highlight statuslinenc cterm=none ctermbg=none ctermfg=9
highlight specialkey   cterm=none ctermbg=none ctermfg=1
highlight matchparen   cterm=none ctermbg=none ctermfg=5
highlight wildmenu     cterm=bold ctermbg=none ctermfg=3
highlight visual       cterm=bold ctermbg=7    ctermfg=none
highlight user1        cterm=none ctermbg=none ctermfg=3
highlight EndOfBuffer  ctermfg=8 ctermbg=none
highlight ColorColumn  ctermbg=8
highlight Terminal     ctermbg=None

autocmd FileType json syntax match Comment +\/\/.\+$+

let b:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'r': ['styler']
            \}

set tags=./tags;,tags;

let &colorcolumn="80,".join(range(120,999),",")

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

