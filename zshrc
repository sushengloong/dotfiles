#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [ -f ~/.zprezto/runcoms/zshrc ]; then
  source ~/.zprezto/runcoms/zshrc
fi

# Please stop these annoying correction prompts
unsetopt correct_all
unsetopt correct

# so that HEAD^ in git works without escaping ^
setopt NO_NOMATCH

if [ -f ~/.commonrc ]; then
  source ~/.commonrc
fi

# Always work in a tmux session if tmux is installed
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
  fi
fi
