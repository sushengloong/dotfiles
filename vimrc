call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-sensible'
  Plug 'bling/vim-airline'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'easymotion/vim-easymotion'
  Plug 'derekwyatt/vim-scala'
  Plug 'keith/swift.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'mattn/vim-nyancat'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Use ag to traverse filesystem while respecting ignored files
  " let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
  map <leader>b :Buffers<cr>
  map <leader>t :Files<cr>

  Plug 'mhinz/vim-grepper'
  nmap g/ :Grepper<Space>-highlight<Space>-query<Space>
  nmap g* :Grepper<Space>-highlight<Space>-query<Space><C-R><C-W>

  Plug 'junegunn/vim-easy-align'
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap ga <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap ga <Plug>(EasyAlign)

  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let NERDTreeShowHidden=1
  let NERDTreeIgnore = ['\.pyc$']
  " Open NERDTree automatically and then focus on the main window
  " when vim starts up if no files were specified
  function OpenNERDTree()
    NERDTree
    wincmd p
  endfunction
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | call OpenNERDTree() | endif
  " Close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Custom NERDTree shortcuts
  noremap <F2> :NERDTreeToggle<CR>
  noremap <F3> :NERDTreeFind<CR>

call plug#end()

set background=dark

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
