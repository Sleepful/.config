return {
  -- { 'echasnovski/mini.nvim',       version = false },
  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      local config = {
        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = {
          -- does not work well for clojure :/
          -- treesitter not good with clojure
          F = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
          p = spec_treesitter({ a = '@parameter.outer', i = '@parameter.inner' }),
        },

        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Main textobject prefixes
          around = 'a',
          inside = 'i',

          -- Next/last variants
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = 'g[',
          goto_right = 'g]',
        },

        -- Number of lines within which textobject is searched
        n_lines = 50,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = 'cover_or_next',

        -- Whether to disable showing non-error feedback
        silent = false,
      }
      require('mini.ai').setup(config)
    end
  },
  { 'echasnovski/mini.bufremove',  version = false, config = {} },
  { 'echasnovski/mini.comment',    version = false, config = {} },
  { 'echasnovski/mini.cursorword', version = false, config = {} },
  { 'echasnovski/mini.move',       version = false, config = {} },
  { 'echasnovski/mini.operators',  version = false, config = {} },
  -- { 'echasnovski/mini.jump',       version = false, config = {} },

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
      vim.list_extend(mappings, {
        --- without visual selection, normal mode
        ---
        {
          "<",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR><]],
          mode = { "n" },
          desc = "Surround with <",
        },
        {
          "[",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR>[]],
          mode = { "n" },
          desc = "Surround with [",
        },
        {
          "(",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR>(]],
          mode = { "n" },
          desc = "Surround with (",
        },
        {
          "{",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR>{]],
          mode = { "n" },
          desc = "Surround with {",
        },
        {
          "\"",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR>"]],
          mode = { "n" },
          desc = "Surround with \"",
        },
        {
          "'",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR>']],
          mode = { "n" },
          desc = "Surround with '",
        },
        {
          "`",
          [[viw:<C-u>lua MiniSurround.add('visual')<CR>`]],
          mode = { "n" },
          desc = "Surround with `",
        },
        --- with visual selection
        ---
        {
          "<",
          [[:<C-u>lua MiniSurround.add('visual')<CR><]],
          mode = { "x", "o" },
          desc = "Surround with <",
        },
        {
          "[",
          [[:<C-u>lua MiniSurround.add('visual')<CR>[]],
          mode = { "x", "o" },
          desc = "Surround with [",
        },
        {
          "(",
          [[:<C-u>lua MiniSurround.add('visual')<CR>(]],
          mode = { "x", "o" },
          desc = "Surround with (",
        },
        {
          "{",
          [[:<C-u>lua MiniSurround.add('visual')<CR>{]],
          mode = { "x", "o" },
          desc = "Surround with {",
        },
        {
          "\"",
          [[:<C-u>lua MiniSurround.add('visual')<CR>"]],
          mode = { "x", "o" },
          desc = "Surround with \"",
        },
        {
          "'",
          [[:<C-u>lua MiniSurround.add('visual')<CR>']],
          mode = { "x", "o" },
          desc = "Surround with '",
        },
        {
          "`",
          [[:<C-u>lua MiniSurround.add('visual')<CR>`]],
          mode = { "x", "o" },
          desc = "Surround with `",
        },
        {
          "<leader>a",
          [[:<C-u>lua MiniSurround.add('visual')<CR>]],
          mode = { "x", "o" },
          desc = "Surround with [input]",
        },
        {
          "<leader>aa",
          [[:<C-u>lua MiniSurround.add('visual')<CR>]],
          mode = { "n" },
          desc = "Surround with [input]",
        }
      })
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        -- add = "<leader>aa",            -- Add surrounding in Normal and Visual modes,
        delete = "<leader>ad",         -- Delete surrounding
        find = "<leader>an",           -- Find surrounding (to the right)
        find_left = "<leader>al",      -- Find surrounding (to the left)
        highlight = "<leader>ah",      -- Highlight surrounding
        replace = "<leader>ar",        -- Replace surrounding
        update_n_lines = "<leader>aN", -- Update `n_lines`
        suffix_last = "l",
        suffix_next = "n",
      },
    },
  },
}
