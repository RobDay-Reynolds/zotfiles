export ZSH_DISABLE_COMPFIX=true
# Path to your ohmyzsh installation.
export ZSH=$HOME/.ohmyzsh

# Git Duet settings
export GIT_DUET_GLOBAL=true
export GIT_DUET_ROTATE_AUTHOR=1
export GIT_DUET_CO_AUTHORED_BY=1

# go stuff
export GOPATH=$HOME/go

# editor
export EDITOR=nvim

# Set name of the theme to load.
export ZSH_THEME="zagnoster"

# Which plugins would you like to load?
plugins=(git docker)

# User configuration
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$GOPATH/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

source $ZSH/oh-my-zsh.sh

# Stuff that bugs C.J.
unsetopt AUTO_CD

# Direnv
eval "$(direnv hook zsh)"

# FZF
export FZF_DEFAULT_OPTS='--height 100%'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
if [ -f "$(python3 -c 'import site; print(site.getsitepackages()[0])')/powerline/bindings/bash/powerline.sh" ]; then
  source "$(python3 -c 'import site; print(site.getsitepackages()[0])')/powerline/bindings/bash/powerline.sh"
fi

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
