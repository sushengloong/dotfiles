call plug#begin('~/.vim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'

" https://github.com/ryanoasis/vim-devicons/issues/198
" brew tap homebrew/cask-fonts
" brew install --cask font-hack-nerd-font
" And update iTerm2 setting to use the nerd font
Plug 'ryanoasis/vim-devicons'
call plug#end()

if filereadable(expand("~/.config/coc/extensions/node_modules/coc-metals/coc-mappings.vim"))
 source ~/.config/coc/extensions/node_modules/coc-metals/coc-mappings.vim
endif

" enable mouse support for all modes
set mouse=a

colors onedark
set termguicolors " enable devicons color

" Declare coc extensions (auto-install if missing)
let g:coc_global_extensions = ['coc-json', 'coc-metals']

" Toggle CHADTree
nnoremap <leader>v <cmd>CHADopen<cr>

" Configure fzf
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
nnoremap <C-p> :Files<cr>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Numbers
set number
set relativenumber

" Replace tabs with spaces
set expandtab

" Tabstops are 2 spaces
set tabstop=2
set shiftwidth=2

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Search
set ignorecase
set smartcase

" Shortcut for removing trailing white spaces
" nnoremap <leader>c :%s/\s\+$//e<cr>

" Clear search
nnoremap <leader><space> :noh<cr>

" mhinz/vim-grepper
nmap g/ :Grepper<Space>-highlight<Space>-query<Space>
nmap g* :Grepper<Space>-highlight<Space>-query<Space><C-R><C-W>

" Disable backup and swap file
set nobackup
set nowritebackup
set noswapfile

" Enable persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Detect and auto-reload file changes
set autoread
au CursorHold * checktime
