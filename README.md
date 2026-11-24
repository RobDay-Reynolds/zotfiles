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
* Symlink `.zshrc` (which sources an untracked `~/.zshrc.local` for machine-specific settings like `OP_ACCOUNT`) and the Zagnoster zsh theme (rainbow agnoster with git-duet)
* Copy `.gitconfig`
* Import Rectangle window-manager settings from `RectangleConfig.json` (first run only)
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

## 1Password CLI

`.zshrc` loads API keys with `op read` at shell startup. On a new machine:

1. In the 1Password app, turn on **Settings → Developer → Integrate with 1Password CLI**.
2. Give iTerm **Full Disk Access** (System Settings → Privacy & Security). Without it, macOS
   blocks `op` from reaching the 1Password app and it reports "No accounts configured".
3. If you're signed in to more than one account, set `OP_ACCOUNT` in `~/.zshrc.local`.

## Rectangle

To update the tracked settings, open Rectangle → Settings → **Export** and save over
`RectangleConfig.json` in this repo. `install` imports it only when Rectangle has no settings yet;
to re-import on a configured machine use Rectangle → Settings → **Import**.
