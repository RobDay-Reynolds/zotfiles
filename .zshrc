# Path to your ohmyzsh installation.
export ZSH=$HOME/.ohmyzsh

# Git Duet settings
export GIT_DUET_GLOBAL=true
export GIT_DUET_ROTATE_AUTHOR=1
export GIT_DUET_CO_AUTHORED_BY=1

# go stuff
export GOPATH=$HOME/go

# nvim stuff
export EDITOR=vim

# ruby stuff
alias be='bundle exec'

# Set name of the theme to load.
# Look in ~/.ohmyzsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that ohmyzsh is loaded.
export ZSH_THEME="zagnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.ohmyzsh/plugins/*)
# Custom plugins may be added to ~/.ohmyzsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker)

# User configuration

export PATH="/usr/local/bin:$GOPATH/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Stuff that bugs C.J.
unsetopt AUTO_CD

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by ohmyzsh libs,
# plugins, and themes. Aliases can be placed here, though ohmyzsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.ohmyzsh"

_direnv_hook() {
  eval "$(direnv export zsh)";
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
fi

# Chruby stuff
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# FZF stuff
export FZF_DEFAULT_OPTS='--height 100%'

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/local/lib/python3.10/site-packages/powerline/bindings/bash/powerline.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
