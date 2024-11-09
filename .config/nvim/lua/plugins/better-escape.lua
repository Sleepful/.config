return {
  {
    "max397574/better-escape.nvim",
    enabled = false,
    -- Default settings:
    opts = {
      mappings = {
        -- `i` for insert-mode
        i = {
          k = {
            k = "<Esc>",
            l = "<Esc>",
          },
          l = {
            k = "<Esc>",
            l = "<Esc>",
          },
        },
      },
      timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
      default_mappings = true,
    },
  },
}
