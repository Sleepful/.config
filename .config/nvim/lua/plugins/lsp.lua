local elixirls = require("plugins.lsp.elixir-ls")
local tsserver = require("plugins.lsp.tsserver")
local lexical = require("plugins.lsp.lexical")
return {
  elixirls,
  tsserver,
  lexical,
}
