local elixirls = require("plugins.lsp.elixir-ls")
local tsserver = require("plugins.lsp.tsserver")
local lexical = require("plugins.lsp.lexical")
local marksman = require("plugins.lsp.marksman")
local rust = require("plugins.lsp.rust")
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      tsserver.setup()

      lspconfig.denols.setup({
        root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
        on_attach = function()
          -- I guess this works because tsserver setup is called first
          -- so stop tsserver if we are attaching deno-ls, avoid conflicts
          vim.cmd("LspStop tsserver")
        end
      })
    end
  },
  -- elixirls,
  -- tsserver,
  -- lexical,
  -- marksman,
  -- rust,
}
