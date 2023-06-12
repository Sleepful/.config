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
      require("plugins.telescope.C-g-keymaps").neotree.rg,
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
      window = {
        mappings = {
          ["/"] = "noop",
          ["Z"] = "expand_all_nodes",
          ["<C-g>g"] = function(state)
            local node = state.tree:get_node()
            require("telescope.builtin").live_grep({ cwd = node._parent_id })
          end,
          -- TODO: live grep with args?
          -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
        },
      },
    },
  },
}
