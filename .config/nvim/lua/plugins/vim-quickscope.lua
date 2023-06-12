return {
  {
    "unblevable/quick-scope",
    dependencies = {
      "RRethy/nvim-base16",
      "LazyVim/LazyVim",
    },
    config = function()
      local cmd = require("config.autocmds").quick_scope
      cmd.opts.callback()
      vim.api.nvim_create_autocmd(cmd.auto, cmd.opts)
    end,
  },
  -- for some unknown reasonnn adding `keys` will
  -- stop the `config` function from running
  -- keys = {{}}
}
