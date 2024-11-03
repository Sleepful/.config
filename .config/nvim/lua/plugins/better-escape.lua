return {
  {
    "max397574/better-escape.nvim",
    -- Default settings:
    opts = {
      mappings = {
        -- `i` for insert-mode
        i = {
          j = {
            k = "<Esc>",
            j = "<Esc>",
          },
          k = {
            k = "<Esc>",
            j = "<Esc>",
          },
        },
      },
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      default_mappings = true,
    },
  },
}
