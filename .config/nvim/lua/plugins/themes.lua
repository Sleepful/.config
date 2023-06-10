local bufferline_opts = function()
  return {
    options = {
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = require("lazyvim.config").icons.diagnostics
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  }
end
local lualine_opts = function()
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
end

local allow_reload = true

local toggle_reload = function()
  allow_reload = not allow_reload
end

local source_flavour = function()
  local config = "$XDG_CONFIG_HOME"
  local path = "/nvim/colors/flavours.lua"
  vim.cmd("source " .. config .. path)
end

local set_flavours = function()
  source_flavour()
  require("lualine").setup(lualine_opts())
end

local setup_RRethy = function()
  source_flavour()
  require("lualine").setup(lualine_opts())
end

local reload_flavour = function()
  if allow_reload then
    set_flavours()
  end
end

vim.api.nvim_create_user_command("Recolor", reload_flavour, {})

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
    opts = lualine_opts,
    config = function(LazyVim, opts)
      require("lualine").setup(opts)
    end,
  },
  {
    "RRethy/nvim-base16",
    keys = {
      {
        "<leader>ut",
        function()
          reload_flavour()
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
      colorscheme = "flavours",
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
      options = {
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
