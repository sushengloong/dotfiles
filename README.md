Sheng-Loong Su's dotfiles
=========================

Tested on Mac OSX 10.6 and 10.9

## Installation

### Clone repository:
```
git clone https://github.com/sushengloong/dotfiles.git ~/dotfiles
```

### Create symlinks:
```
ln -s ~/dotfiles/commonrc ~/.commonrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zpreztorc .zpreztorc
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/agignore ~/.agignore
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/githelpers ~/.githelpers
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/git-completion.bash ~/.git-completion.bash
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/vimrc.bundles ~/.vimrc.bundles
ln -s ~/dotfiles/irbrc ~/.irbrc
ln -s ~/dotfiles/gemrc ~/.gemrc
```

### Install Homebrew:
```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

### Install newer version of zsh:
```
brew install zsh
```

### Install Pretzo:
Refer to https://github.com/sorin-ionescu/prezto

### Copy custom Prezto theme:
```
cp ~/dotfiles/prompt_superlinh_setup ~/.zprezto/modules/prompt/functions
```

### Install Vim:
```
brew install macvim --with-cscope --with-lua --override-system-vim
brew linkapps
```

### Setup NeoBundle:
```
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
vim
Enter y or call :NeoBundleInstall
```

### Install rbenv:
Refer to https://github.com/sstephenson/rbenv

### Install rbenv gem-src plugin:
```
git clone https://github.com/amatsuda/gem-src.git ~/.rbenv/plugins/gem-src
```

### Install reattach-to-user-namespace
```
brew install reattach-to-user-namespace
```
