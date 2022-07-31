# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Please stop these annoying correction prompts
unsetopt correct_all
unsetopt correct

# Print non-zero exit codes
setopt printexitvalue

# so that HEAD^ in git works without escaping ^
setopt NO_NOMATCH

ZSH_THEME="gentoo"
plugins=(git)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.commonrc ]; then
  source ~/.commonrc
fi

# Always work in a tmux session if tmux is installed
# if which tmux 2>&1 >/dev/null; then
#   if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#     tmux attach -t hack || tmux new -s hack; exit
#   fi
# fi

export PATH="/usr/local/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/opt/homebrew/bin/brew shellenv)"

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# >>> coursier install directory >>>
export PATH="$PATH:/Users/ssl/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/ssl/Library/Caches/Coursier/arc/https/cdn.azul.com/zulu/bin/zulu17.32.13-ca-jdk17.0.2-macosx_aarch64.tar.gz/zulu17.32.13-ca-jdk17.0.2-macosx_aarch64"
# <<< JVM installed by coursier <<<

eval "$(frum init)"

export PATH="$PATH:$HOME/flutter/bin"

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ssl/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ssl/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ssl/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ssl/google-cloud-sdk/completion.zsh.inc'; fi

[ -f "/Users/ssl/.ghcup/env" ] && source "/Users/ssl/.ghcup/env" # ghcup-env

alias vi=nvim
alias vim=nvim
