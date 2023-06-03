return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "lunarvim/horizon.nvim" },
  { "shaunsingh/nord.nvim" },
  { "shaunsingh/moonlight.nvim" },
  { "peterlvilim/solarized.nvim" },
  { "Shatur/neovim-ayu" },
  -- lazy = false -- because otherwise it doesn't display in uC color picker :S
  { "folke/tokyonight.nvim", lazy = false, opts = { style = "moon" } },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
  },
  -- has bad colors in dark mode, comment for now:
  -- { "shaunsingh/solarized.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "RRethy/nvim-base16",
    lazy = false,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
