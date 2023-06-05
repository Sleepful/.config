local allow_reload = true
local toggle_reload = function()
  allow_reload = not allow_reload
end

local reload = function()
  if allow_reload then
    vim.api.nvim_command("source ~/.config/nvim/lua/plugins/base16/colors.lua")
  end
end

vim.api.nvim_create_user_command("ReloadColors", reload, {})

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
    -- lazy = false,
    name = "catppuccin",
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "RRethy/nvim-base16",
    },
  },
  -- has bad colors in dark mode, comment for now:
  -- { "shaunsingh/solarized.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "RRethy/nvim-base16",
    config = function(LazyPlugin, opts)
      -- requires some default theme for the setup, otherwise funny behavior
      require("base16-colorscheme").setup({
        base00 = "#16161D",
        base01 = "#2c313c",
        base02 = "#3e4451",
        base03 = "#6c7891",
        base04 = "#565c64",
        base05 = "#abb2bf",
        base06 = "#9a9bb3",
        base07 = "#c5c8e6",
        base08 = "#e06c75",
        base09 = "#d19a66",
        base0A = "#e5c07b",
        base0B = "#98c379",
        base0C = "#56b6c2",
        base0D = "#0184bc",
        base0E = "#c678dd",
        base0F = "#a06949",
      })
      reload()
    end,
    -- lazy = false,
    keys = {
      {
        "<leader>t",
        desc = "Theme",
      },
      {
        "<leader>tr",
        function()
          reload()
        end,
        desc = "Reload theme",
      },
      {
        "<leader>tt",
        function()
          toggle_reload()
        end,
        desc = "Toggle theme reload capability",
      },
    },
  },
  {
    "noahfrederick/vim-noctu",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
