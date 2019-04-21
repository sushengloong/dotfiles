" This is a simple vimrc which does not use any plugin and complicated vimscript.
" For more advanced vimrc, please see vimrc.advanced.

filetype plugin indent on
syntax enable

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab
set ruler
set wildmenu
set wildmode=longest:list,full
set history=1000
set hlsearch
set incsearch
set number

" Come on, this is vim.
set nobackup
set nowritebackup
set noswapfile
