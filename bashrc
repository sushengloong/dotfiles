[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Add Bash completion
source "$HOME/.git-completion.bash"

# Git branch in prompt.
parse_git_branch_and_ruby_version() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1|$(ruby -e "puts ENV['RUBY_VERSION']"))/"
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch_and_ruby_version)\[\033[00m\] $ "

# Add Oracle library to path
#export DYLD_LIBRARY_PATH="/usr/local/oracle/instantclient_10_2"
#export DYLD_LIBRARY_PATH="/usr/local/oracle/instantclient_11_2"
#export SQLPATH="/usr/local/oracle/instantclient_10_2"
#export SQLPATH="/usr/local/oracle/instantclient_11_2"
#export TNS_ADMIN="/usr/local/oracle/network/admin"
#export NLS_LANG="AMERICAN_AMERICA.UTF8"
#export PATH=$PATH:$DYLD_LIBRARY_PATH

# Add HomeBrew path
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH
# Add MacPorts path
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
# Add RVM to PATH for scripting
export PATH=$HOME/.rvm/bin:$PATH
# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# use MacVim-bundled Vim if available
if [ -f /Applications/MacVim.app/Contents/MacOS/Vim ]; then
  alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
fi

# vim ftw!
export EDITOR=vim
