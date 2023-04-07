return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "lunarvim/horizon.nvim" },
  { "shaunsingh/nord.nvim" },
  { "shaunsingh/moonlight.nvim" },
  { "peterlvilim/solarized.nvim" },
  { "Shatur/neovim-ayu" },
  -- has bad colors in dark mode, comment for now:
  -- { "shaunsingh/solarized.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
