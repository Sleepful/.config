return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "eex",
        "erlang",
        "css",
        "fennel",
        "rust",
        "sql",
      })
    end,
  },
}
