-- local clojure_filetype = function()
--   return vim.bo.filetype == "clojure"
-- end
local clojure_filetype = "clojure"
return {
  {
    "Olical/conjure",
    ft = clojure_filetype,
    init = function()
      -- this gives weird error, even though this is in the docs:
      --      https://github.com/Olical/conjure#lazynvim
      --      vim.g["conjure#mapping#doc_word"] = false
      vim.cmd("let g:conjure#mapping#doc_word = v:false")
      -- we remove this conjure option because it overwrites the LSP `K` hover
      -- and replaces it with `(doc <name>)`, which is less than ideal
    end
  },
  { "tpope/vim-dispatch",            ft = clojure_filetype },
  { "radenling/vim-dispatch-neovim", ft = clojure_filetype },
  {
    "clojure-vim/vim-jack-in",
    ft = clojure_filetype,
    config = function()
      vim.g.default_lein_task = "with-profile dev repl"
    end
  }
}
