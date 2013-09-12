export PATH=$HOME/.bin:$PATH

git_prompt_info() {
  ref=$($(which git) symbolic-ref HEAD 2> /dev/null) || return
  user=$($(which git) config user.name 2> /dev/null)
  echo "[%{$fg_bold[green]%}${user}@${ref#refs/heads/}%{$reset_color%}]"
}

export PS1='$(git_prompt_info)[%{$fg_bold[blue]%}%~%{$reset_color%}] '
