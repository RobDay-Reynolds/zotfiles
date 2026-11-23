-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
--
-- Ports of luan/vimfiles bindings (https://github.com/luan/vimfiles).
-- luan used "," as <leader>; here "," is mapped literally so LazyVim's <space> bindings stay intact.

local map = vim.keymap.set

-- Typo-tolerant commands
for _, cmd in ipairs({ "W", "Q", "WQ", "Wq" }) do
  vim.api.nvim_create_user_command(cmd, cmd:lower(), { bang = true })
end

-- <CR> saves the buffer if modified (normal <CR> in quickfix, terminals, pickers, etc.)
map("n", "<CR>", function()
  return vim.bo.buftype == "" and "<cmd>update<cr>" or "<CR>"
end, { expr = true, desc = "Save if modified" })

-- "," is taken, so <C-\> does the old reverse f/t repeat
map({ "n", "x", "o" }, "<C-\\>", ",", { desc = "Repeat f/t backwards" })

-- File tree
map("n", "\\", function() Snacks.explorer() end, { desc = "Toggle file tree" })
map("n", "|", function() Snacks.explorer.reveal() end, { desc = "Reveal file in tree" })
map("n", ",nn", function() Snacks.explorer() end, { desc = "Toggle file tree" })
map("n", ",nf", function() Snacks.explorer.reveal() end, { desc = "Reveal file in tree" })

-- Fuzzy finding (was FZF)
map("n", ",f", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", ",b", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", ",m", function() Snacks.picker.recent() end, { desc = "Recent files" })
map("n", ",F", function() Snacks.picker.lsp_symbols() end, { desc = "Symbols in buffer" })
map("n", ",S", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Symbols in project" })
map("n", ",L", function() Snacks.picker.lines() end, { desc = "Lines in buffer" })
map("n", ",C", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })
map("n", ",G", function() Snacks.picker.grep() end, { desc = "Grep project" })
map("n", ",a", function() Snacks.picker.grep() end, { desc = "Grep project" })
map("n", ",:", function() Snacks.picker.command_history() end, { desc = "Command history" })
map("n", ",?", function() Snacks.picker.search_history() end, { desc = "Search history" })
map("n", ",d", function() Snacks.picker.commands() end, { desc = "Commands" })

-- Git (fugitive + rhubarb)
map("n", ",gs", "<cmd>Git<cr>", { desc = "Git status" })
map("n", ",gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", ",gl", "<cmd>Git log --oneline<cr>", { desc = "Git log" })
map({ "n", "x" }, ",gg", ":GBrowse<cr>", { desc = "Open on GitHub" })
map("n", ",gpl", "<cmd>Git pull --rebase<cr>", { desc = "Git pull --rebase" })
map("n", ",gps", "<cmd>Git push origin HEAD<cr>", { desc = "Git push" })

-- Buffers
map("n", ",,", "<C-^>", { desc = "Alternate file" })
map("n", ",z", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", ",x", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Windows
map("n", ",vs", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", ",hs", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", ",sc", "<cmd>close<cr>", { desc = "Close window" })
map("n", ",w=", "<cmd>wincmd =<cr>", { desc = "Equalize windows" })
map("n", ",wx", "<cmd>wincmd x<cr>", { desc = "Swap windows" })
map("n", "<C-Left>", "<C-w>h", { desc = "Window left" })
map("n", "<C-Right>", "<C-w>l", { desc = "Window right" })
map("n", "<C-Up>", "<C-w>k", { desc = "Window up" })
map("n", "<C-Down>", "<C-w>j", { desc = "Window down" })

-- %% in the command line expands to the current file's directory
map("c", "%%", function()
  return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
end, { expr = true, desc = "Current file's directory" })
map("n", ",e", ":edit %%", { remap = true, desc = "Edit file in current dir" })
map("n", ",v", ":view %%", { remap = true, desc = "View file in current dir" })

-- Editing
map("n", ",ci", "gcc", { remap = true, desc = "Toggle comment" })
map("x", ",ci", "gc", { remap = true, desc = "Toggle comment" })
map("n", ",=", "gg=G``", { desc = "Reindent file" })
map("x", "Y", '"+y', { desc = "Copy to system clipboard" })
map("n", ",ss", "<cmd>setlocal spell!<cr>", { desc = "Toggle spellcheck" })
map("n", ",sf", "1z=", { desc = "Fix spelling" })
map("n", ",Z", function() Snacks.zen() end, { desc = "Zen mode" })

-- Copy file path to system clipboard
map("n", ",YY", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
  vim.notify("Copied: " .. vim.fn.expand("%"))
end, { desc = "Copy file path" })
map("n", ",YL", function()
  local s = vim.fn.expand("%") .. ":" .. vim.fn.line(".")
  vim.fn.setreg("+", s)
  vim.notify("Copied: " .. s)
end, { desc = "Copy file:line" })

-- Config files (was ,vi for ~/.vim/vimrc)
map("n", ",vi", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find config file" })
