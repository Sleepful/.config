return {
  {
    -- enabled = false, -- to see if I miss it
    "stevearc/dressing.nvim",
    -- enabled = false,
    -- lazy = true,
    -- init = function()
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.ui.select = function(...)
    --     require("lazy").load({ plugins = { "dressing.nvim" } })
    --     return vim.ui.select(...)
    --   end
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.ui.input = function(...)
    --     require("lazy").load({ plugins = { "dressing.nvim" } })
    --     return vim.ui.input(...)
    --   end
    -- end,
    opts = {
      -- input = {
      --   get_config = function(opts)
      --     print(vim.inspect(opts))
      --     return opts
      --   end,
      -- },
    },
  },
}
