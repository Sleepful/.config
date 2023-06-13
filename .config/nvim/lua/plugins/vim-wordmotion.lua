return {
  {
    "chaoren/vim-wordmotion",
    config = function()
      vim.g.wordmotion_spaces = { ".", "_", "-" }
    end,
  },
}
