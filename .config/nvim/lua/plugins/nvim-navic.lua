-- default config from lazy vim
return {
  { "SmiteshP/nvim-navic", name = "nvim-navic-off" },
  -- {
  --   -- "SmiteshP/nvim-navic",
  --   "sleepful/nvim-navic",
  --   -- name = "nvim-navic",
  --   dependencies = { "nvim-lualine/lualine.nvim" },
  --   lazy = true,
  --   init = function()
  --     vim.g.navic_silence = true
  --     require("lazyvim.util").on_attach(function(client, buffer)
  --       if client.server_capabilities.documentSymbolProvider then
  --         require("nvim-navic").attach(client, buffer)
  --       end
  --     end)
  --   end,
  --   opts = function()
  --     return {
  --       separator = " ",
  --       highlight = true,
  --       depth_limit = 5,
  --       icons = require("lazyvim.config").icons.kinds,
  --     }
  --   end,
  -- },
}
