return {
  -- install with: rustup component add rust-analyzer
  setup = function()
    local lspconfig = require('lspconfig')
    lspconfig.rust_analyzer.setup {
      -- Server-specific settings. See `:help lspconfig-setup`
      settings = {
        ['rust-analyzer'] = {},
      },
    }
  end,
}
