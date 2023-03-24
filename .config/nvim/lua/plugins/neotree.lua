return {
  {
    "nvim-treesitter/nvim-treesitter",
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
  },
}
