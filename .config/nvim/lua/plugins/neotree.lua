return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({
            source = "buffers",
            position = "right",
            toggle = true,
            dir = vim.loop.cwd(),
          })
        end,
        desc = "Explorer NeoTree (buffers)",
      },
    },
    opts = {
      default_component_configs = {
        icon = {
          -- Icons don't work so well with some themes...
          -- folder_closed = "",
          -- folder_open = "",
          folder_closed = "",
          folder_open = "",
          folder_empty = "ﰊ",
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
      },
    },
  },
}
