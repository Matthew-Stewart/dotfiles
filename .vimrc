set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
" run :PluginInstall for first time setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" git commands in vim
Plugin 'tpope/vim-fugitive'
" visual directory tree
Plugin 'scrooloose/nerdtree'
" auto complete
Plugin 'Valloric/YouCompleteMe'
" javascript auto complete
Plugin 'marijnh/tern_for_vim'
" kotlin syntax highlighting
Plugin 'udalov/kotlin-vim'
" required for phpcomplete
Plugin 'Shougo/vimproc.vim'
" php auto complete
Plugin 'm2mdas/phpcomplete-extended'
" lisp parenthesis coloring
Bundle 'kien/rainbow_parentheses.vim'
" ctrl p to open files
Plugin 'ctrlpvim/ctrlp.vim'
" glsl syntax highlighting
Plugin 'tikhomirov/vim-glsl'

call vundle#end()            " required

let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_semantic_triggers =  {
         \   'html' : ['<', '.', '#'],
         \   'lisp,clojure,clj,racket,rkt' : ['('],
         \   'css' : [':', '   ']
         \ }

let g:Powerline_symbols = 'fancy'

"fira code works by default in terminal.app, but ill leave these lines here
"in case I need them in the future
"set macligatures
"set guifont=Fira\ Code:h17

set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

syntax enable
filetype plugin indent on
set expandtab
set tabstop=3
set softtabstop=0
set shiftwidth=3
set smarttab
set pastetoggle=<F2>
set ignorecase
set smartcase
set history=100
set mouse=a
set hlsearch
set colorcolumn=80
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Sublime Monokai color scheme"
let g:molokai_original = 1
colorscheme molokai

" line numbers
set nu

" turn off smart indent for conf files (#'s get floated all the way left)
au! FileType conf setl nosmartindent
au! FileType conf setl nocindent

autocmd BufNewFile,BufRead *.rkt,*.rktl setlocal ft=lisp

augroup MyAutoCmd
   autocmd FileType css,less setlocal omnifunc=csscomplete#CompleteCSS
   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
   autocmd FileType ejs,jst setlocal omnifunc=htmlcomplete#CompleteTags
   autocmd FileType javascript setlocal omnifunc=tern#Complete
   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
   autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
   autocmd FileType java setlocal omnifunc=eclim#java#complete#CodeComplete
   autocmd FileType php setlocal omnifunc=phpcomplete_extended#CompletePHP
augroup END

fun! CloseBuffer(cmd, write)
   let numBuffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
   if numBuffers == 1
      execute a:cmd
   elseif a:write == 1
      :w
      :bd
   else
      :bd
   endif
endfunc

" map quit commands to only close current buffer
cnoreabbrev <silent> q :call CloseBuffer("q", 0)<CR>
cnoreabbrev <silent> wq :call CloseBuffer("wq", 1)<CR>
cnoreabbrev <silent> x :call CloseBuffer("x", 1)<CR>

" ive never legitimately used the q command, so map it to quit
nmap <silent> q :q<CR>

" Clear highlighting on escape in normal mode
" https://stackoverflow.com/a/1037182
nnoremap <ESC> :noh<CR><ESC>
nnoremap <ESC>^[ <ESC>^[
set ttimeoutlen=10
set timeoutlen=10

" http://vim.wikia.com/wiki/Make_search_results_appear_in_the_middle_of_the_screen
:nnoremap n nzz
:nnoremap N Nzz
:nnoremap * *zz
:nnoremap # #zz
:nnoremap g* g*zz
:nnoremap g# g#zz

" from https://github.com/Valloric/dotfiles/blob/master/vim/vimrc.vim
" turns off all error bells, visual or otherwise
set noerrorbells visualbell t_vb=

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#,-

" http://stackoverflow.com/questions/19936145
fun! StripTrailingWhiteSpace()
   " don't strip on these filetypes
   if &ft =~ 'markdown' || &ft =~ 'diff'
      return
   endif
   %s/\s\+$//e
endfun

augroup vimrc
   " Automatically delete trailing DOS-returns and whitespace on file open and
   " write.
   autocmd BufRead,BufWritePre,FileWritePre * silent :call StripTrailingWhiteSpace()
augroup END

" use tabs in make files
autocmd FileType make setlocal noexpandtab

" Highlight Class and Function names
function! s:HighlightFunctionsAndClasses()
   syn match cCustomFunc      "\w\+\s*\((\)\@="
   syn match cCustomClass     "\w\+\s*\(::\)\@="

   hi def link cCustomFunc      Function
   hi def link cCustomClass     Function
endfunction

set wildignore+=*.o,*.obj,.git,*.pyc,*.so,blaze*,READONLY,llvm,Library*
set wildignore+=CMakeFiles,packages/*,**/packages/*,**/node_modules/*
set wildignore+=*.class,*.swp,*/build/*,*/target/*,*/deps/*

" yank copys to mac clipboard
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

" always paste on the next line
nnoremap p :put<CR>

" for moving between buffers
nnoremap > :bn<CR>
nnoremap < :bp<CR>

" retab entire file
map <F3> mzgg=G<bar>:retab<CR>`z

" https://www.youtube.com/watch?v=xew7CMkL7jY
ab shb #!/usr/bin/env bash

" powerline setup
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set rtp+=~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

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
