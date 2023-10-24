return {
  setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.marksman.setup({
      -- "telekasten" add to filetypes?
      filetypes = { "markdown", "markdown.mdx" }
    })
  end,
}
