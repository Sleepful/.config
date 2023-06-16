return {
  {
    "chaoren/vim-wordmotion",
    config = function()
      vim.g.wordmotion_spaces = { ".", "_", "-" }
    end,
  },
}
-- TODO: make WORD motion to skip the spaces above, but _not_ skip other symbols
