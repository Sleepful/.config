local elixirls = require("plugins.lsp.elixir-ls")
local tsserver = require("plugins.lsp.tsserver")
local lexical = require("plugins.lsp.lexical")
local marksman = require("plugins.lsp.marksman")
local deno = require("plugins.lsp.deno")
local rust = require("plugins.lsp.rust")
local lua = require("plugins.lsp.lua-ls")
local autoformat = require("plugins.lsp.autoformat")
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- tsserver.setup()
      marksman.setup()
      deno.setup()
      lua.setup()
      autoformat.autoformat()
    end
  },
  -- elixirls,
  -- lexical,
  -- rust,
}
