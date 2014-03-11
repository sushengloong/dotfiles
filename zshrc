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

if [ -f ~/.commonrc ]; then
  source ~/.commonrc
fi
