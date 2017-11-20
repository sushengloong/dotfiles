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
brew install macvim --with-cscope --with-lua --override-system-vim
brew linkapps
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Then launch vim and run :PlugInstall to install all the vim plugins
```

### Create dedicated directory for vim undo history files
```
mkdir ~/.vim/undodir
```

### Install and use CMake to compile YouCompleteMe Vim plugin:
```
brew install cmake
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer
```

### Install rbenv:
Refer to https://github.com/sstephenson/rbenv

### Install rbenv gem-src plugin:
```
git clone https://github.com/amatsuda/gem-src.git ~/.rbenv/plugins/gem-src
```

### Install the_silver_searcher / ag:
```
brew install the_silver_search
```

### Install ctags
```
brew install ctags
```

### Install autojump
```
brew install autojump
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
```
