" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

  "add pathogen for easier bundles management
  filetype off
  call pathogen#runtime_append_all_bundles()
  call pathogen#helptags()
  filetype plugin indent on

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

"set basic environment
set modelines=0
set background=dark     " Assume a dark background
colorscheme jellybeans
set encoding=utf-8 "encoding to utf-8
set fileencoding=utf-8 "set encoding when opening files to utf-8
set ch=2		" Make command line two lines high
set guifont=DejaVu\ Sans\ Mono:h12,Monaco:h13 "use DejaVu Sans Mono for english on win/liunux, Monaco for mac
set guifontwide=SimHei:h11,Monaco:h13 "use SimHei for Chinese, Monaco for mac
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set guioptions=r "Only Right-hand scrollbar is always present.
let mapleader = "," "map , as <leader> key instead of \ by default
set autochdir		"auto change dir to where the current file is
set hidden 		"switching buffers without saving
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set showmode		" display current mode
set wildmenu		" show enhanced completion 
set wildmode=list:longest "together with wildmenu
set visualbell		"flash screen when bell rings
set cursorline		"highline cursor line
set ttyfast		"indicate faster terminal connection
set laststatus=2	"always show status line
set incsearch		" do incremental searching
set nu			" show line number
set showmatch		" show matching bracket for a while.
set lbr			" break the line by words
set scrolloff=3		" show at least 3 lines around the current cursor position
set completeopt=longest,menu "set on the fly completion
set mouse=a
set list
set listchars=tab:▸\ ,eol:¬
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)

"disable tabs
set expandtab
set shiftwidth=4
set softtabstop=4
" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier. 
if has('win32') || has('win64')
	set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

"space toggle folds!"
nnoremap <space> za
"use sane regx"
nnoremap / /\v
vnoremap / /\v

"search with ease
set smartcase
set gdefault "all matches in a line a subsituted instead of one.
set hlsearch
set magic

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>


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
"""""""""""""""""""""""""""""""""""""""""""""""""
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
          exec "set " . settingname . "=" . directory
	  endif
  endfor
endfunction
call InitializeDirectories() 
"""""""""""""""""""""""""""""""""""""""""""""""""""

"automatically apply the chages in vimrc to vim without restart
autocmd! bufwritepost .vimrc source %
