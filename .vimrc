set nocompatible
filetype off

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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tikhomirov/vim-glsl'

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
filetype plugin indent on
set tabstop=3
set softtabstop=0
set expandtab
set shiftwidth=3
set smarttab
set pastetoggle=<F2>
set ignorecase
set smartcase
set history=100
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

" http://stackoverflow.com/questions/19936145
fun! StripTrailingWhiteSpace()
   " don't strip on these filetypes
   if &ft =~ 'markdown'
      return
   endif
   %s/\s\+$//e
endfun

augroup vimrc
   " Automatically delete trailing DOS-returns and whitespace on file open and
   " write.
   autocmd BufRead,BufWritePre,FileWritePre * silent :call StripTrailingWhiteSpace()
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

" undo all changes made to a file since opening it
map <silent> U :silent :u1<bar>u<CR>

" copy in visual mode keeps your cursor in the same place
vnoremap y ygv<ESC>

" "_d is used to delete something to the blackhole register
" (in my case, this simply means don't copy it to the clipboard)
" nnoremap r "_d
" vnoremap r "_d

" for moving between buffers
nnoremap > :bn<CR>
nnoremap < :bp<CR>

" retab entire file
map <F3> mzgg=G<bar>:retab<CR>`z

"https://www.youtube.com/watch?v=xew7CMkL7jY
ab shb #!/usr/bin/env bash

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

set rtp+=/Users/Stewart/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

set laststatus=2
set showtabline=2
" allows switching buffers without writing the current buffer
set hidden

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
" Don’t show the intro message when starting Vim
set shortmess=atI
" Use relative line numbers
if exists("&relativenumber")
   set relativenumber
   au BufReadPost * set relativenumber
endif
" Start scrolling two lines before the horizontal window border
set scrolloff=2

" Automatic commands
if has("autocmd")
   " Treat .json files as .js
   autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
   " Treat .md files as Markdown
   autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


" github.com/josepharhar/dotfiles/blob/master/vimrc

" wildmenu
set wildchar=<Tab>
"set wildmode=full " :help wildmode
"set wildmode=longest:full
set wildmode=longest:full,full
set wildignore+=*.class,*.swp,*/build/*,*/target/*,*.o,*/node_modules/*,*/deps/*

" alt keybindings to switch between windows
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-m> :wincmd q<CR>
" ycm
nnoremap <C-i> :YcmCompleter GoTo<CR>

" Standard vim options
set autoindent            " always set autoindenting on
set cindent               " c code indenting
set diffopt=filler,iwhite " keep files synced and ignore whitespace
set guioptions-=m         " Remove menu from the gui
set guioptions-=T         " Remove toolbar
set linebreak             " This displays long lines as wrapped at word boundries
set ruler                 " the ruler on the bottom is useful
set showcmd               " Show (partial) command in status line.
set showmatch             " Show matching brackets.
set virtualedit=block     " let blocks be in virutal edit mode
