return {
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding (no prefix)", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding (no prefix)" },
        { opts.mappings.find, desc = "Find right surrounding (no prefix)" },
        { opts.mappings.find_left, desc = "Find left surrounding (no prefix)" },
        { opts.mappings.highlight, desc = "Highlight surrounding (no prefix)" },
        { opts.mappings.replace, desc = "Replace surrounding (no prefix)" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines` (no prefix)" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        -- M-Bslash = C-Bslash
        add = "<M-Bslash>", -- Add surrounding in Normal and Visual modes
        delete = "<C-x>d", -- Delete surrounding
        find = "<C-x>f", -- Find surrounding (to the right)
        find_left = "<C-x>F", -- Find surrounding (to the left)
        highlight = "<C-x>h", -- Highlight surrounding
        replace = "<C-x>r", -- Replace surrounding
        update_n_lines = "<C-x>n", -- Update `n_lines`
        suffix_last = "",
        suffix_next = "",
      },
    },
  },
}
