Sheng-Loong Su's dotfiles
=========================

Crafted for and tested on Mac OSX. 

## Installation

### Install iTerm 2:
Download from http://www.iterm2.com/

### Install Homebrew:
```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```

### Install newer version of zsh:
```
brew install zsh
```

### Install oh my zsh:
Refer to https://github.com/robbyrussell/oh-my-zsh

### Install Powerlevel10k theme for Zsh:
Refer to https://github.com/romkatv/powerlevel10k#oh-my-zsh

### Install tmux:
```
brew install tmux
```

### Install reattach-to-user-namespace
```
brew install reattach-to-user-namespace
```

### Install Vim:
```
brew install --HEAD vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Then launch vim and run :PlugInstall to install all the vim plugins
```

### Install ripgrep (rg):
```
brew install ripgrep
```

### Install universal-ctags
```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```

### Install autojump
```
brew install autojump
```

### Install rbenv:
Refer to https://github.com/sstephenson/rbenv

### Install rbenv gem-src plugin:
```
git clone https://github.com/amatsuda/gem-src.git ~/.rbenv/plugins/gem-src
```

### Clone this repository:
```
git clone https://github.com/sushengloong/dotfiles.git ~/dotfiles
```

### Create symlinks:
```
ln -s ~/dotfiles/oh-my-zsh/custom/themes ~/.oh-my-zsh/custom/themes
ln -s ~/dotfiles/commonrc ~/.commonrc
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/bashrc ~/.bashrc
ln -s ~/dotfiles/bash_profile ~/.bash_profile
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/agignore ~/.agignore
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/githelpers ~/.githelpers
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/irbrc ~/.irbrc
ln -s ~/dotfiles/pryrc ~/.pryrc
ln -s ~/dotfiles/gemrc ~/.gemrc
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/ctags.d ~/.ctags.d
```
