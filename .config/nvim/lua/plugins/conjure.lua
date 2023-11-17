return {
  { "Olical/conjure" },
  { "tpope/vim-dispatch" },
  { "radenling/vim-dispatch-neovim" },
  {
    "clojure-vim/vim-jack-in",
    config = function()
      vim.g.default_lein_task = "with-profile dev repl"
    end
  }
}
