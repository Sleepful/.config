local elixirls = require("plugins.lsp.elixir-ls")
local tsserver = require("plugins.lsp.tsserver")
local lexical = require("plugins.lsp.lexical")
local marksman = require("plugins.lsp.marksman")
local deno = require("plugins.lsp.deno")
local rust = require("plugins.lsp.rust")
local lua = require("plugins.lsp.lua-ls")
local clojure = require("plugins.lsp.clojure")
local autoformat = require("plugins.lsp.autoformat")

-- leaderkey
local k = "<C-n>"

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- tsserver.setup()
      marksman.setup()
      deno.setup()
      lua.setup()
      clojure.setup()
      autoformat.autoformat()
    end,
    keys = {
      { k .. "d", vim.lsp.buf.declaration,    desc = "Declaration" },
      { k .. "D", vim.lsp.buf.definition,     desc = "Definition" },
      { k .. "K", vim.lsp.buf.hover,          desc = "Hover" },
      { k .. "i", vim.lsp.buf.implementation, desc = "Implementation" },
      { k .. "R", vim.lsp.buf.rename,         desc = "Rename" },
      { k .. "r", vim.lsp.buf.references,     desc = "References" },
      {
        k .. "f",
        function()
          vim.lsp.buf.format { async = true }
        end,
        desc = "Format"
      },
      {
        k .. k,
        function()
          vim.lsp.buf.code_action()
        end,
        desc = "Code action"
      },
      {
        "<C-j>",
        function()
          vim.lsp.buf.code_action({
            filter = function(action)
              return action.command.command == "drag-forward"
            end,
            apply = true
          })
        end,
        desc = "Drag Forward"
      },
      {
        "<C-k>",
        function()
          vim.lsp.buf.code_action({
            filter = function(action)
              return action.command.command == "drag-backward"
            end,
            apply = true
          })
        end,
        desc = "Drag Backwards"
      }
    },
  },
  -- elixirls,
  -- lexical,
  -- rust,
}
