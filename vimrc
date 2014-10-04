" This is Sheng-Loong Su's .vimrc

if has('vim_starting')
  " Some Linux distributions set filetype in /etc/vimrc.
  " Clear filetype flags before changing runtimepath to force Vim to reload them.
  if exists("g:did_load_filetypes")
    filetype off
    filetype plugin indent off
  endif
  set runtimepath+=$GOROOT/misc/vim

  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Defaults everyone can agree on
NeoBundle 'tpope/vim-sensible'
" A colorful, dark color scheme for Vim
NeoBundle 'nanotech/jellybeans.vim'
" Lean & mean status/tabline for vim that's light as air
NeoBundle 'bling/vim-airline'
" Fuzzy file, buffer, mru, tag, etc finder
NeoBundle 'kien/ctrlp.vim'
" Quoting/parenthesizing made simple
NeoBundle 'tpope/vim-surround'
" enable repeating supported plugin maps with dot
NeoBundle 'tpope/vim-repeat'
" Ruby on Rails power tools
NeoBundle 'tpope/vim-rails'
" Next generation completion framework
NeoBundle 'Shougo/neocomplete.vim'
" Comment plugin
NeoBundle 'tomtom/tcomment_vim'
" A Git wrapper so awesome
NeoBundle 'tpope/vim-fugitive'
" Create your own text objects
NeoBundle 'kana/vim-textobj-user'
" A custom text object for selecting ruby blocks
NeoBundle 'nelstrom/vim-textobj-rubyblock'
" Syntax checking hacks for vim
NeoBundle 'scrooloose/syntastic'
" Rename the current file in the vim buffer + retain relative path
NeoBundle 'danro/rename.vim'
" Seamless navigation between tmux panes and vim splits
NeoBundle 'christoomey/vim-tmux-navigator'
" A Vim plugin which shows a git diff in the gutter (sign column) and stages/reverts hunks.
NeoBundle 'airblade/vim-gitgutter'
" CoffeeScript support for vim
NeoBundle 'kchmck/vim-coffee-script'
" nyancat on vim
NeoBundle 'koron/nyancat-vim'

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Remap leader key
let mapleader = ","
let g:mapleader = ","

" Highlight trailing whitespaces.
" Ensure that the highlight group gets created and
" is not cleared by future colorscheme commands.
function! HighlightExtraWhitespace()
  highlight ExtraWhitespace ctermbg=darkred guibg=darkred
  match ExtraWhitespace /\s\+$/
endfunction
if has("autocmd")
  autocmd ColorScheme * call HighlightExtraWhitespace()
else
  call HighlightExtraWhitespace()
endif

" Change colorscheme
set background=dark
colorscheme jellybeans

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
" better tab spaces
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
" Disable beep and flash
set noerrorbells visualbell t_vb=
" configure wild menu mode
set wildmode=longest:list,full
" To resolve syntastic error
set shell=/bin/bash

" Set explore mode to use NerdTree list style
let g:netrw_liststyle=3

" CtrlP config
" Always use The Silver Searcher if available
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  " :Ag command for searching files in project
  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap <leader>f :Ag<SPACE>
endif

" Syntastic config
let g:syntastic_enable_highlighting=0
let g:syntastic_mode_map={ 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['java'] }
" Use rubocop with the default ruby checker (mri)
let g:syntastic_ruby_checkers = ['mri', 'rubocop']

" Configure neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Disable autocomplete and allow manual completion with TAB key
let g:neocomplete#disable_auto_complete = 1
let g:neocomplete#enable_auto_select = 0
inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplete#start_manual_complete()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Disable vim-airline hunks and branch integration
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0

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
" Paste from system clipboard
noremap <leader>p :set paste<cr>o<esc>"+p:set nopaste<cr>
" Put current working directory in command
cnoremap %% <C-R>=expand('%:p:h').'/'<cr>
" Compile and run a single Java file
noremap <leader>rj :!javac % && java <C-R>=expand('%:r')<cr><cr>

" Removes trailing spaces
command! TrimWhitespace %s/\s\+$//e

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  augroup jumpLastCursorPos
    " Clear all autocmds in the group
    autocmd!
    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal g`\"" |
          \ endif
  augroup END

  augroup setFiletype
    " Clear all autocmds in the group
    autocmd!
    " Set filetype for additional file extensions
    autocmd BufNewFile,BufRead *.gradle setfiletype groovy
    autocmd BufNewFile,BufRead */gitconfig setfiletype gitconfig
  augroup END
endif

filetype plugin indent on
syntax on
