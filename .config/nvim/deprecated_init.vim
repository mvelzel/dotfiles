set nocompatible
set noswapfile
syntax enable
set background=dark
filetype off                 
set lazyredraw
set nocursorline
set clipboard=unnamed

"Plugin Section

set rtp+=~/.fzf

call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'misaka18931/vim-afterglow-ramastered'
Plug 'jparise/vim-graphql'
Plug 'posva/vim-vue'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
"Plug 'leafgarland/typescript-vim'
"
"Plug 'peitalin/vim-jsx-typescript'
"Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
"Plug 'djoshea/vim-autoread'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'dense-analysis/ale'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'benmills/vimux'
"Plug 'terryma/vim-smooth-scroll'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'jalvesaq/Nvim-R'
Plug 'tveskag/nvim-blame-line'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-sleuth'

call plug#end()

filetype plugin indent on
colorscheme afterglow

set autoread
set wildmenu
set wildmode=longest,full
set noshowmode
set tabstop=2
set shiftwidth=0
set expandtab
set number
set undofile
set undodir=~/.config/nvim/undodir
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

tnoremap <Esc><Esc> <C-\><C-N>
set timeout timeoutlen=1000  " Default
set ttimeout ttimeoutlen=100  " Set by defaults.vim
tnoremap <C-h> <C-\><C-N>:TmuxNavigateLeft<CR>
tnoremap <C-j> <C-\><C-N>:TmuxNavigateDown<CR>
tnoremap <C-k> <C-\><C-N>:TmuxNavigateUp<CR>
tnoremap <C-l> <C-\><C-N>:TmuxNavigateRight<CR>

let mapleader = ","
let localleader = "\\"

map <leader>ct :tabe<CR>
map <leader>t` :tabe<CR>`
map <leader>t' :tabe<CR>`

map <leader>z :ToggleBlameLine<CR>

map <leader>sf :call CocActionAsync('format')<CR>

nnoremap <silent> <leader>dt :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

map <Leader>f :Files<CR>

map <Leader>hf :Files ~<CR>
map <Leader>g :Rg<CR>
map <Leader>b :Buffers<CR>
map <Leader>l :Lines<CR>

nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

map <Leader>vp :VimuxPromptCommand<CR>

imap <C-@> <C-Space>
inoremap <silent><expr> <c-space> coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

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
highlight Terminal     ctermbg=none

let &colorcolumn="80,".join(range(120,9999),",")

" Dim inactive windows using 'colorcolumn' setting
" This tends to slow down redrawing, but is very useful.
" Based on https://groups.google.com/d/msg/vim_use/IJU-Vk-QLJE/xz4hjPjCRBUJ
" XXX: this will only work with lines containing text (i.e. not '~')
function! s:DimInactiveWindows()
  for i in range(1, tabpagewinnr(tabpagenr(), '$'))
    let l:range = "80,".join(range(120,9999),",")
    if i != winnr()
      let l:range = ""
    endif
    call setwinvar(i, '&colorcolumn', l:range)
  endfor
endfunction
augroup DimInactiveWindows
  au!
  au WinEnter * call s:DimInactiveWindows()
  au WinEnter * set cursorline
  au WinLeave * set nocursorline
augroup END

autocmd FileType json syntax match Comment +\/\/.\+$+

let b:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'r': ['styler']
            \}

set tags=./tags;,tags;

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:livepreview_engine = 'xelatex'

let g:netrw_ftp_cmd="ftp -p"

fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()

" returns true iff is NERDTree open/active
function! IsNTOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! OpenTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    if IsNTOpen()
      :NERDTreeClose
    else
      :NERDTreeFind
    endif
  else
    :NERDTreeToggle
  endif
endfunction

map <C-n> :call OpenTree()<CR>

