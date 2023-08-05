local elixirls = require("plugins.lsp.elixir-ls")
local tsserver = require("plugins.lsp.tsserver")
local lexical = require("plugins.lsp.lexical")
local marksman = require("plugins.lsp.marksman")
local rust = require("plugins.lsp.rust")
return {
  elixirls,
  tsserver,
  lexical,
  marksman,
  rust,
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- remove autoformat because it is using lsp autoformat instead of prettier
      -- for tsserver, ????
      -- autoformat = false,
      autoformat = true,
    },
  },
}
