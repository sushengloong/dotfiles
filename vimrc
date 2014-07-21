" This is Sheng-Loong Su's .vimrc

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Interactive command execution in Vim
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
" Defaults everyone can agree on
NeoBundle 'tpope/vim-sensible'
" Search and display information from arbitrary sources
" like files, buffers, recently used files or registers
NeoBundle 'Shougo/unite.vim'
" Precision colorscheme for the vim
NeoBundle 'altercation/vim-colors-solarized'
" Quoting/parenthesizing made simple
NeoBundle 'tpope/vim-surround'
" Ruby on Rails power tools
NeoBundle 'tpope/vim-rails'
" Next generation completion framework
NeoBundle 'Shougo/neocomplete.vim'
" Comment plugin
NeoBundle 'tomtom/tcomment_vim'
" A Git wrapper so awesome
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Remap leader key
let mapleader = ","
let g:mapleader = ","

" Change colorscheme
colorscheme solarized
let g:solarized_termcolors=256
set background=dark

" Don't make backups at all
set nobackup
set nowritebackup
set noswapfile
" Hybrid line number mode
set relativenumber
set number
" case-insensitive search unless specified otherwise
set ignorecase
set smartcase
set hlsearch
" highlight current line
set cursorline
" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
" better tab spaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Make Unite to do CtrlP-style search
call unite#custom#profile('default', 'context', {
	\   'start_insert': 1,
	\   'winheight': 10,
	\   'direction': 'botright'
	\ })
call unite#custom#profile('default', 'ignorecase', 1)
call unite#custom#profile('default', 'smartcase', 1)
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#custom#source('file_rec,file_rec/async', 'matchers', ['converter_relative_word', 'matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
"call unite#custom#source('file_rec/async','sorters','sorter_rank')
nnoremap <C-p> :Unite -buffer-name=files file_rec/async<cr>
nnoremap <leader>f :<C-u>Unite grep:. -buffer-name=search<cr>
" Search through yank history
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite history/yank<CR>
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>a :<C-u>UniteResume<cr>

" Use ag (the_silver_searcher) if available
if executable('ag')
  let g:unite_source_rec_async_command = 'ag --nogroup --nocolor --column --hidden -g ""'
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column --hidden'
  let g:unite_source_grep_recursive_opt = ''
endif

" configure neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" move by displayed line instead of physical line
nnoremap j gj
nnoremap k gk
" Can't be bothered to understand ESC vs <c-c> in insert mode
noremap <c-c> <esc>
" Clear search
nnoremap <leader><space> :noh<cr>
" Make equal or maximize current split window
nnoremap <C-w>m <C-w>\|<C-w>_
" Remap TComment keys
noremap <leader>c :TComment<cr>
" Generate tags
noremap <leader>rt :!/usr/local/bin/ctags --extra=+f --languages=-javascript,sql --exclude=.git --exclude=.svn --exclude=log -R *<CR><C-M>
