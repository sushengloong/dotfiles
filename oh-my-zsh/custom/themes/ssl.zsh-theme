function get_pwd() {
  echo "${PWD/$HOME/~}"
}

function ruby_version() {
  ruby -v | awk '{print $1 "-" $2}'
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)%{$reset_color%}"
PROMPT='%{$fg[cyan]%}$(get_pwd) %{$fg[red]%}$(ruby_version) %{$fg_bold[blue]%}$(git_prompt_info)
${ret_status} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
