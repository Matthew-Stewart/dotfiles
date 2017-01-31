set nocompatible
filetype plugin indent on

" set the runtime path to include Vundle and initialize
" run :PluginInstall for first time setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" not sure how many of these I actually use
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Bundle 'mbadran/headlights'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
"Plugin 'Shougo/vimproc.vim'  " installed manually
Plugin 'Shougo/unite.vim'
Plugin 'm2mdas/phpcomplete-extended'
Bundle 'kien/rainbow_parentheses.vim'

call vundle#end()            " required

let g:rbpt_colorpairs = [
         \ [ '13', '#6c71c4'],
         \ [ '5',  '#d33682'],
         \ [ '1',  '#dc322f'],
         \ [ '9',  '#cb4b16'],
         \ [ '3',  '#b58900'],
         \ [ '2',  '#859900'],
         \ [ '6',  '#2aa198'],
         \ [ '4',  '#268bd2'],
         \ ]
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_semantic_triggers =  {
         \   'html' : ['<', '.', '#'],
         \   'lisp,clojure,clj,racket,rkt' : ['('],
         \   'css' : [':', '   ']
         \ }

let g:Powerline_symbols = 'fancy'
set guifont=Inconsolata\ for\ Powerline:h15

set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

syntax enable
syntax on
set tabstop=3
set softtabstop=0
set expandtab
set shiftwidth=3
set smarttab
set pastetoggle=<F2>
set ignorecase
set history=1000
set mouse=i
set mouse+=a
set hlsearch
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

" Sublime Monokai color scheme"
let g:molokai_original = 1
colorscheme molokai

" line numbers
set nu

" autocmd BufNewFile,BufRead *.py_tmpl,*.py setlocal ft=python
autocmd BufNewFile,BufRead *.rkt,*.rktl setlocal ft=racket
autocmd FileType ruby colorscheme railcasts

augroup MyAutoCmd
   autocmd FileType css,less setlocal omnifunc=csscomplete#CompleteCSS
   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
   autocmd FileType ejs,jst setlocal omnifunc=htmlcomplete#CompleteTags
   autocmd FileType javascript setlocal omnifunc=tern#Complete
   " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
   autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
   autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
   autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
augroup END

set ttimeoutlen=10
augroup FastEscape
   autocmd!
   au InsertEnter * set timeoutlen=150
   au InsertLeave * set timeoutlen=1000
augroup END

" from https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
" turns off all error bells, visual or otherwise
set noerrorbells visualbell t_vb=

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#,-

augroup vimrc
   " Automatically delete trailing DOS-returns and whitespace on file open and
   " write.
   autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

" Highlight Class and Function names
function! s:HighlightFunctionsAndClasses()
   syn match cCustomFunc      "\w\+\s*\((\)\@="
   syn match cCustomClass     "\w\+\s*\(::\)\@="

   hi def link cCustomFunc      Function
   hi def link cCustomClass     Function
endfunction

set wildignore+=*.o,*.obj,.git,*.pyc,*.so,blaze*,READONLY,llvm,Library*
set wildignore+=CMakeFiles,packages/*,**/packages/*,**/node_modules/*

set clipboard+=unnamed

vnoremap <C-c> "+y
vmap <C-x> "+c
vmap <D-v> c<ESC>"+p
imap <D-v> <ESC>"+pa
vnoremap <D-C> "+y

nnoremap r "_d
vnoremap r "_d

map <F3> mzgg=G<CR>:retab<CR>`z<CR>

"https://www.youtube.com/watch?v=xew7CMkL7jY
ab shb #!/usr/bin/env bash

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set rtp+=/Users/Stewart/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim
" source /Users/Stewart/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim/plugin/powerline.vim
set laststatus=2

" github.com/mathiasbynens/dotfiles/blob/master/.vimrc

" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
   set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,nbsp:_
set list
" Highlight dynamically as pattern is typed
set incsearch
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Use relative line numbers
if exists("&relativenumber")
   set relativenumber
   au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Automatic commands
if has("autocmd")
   " Enable file type detection
   filetype on
   " Treat .json files as .js
   autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
   " Treat .md files as Markdown
   autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
