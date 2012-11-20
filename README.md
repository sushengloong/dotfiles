=== Sheng-Loong Su's dotfiles

Tested on Mac OSX and Ubuntu Linux

== Installation

Clone repository:
  git clone https://github.com/sushengloong/dotfiles.git ~/dotfiles

Create symlinks:
  ln -s ~/dotfiles/bashrc ~/.bashrc
  ln -s ~/dotfiles/bash_profile ~/.bash_profile
  ln -s ~/dotfiles/ackrc ~/.ackrc
  ln -s ~/dotfiles/gitconfig ~/.gitconfig
  ln -s ~/dotfiles/gitignore_global ~/.gitignore_global
  ln -s ~/dotfiles/vimrc ~/.vimrc
  ln -s ~/dotfiles/vim ~/.vim

Setup Vundle:
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

Install bundle:
  vim +BundleInstall +qall
