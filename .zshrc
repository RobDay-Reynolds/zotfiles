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
alias vim=nvim

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
# Ensure ~/.local/bin takes priority over Homebrew
export PATH="$HOME/.local/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# Machine-specific settings that stay out of this public repo (e.g. OP_ACCOUNT)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Secrets from 1Password (needs 1Password app > Settings > Developer > "Integrate with 1Password CLI").
# Only read them when op can see an account; otherwise op stops startup with an interactive prompt.
if command -v op >/dev/null && op account list --format=json </dev/null 2>/dev/null | grep -q '"url"'; then
  export CLOUDSMITH_API_KEY=$(op read op://Employee/cloudsmith/api_key </dev/null)
  export ANTHROPIC_API_KEY=$(op read "op://Employee/anthropic/key" </dev/null)
  export OPENAI_API_KEY=$(op read "op://Employee/openai/api_key" </dev/null)
elif command -v op >/dev/null; then
  echo "1Password CLI can't see any accounts from this terminal; skipping API keys" >&2
fi
