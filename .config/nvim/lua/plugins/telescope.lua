return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          mirror = true,
          prompt_position = "top",
          vertical = {
            width = 0.99,
            height = 0.99,
            preview_cutoff = 20,
            preview_height = 10,
          },
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Find Files (cwd)",
      },
    },
  },
}
