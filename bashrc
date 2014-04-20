[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Git branch in prompt.
parse_git_branch_and_ruby_version() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1|$(ruby -e "puts ENV['RUBY_VERSION']"))/"
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch_and_ruby_version)\[\033[00m\] $ "

if [ -f ~/.commonrc ]; then
  source ~/.commonrc
fi
