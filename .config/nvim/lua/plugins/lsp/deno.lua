return {
  setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.denols.setup({
      root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
    })
  end,
}
