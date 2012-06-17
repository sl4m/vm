export PATH=$HOME/.bin:$PATH

vc_prompt_info() {
  echo "%{$fg[cyan]%}[$(vcprompt -f %b%m%u)]%{$reset_color%}"
}

cwd() {
  echo "%{$fg[magenta]%}%~%{$reset_color%}"
}

export PROMPT="
\$(cwd) \$(vc_prompt_info)
%{$fg[blue]%}%%%{$reset_color%} "
