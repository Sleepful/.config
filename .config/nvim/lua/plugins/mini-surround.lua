return {
  -- { 'echasnovski/mini.nvim',       version = false },
  { 'echasnovski/mini.ai',         version = false,  config = {} },
  { 'echasnovski/mini.bufremove',  version = false,  config = {} },
  { 'echasnovski/mini.comment',    version = false,  config = {} },
  { 'echasnovski/mini.cursorword', version = false,  config = {} },
  { 'echasnovski/mini.move',       version = false,  config = {} },
  { 'echasnovski/mini.operators',  version = false,  config = {} },

  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add,            desc = "Add surrounding (no prefix)",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete surrounding (no prefix)" },
        { opts.mappings.find,           desc = "Find right surrounding (no prefix)" },
        { opts.mappings.find_left,      desc = "Find left surrounding (no prefix)" },
        { opts.mappings.highlight,      desc = "Highlight surrounding (no prefix)" },
        { opts.mappings.replace,        desc = "Replace surrounding (no prefix)" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines` (no prefix)" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "\\",                     -- Add surrounding in Normal and Visual modes,
        delete = "<M-Bslash>d",         -- Delete surrounding
        find = "<M-Bslash>f",           -- Find surrounding (to the right)
        find_left = "<M-Bslash>F",      -- Find surrounding (to the left)
        highlight = "<M-Bslash>h",      -- Highlight surrounding
        replace = "<M-Bslash>r",        -- Replace surrounding
        update_n_lines = "<M-Bslash>n", -- Update `n_lines`
        suffix_last = "",
        suffix_next = "",
      },
    },
  },
}
