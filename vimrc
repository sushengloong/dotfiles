set nocompatible

" Remap leader key
let mapleader = ","
let g:mapleader = ","

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

runtime macros/matchit.vim

syntax on

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

" always show tabs title
set showtabline=2

set wildmenu
set wildmode=list:longest,full

" no code folding
set foldmethod=manual
set nofoldenable

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

" Display extra whitespace
set list listchars=tab:»·,trail:·

set t_Co=256
set background=dark
colorscheme railscasts
" colorscheme molokai

" good for my fingers
inoremap jj <ESC>

" Save one keystroke
nnoremap ; :

" Remap backslash to repeat forward find
nnoremap \ ;
" Remap pipe to repeat backward find
nnoremap \| ,

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

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
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 2
nnoremap <leader>b :CtrlPBuffer<CR>

" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$\|\.log$\|\.jpg$\|\.jpeg$\|\.png$\|\.gif$\|\.zip$\|\.tar$\|\.rar$\|\.gz$\|\.class$'
  \ }

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
nnoremap <leader>tb :TagbarToggle<CR>

" Remap NERDTree toggle
" nnoremap <leader>n :NERDTreeToggle<CR>
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Make the omnicomplete text readable
" highlight PmenuSel ctermfg=black

" Make matching search phrase more obvious
highlight Search cterm=NONE ctermbg=yellow ctermfg=black

" Makes autocomplete easier
imap <Tab> <C-P>
imap <S-Tab> <C-N>

imap <C-L> <Space>=><Space>

" Remap tcomment toggle
nmap <leader>c gcc
vmap <leader>c gc

" ag config
let g:agprg="ag --column --smart-case"

" Remap Ack
nnoremap <leader>a :Ag!<space>

" Regenerate tags
map <leader>rt :!ctags --extra=+f --languages=-javascript,sql --exclude=.git  --exclude=log -R *<CR><C-M>
"map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git  --exclude=log -R * `bundle show rails`/../*<CR><C-M>
"map <leader>rt :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

" Edit routes and schema in Rails app
command! Rroutes :e config/routes.rb
command! Rschema :e db/schema.rb

" Display tab number
if exists("+showtabline")
function MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= '%' . i . 'T'
        let s .= (i == t ? '%1*' : '%2*')
        let s .= ' '
        let s .= i . ')'
        let s .= ' %*'
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let file = bufname(buflist[winnr - 1])
        let file = fnamemodify(file, ':p:t')
        if file == ''
            let file = '[No Name]'
        endif
        let s .= file
        let i = i + 1
    endwhile
    let s .= '%T%#TabLineFill#%='
    let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s
endfunction
set stal=2
set tabline=%!MyTabLine()
endif

" Remap some tabs commands
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<CR>
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
command! RenameFile :call RenameFile()<cr>

nmap <Leader>gg :GitGutterToggle<cr>

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

  au BufRead,BufNewFile *.rabl setf ruby

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python,java set sw=4 sts=4 et
augroup END

" disable syntastic for some languages
let g:syntastic_mode_map={ 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['java'] }

" enable neocomplcache
let g:neocomplcache_enable_at_startup = 1

" Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR> " clash with ag shortkey

" YankRing.vim mappings
nnoremap <silent> <F10> :YRShow<CR>

" Notes
" creates an html rendering of the current file
" :%TOhtml

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
