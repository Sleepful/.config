local allow_reload = true

local toggle_reload = function()
  allow_reload = not allow_reload
end

local current_flavour = function()
  local flavour = require("util").cmd("flavours current")
  return flavour
end

local set_flavour = function()
  local flavour = current_flavour()
  vim.cmd("colorscheme base16-" .. flavour)
end

local reload = function()
  if allow_reload then
    -- set_flavour works better for lua_line because lua_line
    -- has its own version of known base16 color schemes,
    -- this way also keeps the icon colors and all sorts of things very nicely colored
    set_flavour()
    -- this other option might work better for base16 that are not available
    -- in the RRethy/nvim-base16 repo, in which case the above set_flavours() fails.
    -- vim.api.nvim_command("source ~/.config/nvim/lua/plugins/base16/colors.lua")
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
  { "folke/tokyonight.nvim", lazy = false, opts = { style = "moon" } },
  {
    "catppuccin/nvim",
    name = "catppuccin",
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "RRethy/nvim-base16",
      "LazyVim/LazyVim",
    },
    opts = function()
      return {
        options = {
          -- base16 based on RRethy base16:
          -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md#base16
          theme = "base16",
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                return str:sub(1, 1)
              end,
            },
            {
              "filename",
              path = 1,
              symbols = { modified = "📖", readonly = "🔑", unnamed = "🧸" },
            },
          },
          lualine_b = { { "branch" } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
              separator = { left = "", right = "" },
            },
            { "searchcount" },
          },
          lualine_z = {
            {
              "location",
              padding = { left = 1, right = 1 },
            },
            { "progress", separator = " ", padding = { left = 0, right = 1 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
    config = function(LazyVim, opts)
      require("lualine").setup(opts)
    end,
  },
  -- has bad colors in dark mode, comment for now:
  -- { "shaunsingh/solarized.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "RRethy/nvim-base16",
    config = function(LazyPlugin, opts)
      -- requires some default theme for the setup, otherwise funny behavior
      set_flavour()
    end,
    keys = {
      {
        "<leader>ut",
        function()
          reload()
        end,
        desc = "Reload theme",
      },
      {
        "<leader>uR",
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
    dependencies = {
      "RRethy/nvim-base16",
    },
    opts = {
      colorscheme = function()
        reload()
      end,
    },
  },
}
