# Completion
setopt COMPLETE_IN_WORD
autoload -U compinit
compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # case insensitive completion
zstyle ':completion:*:default' menu 'select=0' # menu-style

# Colors
export CLICOLOR=1
autoload colors
colors

# History
HISTSIZE=10000
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

bindkey -e
bindkey '^r' history-incremental-search-backward
bindkey ' ' magic-space

# Miscellaneous Options
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt AUTO_CD
stty -ixon -ixoff # disable scroll lock
export EDITOR=vim

function ssh_key_for {
  curl -i https://api.github.com/users/${1}/keys
}

function symlink_ssh_auth_sock {
  ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
}

function export_ssh_auth_sock {
  export SSH_AUTH_SOCK=/home/vagrant/.ssh/ssh_auth_sock
}

# Load other config files and maintain SSH_AUTH_SOCK
if [ -z "$TMUX" ]; then
  symlink_ssh_auth_sock
else
  for config_file ($HOME/.zsh/*.zsh(.N)) source $config_file
  export_ssh_auth_sock
fi
