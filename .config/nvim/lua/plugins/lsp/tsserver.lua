return {
  setup = function()
    local lspconfig = require('lspconfig')
    local root_dir = require("lspconfig").util.root_pattern("package.json")
    lspconfig.tsserver.setup({
      root_dir = root_dir,
      single_file_support = false,
    })
  end,
}
