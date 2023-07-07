--- For lualine, from:
--- https://github.com/nvim-lualine/lualine.nvim/issues/225#issuecomment-974744156
--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number | nil hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

local lualine_opts = function()
  return {
    options = {
      -- base16 based on RRethy base16:
      -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md#base16
      theme = "base16",
      globalstatus = true,
    },
    -- sections = {},
    winbar = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            local letter = str:sub(1, 1)
            local symbol = letter
            if letter == "N" then
              symbol = "🛸"
            end
            if letter == "I" then
              symbol = "🛹"
            end
            if letter == "V" then
              symbol = "⛸️"
            end
            if letter == "C" then
              symbol = "🪄"
            end
            return symbol
          end,
        },
        {
          "filename",
          path = 1,
          symbols = { modified = "📖", readonly = "🔑", unnamed = "🧸" },
        },
      },
      lualine_b = { { "branch", fmt = trunc(140, 18, nil, true) } },
      lualine_c = {},
      lualine_x = {},
      lualine_y = {
        {
          function()
            return require("nvim-navic").get_location({ reverse_order = true })
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
          function()
            local line = vim.fn.line(".")
            local col = vim.fn.virtcol(".")
            return string.format("%3d💫%-2d", line, col)
          end,
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
      require("lualine").hide({
        place = { "statusline" }, -- The segment this change applies to.
        unhide = false, -- whether to re-enable lualine again/
      })
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
}
