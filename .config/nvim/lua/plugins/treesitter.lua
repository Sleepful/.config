return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "eex",
        "heex",
        "erlang",
        "css",
        "fennel",
        "rust",
        "sql",
        "markdown",
      })
    end,
  },
}
