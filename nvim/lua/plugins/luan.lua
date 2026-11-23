-- Plugins carried over from luan/vimfiles
return {
  -- Default colorscheme in luan's config
  { "w0ng/vim-hybrid", lazy = false, priority = 1000 },
  { "LazyVim/LazyVim", opts = { colorscheme = "hybrid" } },

  -- Git: :Git, :Git blame, :GBrowse
  { "tpope/vim-fugitive", cmd = { "Git", "G", "Gclog", "GBrowse" } },
  { "tpope/vim-rhubarb", dependencies = { "tpope/vim-fugitive" }, cmd = { "GBrowse" } },

  -- Flash takes over s, S, f/t/;/, — keep vim's defaults instead
  { "folke/flash.nvim", enabled = false },

  -- Name the "," groups in the which-key popup
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { ",", group = "luan" },
        { ",g", group = "git" },
        { ",n", group = "file tree" },
        { ",s", group = "spell/close" },
        { ",w", group = "windows" },
        { ",Y", group = "copy path" },
      },
    },
  },
}
