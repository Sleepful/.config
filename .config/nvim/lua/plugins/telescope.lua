local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_strategy = "vertical",
        enable_preview = true,
        layout_config = {
          mirror = true,
          prompt_position = "top",
          vertical = {
            width = { padding = 0 },
            height = { padding = 0 },
            preview_cutoff = 2,
            preview_height = 5,
          },
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    keys = {
      -- {
      --   "<leader>t",
      --   desc = "Telescope",
      -- },
      -- currently a lot inside the `s` key
      -- default search/find functionality from lazy vim always goes to `root_dir`,
      -- it looks like `cwd` defaults to `root_dir`
      -- not sure if I misunderstand the `cwd` or whut, but lets overwrite them
      -- probably due to the pick between git_files and find_files
      {
        -- TODO: override "<leader>ff" because there is also "<leader><space>", redundant
        -- - [ ] also add a hotkey to update the CWD to traverse up the directory structure
        -- - [ ] and add another hotkey to traverse into the directory structure for good measure, this one requires an arg, how to?
        --  - perhaps the arg to this one is currently selected file, derive the 1 level traversal from there
        -- - [ ] and for extra good measure, add a hotkey that resets the traversal to the leaf directory of currently highlit file
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "Find Files (!cwd)",
      },
      {
        -- this one includes parent dir, unlike <leader>ff which does not
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fs.dirname(vim.fn.expand("%:p:h")),
          })
        end,
        desc = "Find Files (!cwd)",
      },
      -- TODO: also replace
      -- "<leader>sg",
      -- "<leader>sG",
      -- because they all do a grep on root dir, one of them says CWD but fails :shrug:
      -- because they are redundant and all do the same as "<leader>/"
      -- TODO: Add a `live_grep` inside open buffers
      -- {
      --   "<leader>sg",
      --   function()
      --   end,
      --   desc = "",
      -- },
      -- NOTE: the same as default lazy vim afaik
      -- TODO: replace with live_grep_args plugin for telescope, or add a hotkey that upgrades a telesearch?
      { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
      {
        "<leader>uC",
        function()
          require("telescope.builtin")["colorscheme"]({
            layout_strategy = "horizontal",
            enable_preview = true,
            layout_config = {
              prompt_position = "bottom",
              horizontal = {
                width = { padding = 0 },
                height = { padding = 0 },
                preview_cutoff = 20,
                preview_height = 10,
              },
            },
          })
        end,
        desc = "Colorscheme with preview",
      },
    },
  },
}
