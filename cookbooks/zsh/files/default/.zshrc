# Path
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

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
export HISTSIZE=1000
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
bindkey -e
bindkey '^r' history-incremental-search-backward

# Miscellaneous Options
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt PROMPT_SUBST
setopt IGNORE_EOF
setopt AUTO_CD
stty -ixon -ixoff # disable scroll lock
export EDITOR=vim

# Load other config files
for config_file ($HOME/.zsh/*.zsh(.N)) source $config_file
