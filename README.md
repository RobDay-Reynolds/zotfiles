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
* Symlink `nvim/` to `~/.config/nvim` ([LazyVim](https://www.lazyvim.org) plus luan-style bindings; see below)
* Set up neovim with Python support (pynvim in a venv under `~/.local/share/nvim`)
* Symlink `.zshrc` and the Zagnoster zsh theme (rainbow agnoster with git-duet)
* Copy `.gitconfig`
* Set keyboard repeat rate defaults

## Git Duet

[git-duet](https://github.com/git-duet/git-duet) is configured with `GIT_DUET_CO_AUTHORED_BY=1`,
which adds `Co-authored-by` trailers via a `prepare-commit-msg` hook.
Use regular `git commit` (aliased to `git ci`) — not `git duet-commit`.

## Neovim

`nvim/` is a [LazyVim](https://www.lazyvim.org) config with the muscle memory from
[luan's vimfiles](https://github.com/luan/vimfiles) ported on top. LazyVim's own bindings
stay on `<space>`; luan's bindings use a literal `,` prefix (see `nvim/lua/config/keymaps.lua`).

| Key | Action |
|---|---|
| `<Enter>` | Save if modified |
| `\` / `\|` | Toggle file tree / reveal current file |
| `,f` `,b` `,m` | Find files / buffers / recent files |
| `,G` or `,a` | Grep project |
| `,F` `,S` `,L` | Symbols in buffer / project, lines in buffer |
| `,gs` `,gb` `,gl` `,gg` | Git status / blame / log / open on GitHub |
| `,,` `,z` `,x` | Alternate file / previous / next buffer |
| `,vs` `,hs` `,sc` | Vertical split / horizontal split / close window |
| `,ci` | Toggle comment |
| `,YY` `,YL` | Copy file path / file:line |
| `Y` (visual) | Copy to system clipboard |
| `<C-\>` | Reverse `f`/`t` repeat (what `,` used to do) |

Press `,` and wait to see the full list in which-key.
