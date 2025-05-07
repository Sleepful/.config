return {
  setup = function()
    require 'lspconfig'.gopls.setup {}
    require 'lspconfig'.templ.setup {}
  end,
}
