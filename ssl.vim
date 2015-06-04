" My custom config when using neo innovation's vim-config
" (https://github.com/neo/vim-config).
" Run command below to create symlink in custom_config directory.
" mkdir -p ~/.vim/custom_config && ln -s ~/dotfiles/ssl.vim ~/.vim/custom_config/ssl.vim

call neobundle#append()

" Requirements:
" gem install html2slim
NeoBundle 'davydovanton/vim-html2slim'
NeoBundle 'chase/vim-ansible-yaml'
au BufNewFile,BufRead *.yml set filetype=ansible

NeoBundle 'ecomba/vim-ruby-refactoring'

NeoBundle 'christoomey/vim-tmux-navigator'

set relativenumber
colorscheme desert

call neobundle#end()
