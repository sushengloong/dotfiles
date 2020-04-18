call plug#begin('~/.vim/plugged')
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'tpope/vim-sensible'
  Plug 'bling/vim-airline'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'easymotion/vim-easymotion'
  Plug 'mhinz/vim-signify'
  Plug 'dense-analysis/ale'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-grepper'
  Plug 'junegunn/vim-easy-align'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  " Language/framework-specific plugins
  Plug 'derekwyatt/vim-scala'
  Plug 'keith/swift.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" mhinz/vim-signify
let g:signify_sign_change = '~'

" dense-analysis/ale
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_linters = {
  \ 'javascript': ['eslint']
  \ }
let g:ale_javascript_eslint_executable='npx eslint'

" ludovicchabant/vim-gutentags
set statusline+=%{gutentags#statusline()}
" TODO: make this work with Ctrl-O/Ctrl-T
let g:gutentags_ctags_tagfile = '.tags'
" set tags=./tags;,tags;
" Save auto-generated tags files in ~/.cache/tags so not to pollute projects
let g:gutentags_cache_dir = expand('~/.cache/tags')

" neoclide/coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" neoclide/coc.nvim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" junegunn/fzf.vim
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
" Use ag to traverse filesystem while respecting ignored files (including those in .agignore)
" let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
map <leader>b :Buffers<cr>
map <leader>f :Files<cr>
map <leader>t :Tags<cr>

" mhinz/vim-grepper
nmap g/ :Grepper<Space>-highlight<Space>-query<Space>
nmap g* :Grepper<Space>-highlight<Space>-query<Space><C-R><C-W>

" junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Xuyuanp/nerdtree-git-plugin
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Custom NERDTree shortcuts
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :NERDTreeFind<CR>

let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None
set background=dark
set termguicolors

" Enable persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

" Detect and auto-reload file changes
set autoread
au CursorHold * checktime

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full

" Removes trailing spaces
command! StripTrailingSpaces %s/\s\+$//e
nnoremap <Leader>c :StripTrailingSpaces<CR>

" Can't be bothered to understand ESC vs <c-c> in insert mode
noremap <c-c> <esc>

" Clear search
nnoremap <leader><space> :noh<cr>

" Make equal or maximize current split window
nnoremap <C-w>m <C-w>\|<C-w>_

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Numbers
set number
set relativenumber

" Tabs and Spaces
set expandtab
set shiftround
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

" Disable backup
set nobackup
set nowritebackup
set noswapfile

set ttymouse=xterm2
" enable mouse support for all modes
set mouse=a

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
