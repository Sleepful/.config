return {
  setup = function()
    local lspconfig = require('lspconfig')
    local root_dir = require("lspconfig").util.root_pattern("package.json")
    -- it used to be called tsserver, but not anymore
    -- https://github.com/neovim/nvim-lspconfig/pull/3232
    lspconfig.ts_ls.setup({
      root_dir = root_dir,
      single_file_support = false,
    })
  end,
}
