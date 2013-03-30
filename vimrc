set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Railscasts theme
Bundle 'vim-scripts/Railscasts-Theme-GUIand256color'

Bundle 'vim-ruby/vim-ruby'
Bundle 'kchmck/vim-coffee-script'
Bundle 'nono/vim-handlebars'
Bundle 'groenewege/vim-less'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'tomtom/tcomment_vim'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/EasyGrep'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Raimondi/delimitMate'
Bundle 'tsaleh/vim-matchit'
Bundle 'rking/ag.vim'
Bundle 'sjl/gundo.vim'
Bundle 'SirVer/ultisnips'
Bundle 'godlygeek/tabular'
Bundle 'airblade/vim-gitgutter'
Bundle 'mattn/calendar-vim'
Bundle 'vim-scripts/matrix.vim--Yang'
Bundle 'koron/nyancat-vim'

syntax on
filetype plugin indent on

au BufRead,BufNewFile *.rabl setf ruby

set nobackup
set nowritebackup
set noswapfile

set encoding=utf-8
set number
set hidden
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set autoindent
set expandtab
set history=500
set backspace=indent,eol,start

set ignorecase
set smartcase
set incsearch
set hlsearch

set wildmenu
set wildmode=list:longest,full

" always show status line
set laststatus=2
" set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'} " filetype
set statusline+=]
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

set cursorline

set t_Co=256
set background=dark
colorscheme railscasts

" good for my fingers
inoremap jj <ESC>

" Remap leader key
let mapleader = ","
let g:mapleader = ","

" Save one keystroke
nnoremap ; :

" Remap backslash to repeat forward find
nnoremap \ ;
" Remap pipe to repeat backward find
nnoremap \| ,

" Be a man, do the right thing!
nnoremap <up> :echo "Be a man. Do the right thing. Use HJKL!"<cr>
nnoremap <down> :echo "Be a man. Do the right thing. Use HJKL!"<cr>
nnoremap <left> :echo "Be a man. Do the right thing. Use HJKL!"<cr>
nnoremap <right> :echo "Be a man. Do the right thing. Use HJKL!"<cr>
inoremap <up> <Esc>:echo "Be a man. Do the right thing. Use HJKL!"<cr>
inoremap <down> <Esc>:echo "Be a man. Do the right thing. Use HJKL!"<cr>
inoremap <left> <Esc>:echo "Be a man. Do the right thing. Use HJKL!"<cr>
inoremap <right> <Esc>:echo "Be a man. Do the right thing. Use HJKL!"<cr>
nnoremap j gj
nnoremap k gk

" Easier to navigate around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize split window fast
nnoremap <silent> <Leader>+ <C-w>+<C-w>>
nnoremap <silent> <Leader>- <C-w>-<C-w><

" Make equal or maximize current split window
nmap <C-w>m <C-w>\|<C-w>_

" Clear search
nnoremap <leader><space> :noh<cr>

" remap some CtrlP keys
let g:ctrlp_map = '<leader>p'
nnoremap <leader>b :CtrlPBuffer<CR>

" type <leader><leader> to trigger easy motion
let g:EasyMotion_leader_key = '<leader><leader>'

" Edit and source vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Bubble single lines, remap unimpaired key
" Commented out due to conflict with windows navigation shortcuts
"nmap <C-k> [e
"nmap <C-j> ]e
"nmap <C-h> <<
"nmap <C-l> >>

" Bubble multiple lines, remap unimpaired key
vmap <C-k> [egv
vmap <C-j> ]egv
vmap <C-h> <gv
vmap <C-l> >gv

" Remap tagbar toggle
nnoremap <leader>t :TagbarToggle<CR>

" Remap NERDTree toggle
nnoremap <leader>n :NERDTreeToggle<CR>

" Make the omnicomplete text readable
" highlight PmenuSel ctermfg=black

" Make matching search phrase more obvious
highlight Search cterm=NONE ctermbg=darkred ctermfg=white

" Makes autocomplete easier
imap <Tab> <C-P>
imap <S-Tab> <C-N>

imap <C-L> <Space>=><Space>

" Remap tcomment toggle
nmap <leader>c gcc
vmap <leader>c gc

" Remap Ack
nnoremap <leader>a :Ag<space>

" Regenerate tags
map <leader>rt :!ctags --extra=+f --languages=-javascript,sql --exclude=.git  --exclude=log -R *<CR><C-M>
"map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git  --exclude=log -R * `bundle show rails`/../*<CR><C-M>
"map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

" Edit routes and schema in Rails app
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Remap some tabs commands
nnoremap <leader>tn :tabe<CR>
nnoremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>tc :tabclose<CR>

" Remap some rake commands
nnoremap <leader>rr :Rake routes<CR>
nnoremap <leader>rsss :Rake sunspot:solr:start<CR>
nnoremap <leader>rsr :Rake sunspot:reindex<CR>

" Map Gundo key (need to be compiled with python support)
nnoremap <leader>u :GundoToggle<CR>

" remap tabular.vim keys
let mapleader=','
if exists(":Tabularize")
  nmap <Leader>ta= :Tabularize /=<CR>
  vmap <Leader>ta= :Tabularize /=<CR>
  nmap <Leader>ta: :Tabularize /:\zs<CR>
  vmap <Leader>ta: :Tabularize /:\zs<CR>
  nmap <Leader>ta=> :Tabularize /=><CR>
  vmap <Leader>ta=> :Tabularize /=><CR>
endif

" Toggle auto-indenting for code paste
set pastetoggle=<F2>

" Paste from clipboard
nmap <Leader>v :set paste<CR>o<esc>"*]p:set nopaste<cr>
vmap <Leader>v c<esc>:set paste<CR>"*]p:set nopaste<cr>
imap <Leader>v <esc>:set paste<CR>"*]p:set nopaste<cr>A

" Copy to clipboard
map <leader>y "*y

" Quick way to print directory of current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
command! Rename :call RenameFile()<cr>

nmap <Leader>gg :GitGutterToggle<cr>

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
augroup END
