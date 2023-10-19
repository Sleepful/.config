return {
  {
    enabled = false,
    "MunifTanjim/prettier.nvim",
    dependencies = { "jose-elias-alvarez/null-ls.nvim", "neovim/nvim-lspconfig" },
    opts = {
      bin = "prettierd", -- or `'prettierd'` (v0.23.3+)
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
      },
    },
  },
}
