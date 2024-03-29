call plug#begin('~/.vim/plugged')
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'bling/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'

" Language-specific
Plug 'LnL7/vim-nix'

" https://github.com/ryanoasis/vim-devicons/issues/198
" brew tap homebrew/cask-fonts
" brew install --cask font-hack-nerd-font
" And update iTerm2 setting to use the nerd font
Plug 'ryanoasis/vim-devicons'
call plug#end()

if filereadable(expand("~/.config/nvim/coc-mappings.vim"))
 source ~/.config/nvim/coc-mappings.vim
endif

" enable mouse support for all modes
set mouse=a

syntax on
set t_Co=256
set cursorline
colorscheme onehalfdark
let g:airline_theme='onehalfdark'

" Declare coc extensions (auto-install if missing)
let g:coc_global_extensions = ['coc-json', 'coc-metals', 'coc-pairs']

" Toggle CHADTree
nnoremap <F2> <cmd>CHADopen<cr>

" Configure fzf
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
" To have syntax highlighting in preview do: brew install bat
nnoremap <C-p> :Files<cr>
nnoremap <leader>b :Buffers<cr>
" Exclude file names from Rg results
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap g/ :Rg<CR>
nnoremap g* :Rg <C-R><C-W><CR>

" Use surround.vim keybinding for sandwich
runtime macros/sandwich/keymap/surround.vim

" Modified from https://stackoverflow.com/a/17096082
" relative path  (src/foo.txt)
nnoremap <leader>cp :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cP :let @*=expand("%:p")<CR>
" Shortcut for removing trailing white spaces
nnoremap <leader>cs :%s/\s\+$//e<cr>

" Clear search
nnoremap <leader><space> :noh<cr>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" During insert, escapes (`^ is so that the cursor doesn't move),
" clears highlighting and saves
inoremap jj <Esc>`^:noh<CR>:w<CR>

" Set title in terminal tab and window
set title

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

" View authors with Fugitive
nnoremap <Leader>gb :Git blame<CR>
" View code in web browser with Fugitive
nnoremap <Leader>go :.GBrowse<CR>
" Yank Git link with Fugitive
nnoremap <Leader>gy :.GBrowse!<CR>
xnoremap <Leader>gy :'<'>GBrowse!<CR>
