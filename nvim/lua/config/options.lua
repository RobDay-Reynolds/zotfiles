-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- LazyVim's leader stays <space>. luan's ","-prefixed bindings live in keymaps.lua
-- as literal "," mappings, so both sets work side by side.
vim.g.maplocalleader = "-"

-- Python provider lives in a venv created by zotfiles/install
vim.g.python3_host_prog = vim.fn.stdpath("data") .. "/venv/bin/python"

-- luan: treat $ and - as part of words (foo-bar, $var)
vim.opt.iskeyword:append({ "$", "-" })

-- luan: system clipboard stays separate; use visual Y to copy to it
vim.opt.clipboard = ""

-- luan: absolute line numbers, write on buffer switch/:make, a bit more scroll context
vim.opt.relativenumber = false
vim.opt.autowriteall = true
vim.opt.scrolloff = 5
