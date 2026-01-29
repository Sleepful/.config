return {
  setup = function()
    -- vim.lsp.enable('phpactor')
    -- vim.lsp.enable('laravel_ls')
    vim.cmd([[autocmd BufWritePost *.php silent !./vendor/bin/pint %:p]])
    vim.lsp.enable('intelephense')
  end,
}
