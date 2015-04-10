set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Bundle 'kien/ctrlp.vim'
" EasyMotion
Plugin 'EasyMotion'
" Buffer explorer
Plugin 'bufexplorer.zip'
" Most recently used buffer
Plugin 'bufmru.vim'
" Change surrounding characters
Plugin 'surround.vim'
" Text alignment
Plugin 'Tabular'
" Code snipets
Plugin 'snipMate'
" Fast code commenting
Plugin 'The-NERD-Commenter'
" Project folder
Plugin 'The-NERD-tree'
" Stylus
Plugin 'vim-stylus'
" list functions
Plugin 'functionlist.vim'
" JSHint
Plugin 'walm/jshint.vim.git'
" DeleteTrailingWhitespace
Plugin 'vim-scripts/DeleteTrailingWhitespace.git'
" Lightline status bar
"Plugin 'itchyny/lightline.vim'
" Git Gutter
Plugin 'airblade/vim-gitgutter'
" Airline status bar
Plugin 'bling/vim-airline'
" Trailing Whitespace
Plugin 'bronson/vim-trailing-whitespace'
" Autoclose
Plugin 'Townk/vim-autoclose'

" -------- Syntax Coloring and indents -------

" Javascript text hilighting
Plugin 'pangloss/vim-javascript.git'
" Cucumber
Plugin 'cucumber.zip'
" Jade
Plugin 'digitaltoad/vim-jade.git'
" SnipMate
Plugin 'garbas/vim-snipmate'
Bundle 'jelera/vim-javascript-syntax'
" Indent Guides
Bundle 'nathanaelkane/vim-indent-guides'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set ar
set expandtab
set hid
set hlsearch
set incsearch
set nobackup
set noswapfile
set nu
set shiftwidth=2
set tabstop=2
set softtabstop=2
set wildignore+=.git,.svn,**/node_modules/*,DS_Store,*.log,*.sock
set wildignore+=*.png,*.gif,*.jpg,*.jpeg,*.class,nohup.out,*.swp
set wildignore+=*.tmproj,*.pid,**/tmp/*
set wildmenu
set wildmode=list:longest,full
set wrap

" functions

" Align Fit Tables
function! s:alignFitTables()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
command! -nargs=0 AlignFitTables call s:alignFitTables()

function! s:SetTestFile()
  let g:CurrentTestFile = expand("%")
  let g:CurrentTestExt  = expand("%:e")
endfunction
command! -nargs=0 SetTestFile call s:SetTestFile()

function! s:RunTestFile()
  :w
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo

  if !exists("g:CurrentTestFile")
    let g:CurrentTestFile = expand("%")
    let g:CurrentTestExt  = expand("%:e")
  endif

  if g:CurrentTestExt == "js"
    execute "w\|!TEST=true NODE_ENV=test ./node_modules/.bin/mocha --reporter spec 
      \ " . g:CurrentTestFile 
  elseif g:CurrentTestExt == "clj"
    execute "w\|!echo \"I can't do this yet\""
  endif
endfunction
command! -nargs=0 RunTestFile call s:RunTestFile()

let mapleader = ","
let maplocalleader = ","

cnoremap %% <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vimrc<cr>
map <Leader>h :set invhls<CR>
noremap <Leader>i :set list!<CR>
imap jj <c-c>
nmap k gk
nmap j gj
"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>
map <Leader>r :RunTestFile<CR>
map <Leader>sv :so ~/.vimrc<CR>
map <Leader>; :SetTestFile<CR>
noremap <Leader>at :AlignFitTables<CR>
noremap <Leader>n :NERDTreeToggle<CR>

" bufexplorer
let g:bufExplorerDefaultHelp=1
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowRelativePath=1

" ctrlp stuff
nnoremap <leader>ga :CtrlP<CR>
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>
nnoremap <leader>t :CtrlPTag<CR>

set t_Co=256
syntax on
set background=dark

" Gui Setup *******************************************************************
if has("gui_running")
  if has("gui_gnome")
    set term=gnome-256color
    set guifont=Inconsolata\ 16
    set guioptions-=T
    set guioptions-=m
    set guioptions+=c
    set guioptions-=rL
    set lines=100
    set columns=185
  else
    set guitablabel=%M%t
    set lines=100
    set columns=185
  endif

  if has("gui_mac") || has("gui_macvim")
    set guifont=Inconsolata:h22
    set fuoptions=maxvert,maxhorz
    set guioptions-=T
    set guioptions-=m
    set guioptions+=c
    set guioptions-=rL
    " set colorcolumn=81
    colorscheme jellybeans 
  endif
endif

if !has('gui_running')
  set t_Co=256
endif


" NERDTree ********************************************************************

" User instead of Netrw when doing an edit /foobar
let NERDTreeHijackNetrw=1

" Single click for everything
let NERDTreeMouseMode=1

" Ignore
let NERDTreeIgnore=['\.git','\.DS_Store','\.pdf','\.png','\.jpg','\.gif']

" Quit on open
let NERDTreeQuitOnOpen=1

" Airline tabline stuff
let g:airline#extensions#tabline#enabled = 1

