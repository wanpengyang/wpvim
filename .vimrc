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
