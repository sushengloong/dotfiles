function get_pwd() {
  echo "${PWD/$HOME/~}"
}

function ruby_version() {
  ruby -v | awk '{print $1, $2}'
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}$(get_pwd) %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$fg[red]%}$(ruby_version)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
