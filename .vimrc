" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"Windows Compatible ------------------------------------ {{{
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
    set runtimepath=$HOME\.vim,$VIM\vimfiles,$VIMRUNTIME,$VIM\vimfiles\after,$HOME\.vim\after
    "let Tlist_Ctags_Cmd=$HOME.'\ctags\ctags.exe'
    let g:tagbar_ctags_bin=$HOME.'\ctags\ctags.exe'
endif
" }}}

"Pathogen setup ------------------------------------------{{{

" Disable Pathogen plugins{{{
" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'buftabs')
call add(g:pathogen_disabled, 'bclose')
call add(g:pathogen_disabled, 'command-t')

"}}}

"add pathogen for easier bundles management
filetype off
runtime! autoload/pathogen.vim 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

"}}}
  
"Basic options ------------------------------------------{{{

"use system clipboard
set clipboard=unnamed

" remap 'jj' in insert mode to <ESC> for quicker escape
inoremap jj <ESC>

"keep undo, swap, backup history files , see the InitializeDirectories()
"function at the end of the file for directory setup. 
set history=1000
set undofile
set undoreload=1000
set backup		" keep a backup file
set noswapfile                    " It's 2012, Vim.
set modelines=0
set background=light     " Assume a dark background
if has('unix') && !has('mac')
    set t_Co=256 "enable 256 colors"
endif
colorscheme jellybeans

set encoding=utf-8 "encoding to utf-8
set fileencoding=utf-8 "set encoding when opening files to utf-8
set ch=2		" Make command line two lines high
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12,DejaVu\ Sans\ Mono:h12,Menlo\ Regular\ for\ Powerline:h12,Monaco:h13 "use DejaVu Sans Mono for english on win/liunux, Monaco for mac
set guifontwide=SimHei:h11,Monaco:h13 "use SimHei for Chinese, Monaco for mac
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Remove all the UI cruft
set go-=T
set go-=l
set go-=L
set go-=r
set go-=R
let mapleader = "," "map , as <leader> key instead of \ by default
"set autochdir		"auto change dir to where the current file is. 
set hidden 		"switching buffers without saving
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
"set showmode		" display current mode
set wildmenu		" show enhanced completion 
set wildmode=list:longest "together with wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib
set visualbell		"flash screen when bell rings
set cursorline		"highline cursor line
set ttyfast		"indicate faster terminal connection
set laststatus=2	"always show status line
set cpoptions+=J
set nu			" show line number
set lbr			" break the line by words
set scrolloff=3		" show at least 3 lines around the current cursor position
set completeopt=longest,menu "set on the fly completion
set mouse=a
syntax on "set syntax color on
set lazyredraw
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set splitbelow
set splitright
set fillchars=diff:⣿
set autoread

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*" 

" Resize splits when the window is resized
au VimResized * :wincmd =

" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

"disable tabs
set nowrap                     	" wrap long lines
set autoindent                 	" indent at the same level of the previous line
set expandtab
set shiftwidth=4
set softtabstop=4

"space toggle folds!"
nnoremap <space> za
"use sane regx"
set gdefault					" the /g flag on :s substitutions by default
nnoremap / /\v
vnoremap / /\v

"search with ease
set gdefault "all matches in a line a subsituted instead of one.
set showmatch					" show matching brackets/parenthesis
set incsearch					" find as you type search
set hlsearch					" highlight search terms
set magic
set ignorecase					" case insensitive search
set smartcase					" case sensitive when uc present

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

set wildignore+=*.pyc,.hg,.git
set matchtime=3 "Tenths of a second to show a matching pattern
set showbreak=↪ " show break when the line is wraped.

"switch between windows with leader key 
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

"navigate between tabs and buffers
nnoremap <leader>bn :bnext<cr>
nnoremap <leader>bp :bprev<cr>
nnoremap tn :tabnext<cr>
nnoremap tp :tabprev<cr>
nnoremap tt :tabnew<cr>

"""""Plugins"""""""""""
"------------Session---------------
let g:session_directory=$HOME.'/.vim/tmp/session'
let g:session_autoload='yes'
let g:session_autosave='yes'

"------ NerdTree --------------
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=2     "setting root dir in NT also sets VIM's cd
    let NERDTreeQuitOnOpen=1 "the Nerdtree window will be close after a file is opend.
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1


"------  Tagbar Options  ------
" http://adamyoung.net/Exuberant-Ctags-OS-X
" http://www.vim.org/scripts/script.php?script_id=273
" let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_width=26
noremap <silent> <Leader>y :TagbarToggle<CR>


"------  Buffers  ------
" Ctrl Left & Right move between buffers
" (need to find out how to disable this within nerdtree buffer)
noremap <silent> <C-left> :bprev<CR>
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-right> :bnext<CR>
noremap <silent> <C-l> :bnext<CR>
" Closes the current buffer
nnoremap <silent> <Leader>q :Bclose<CR>
" Closes the current window
nnoremap <silent> <Leader>Q <C-w>c

"------  Fugitive  ------ 
"https://github.com/tpope/vim-fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gr :Gremove<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gm :Gmove 
nnoremap <Leader>gp :Ggrep 
nnoremap <Leader>gR :Gread<CR>
nnoremap <Leader>gg :Git 
nnoremap <Leader>gd :Gdiff<CR>

"------- Supertab -----

let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"



" Folding ----------------------------------------------------------------- {{{

set foldlevelstart=0

" Make the current location sane.
nnoremap <c-cr> zvzt

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}


" Powerline {{{

let Powerline_symbols = 'compatible'
let g:Powerline_symbols = 'fancy'

" }}}
"""""Functions""""""""""""""""""""""""""""""""""""""""""""

" create tmp folder and the subfolders if they don't exist.
function! InitializeDirectories()
  let separator = "."
  let parent = $HOME 
  let prefix = '.vim/tmp/'
  if !isdirectory(parent.'/'.prefix)
      call mkdir(parent.'/'.prefix)
  endif

  let dir_list = { 
			  \ 'backup': 'backupdir', 
			  \ 'views': 'viewdir', 
	                  \ 'undo' : 'undodir',
			  \ 'swap': 'directory' }

  for [dirname, settingname] in items(dir_list)
	  let directory = parent . '/' . prefix . dirname . "/"
	  if exists("*mkdir")
		  if !isdirectory(directory)
			  call mkdir(directory)
		  endif
	  endif
	  if !isdirectory(directory)
		  echo "Warning: Unable to create backup directory: " . directory
		  echo "Try: mkdir -p " . directory
	  else  
          let directory = substitute(directory, " ", "\\\\ ", "")
          exec "set " . settingname . "=" . directory."/"
	  endif
  endfor
  "add session folder if it doesn't exist
  if !isdirectory(parent.'/'.prefix.'session/')
      call mkdir(parent.'/'.prefix.'session/')
  endif
endfunction
call InitializeDirectories() 
"""""""""""""""""""""""""""""""""""""""""""""""""""
