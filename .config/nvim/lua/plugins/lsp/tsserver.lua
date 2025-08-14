return {
  setup = function()
    vim.lsp.enable('ts_ls')
    vim.lsp.enable('eslint')
  end,
  old_tsls_setup = function()
    local lspconfig = require('lspconfig')
    local root_dir = require("lspconfig").util.root_pattern("package.json")
    -- it used to be called tsserver, but not anymore
    -- https://github.com/neovim/nvim-lspconfig/pull/3232
    lspconfig.ts_ls.setup({
      root_dir = root_dir,
      single_file_support = false,
      init_options = {
        preferences = {
          includeCompletionsForModuleExports = true,
          includeCompletionsForImportStatements = true,
          importModuleSpecifierPreference = "shortest",
          -- https://stackoverflow.com/questions/72029343/typescript-prefers-importing-relative-import-instead-of-path-alias
        },
      }
    })
  end,
}
