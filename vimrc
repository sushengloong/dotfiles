call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-sensible'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'bling/vim-airline'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-repeat'
  Plug 'scrooloose/syntastic'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'easymotion/vim-easymotion'
  Plug 'kchmck/vim-coffee-script'
  Plug 'digitaltoad/vim-pug'
  Plug 'pearofducks/ansible-vim'
  Plug 'keith/swift.vim'
  Plug 'altercation/vim-colors-solarized'
  Plug 'pangloss/vim-javascript'
  Plug 'moll/vim-node'
  Plug 'fatih/vim-go'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " Use ag to traverse filesystem while respecting ignored files
  let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
  imap <c-x><c-o> <plug>(fzf-complete-line)
  map <leader>b :Buffers<cr>
  map <leader>f :Files<cr>
  map <leader>g :GFiles<cr>
  map <leader>t :Tags<cr>

  Plug 'mhinz/vim-grepper'
  nmap g/ :Grepper<Space>-highlight<Space>-query<Space>
  nmap g* :Grepper<Space>-highlight<Space>-query<Space><C-R><C-W>

  Plug 'mxw/vim-jsx'
  " " Enable JSX in .js files
  " let g:jsx_ext_required = 0

  Plug 'tpope/vim-rails'
  " Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
  let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

  Plug 'thoughtbot/vim-rspec'
  " Commented out as conflict with fzf mapping
  " map <Leader>t :call RunCurrentSpecFile()<CR>
  " map <Leader>s :call RunNearestSpec()<CR>
  " map <Leader>l :call RunLastSpec()<CR>
  " map <Leader>a :call RunAllSpecs()<CR>

  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let NERDTreeShowHidden=1
  let NERDTreeIgnore = ['\.pyc$']
  nnoremap <Leader>n :NERDTreeToggle<CR>

  Plug 'Valloric/YouCompleteMe'

  Plug 'jsfaint/gen_tags.vim'
  " Disable gtags support - use ctags only instead
  let g:loaded_gentags#gtags = 1
  let g:gen_tags#ctags_auto_gen = 1
  let g:gen_tags#verbose = 1
  nnoremap <Leader>rt :GenCtags<CR>
call plug#end()

set background=dark
colorscheme solarized

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
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

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
autocmd filetype ruby setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype eruby setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype yaml setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype html setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype gohtmltmpl setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype css setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype scss setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype javascript setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype coffee setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype pug setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype json setlocal expandtab shiftround shiftwidth=2 tabstop=2 softtabstop=2
autocmd filetype java setlocal expandtab shiftround shiftwidth=4 tabstop=4 softtabstop=4

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase

set nobackup
set noswapfile

" enable mouse support for all modes
set mouse=a

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k

" Make font bigger in MacVim
set guifont=Monaco:h14
