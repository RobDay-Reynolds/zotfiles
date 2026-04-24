# Zotfiles

Dotfiles for macOS (Apple Silicon).

## Prerequisites

* Xcode CLI tools: `xcode-select --install`
* [Homebrew](https://brew.sh)

## Installation

```bash
git clone git@github.com:zaksoup/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install
```

The install script will:

* Install packages via Homebrew Bundle (see `Brewfile`)
* Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* Install [powerline fonts](https://github.com/powerline/fonts)
* Set up neovim with Python support (pynvim in a dedicated venv)
* Install [luan's vimfiles](https://github.com/luan/vimfiles)
* Symlink `.zshrc` and the Zagnoster zsh theme (rainbow agnoster with git-duet)
* Copy `.gitconfig`
* Set keyboard repeat rate defaults

## Git Duet

[git-duet](https://github.com/git-duet/git-duet) is configured with `GIT_DUET_CO_AUTHORED_BY=1`,
which adds `Co-authored-by` trailers via a `prepare-commit-msg` hook.
Use regular `git commit` (aliased to `git ci`) — not `git duet-commit`.
