# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Please stop these annoying correction prompts
unsetopt correct_all
unsetopt correct

# so that HEAD^ in git works without escaping ^
setopt NO_NOMATCH

ZSH_THEME="bira"
plugins=(git)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.commonrc ]; then
  source ~/.commonrc
fi

# Always work in a tmux session if tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi
