local elixirls = require("plugins.lsp.elixir-ls")
local tsserver = require("plugins.lsp.tsserver")
local lexical = require("plugins.lsp.lexical")
local marksman = require("plugins.lsp.marksman")
local deno = require("plugins.lsp.deno")
local php = require("plugins.lsp.php")
local rust = require("plugins.lsp.rust")
local golang = require("plugins.lsp.golang")
local racket = require("plugins.lsp.racket")
local lua = require("plugins.lsp.lua-ls")
local clojure = require("plugins.lsp.clojure")
local fennel = require("plugins.lsp.fennel")
local autoformat = require("plugins.lsp.autoformat")

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

-- leaderkey
local k = "<C-n>"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { { "nvim-telescope/telescope.nvim" } },
    config = function()
      tsserver.setup()
      -- marksman.setup()
      deno.setup()
      lua.setup()
      clojure.setup()
      fennel.setup()
      autoformat.autoformat()
      -- rust.setup()
      golang.setup()
      racket.setup()
      php.setup()
      -- require 'lspconfig'.csharp_ls.setup {}
      -- for QML, the QtQuick file format / declarative code
      -- vim.lsp.enable('qmlls')
      -- vim.lsp.enable('basedpyright')
      vim.lsp.enable('ruff') -- python
    end,
    keys = {
      { k .. "e", vim.lsp.buf.declaration,                                    desc = "Declaration" },
      { k .. "d", vim.lsp.buf.definition,                                     desc = "Definition" },
      -- use hover.nvim for this
      -- { k .. "K", vim.lsp.buf.hover,                                          desc = "Hover" },
      { k .. "i", vim.lsp.buf.implementation,                                 desc = "Implementation" },
      { k .. "R", vim.lsp.buf.rename,                                         desc = "Rename" },
      { k .. "r", vim.lsp.buf.references,                                     desc = "References" },
      { k .. "S", require("telescope.builtin").lsp_dynamic_workspace_symbols, desc = "Workspace Symbols" },
      { k .. "!", vim.lsp.buf.document_symbol,                                desc = "Document Symbols" },
      {
        k .. "s",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Symbols"
      },
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
        k .. "w",
        function()
          vim.lsp.buf.code_action({
            filter = function(action)
              if action.command then
                -- clojure LSP
                return action.command.command == "drag-forward"
              end
              return false
            end,
            apply = true
          })
        end,
        desc = "Drag Forward (clojure)",
        ft = "clojure"
      },
      {
        k .. "b",
        function()
          vim.lsp.buf.code_action({
            filter = function(action)
              if action.command then
                -- clojure LSP
                return action.command.command == "drag-backward"
              end
              return false
            end,
            apply = true
          })
        end,
        desc = "Drag Backwards (clojure)",
        ft = "clojure"
      },
      -- not in code actions, need to figure out how to pass these to the server
      -- https://clojure-lsp.io/features/#execute-command
      -- {
      --   k .. "<Tab>",
      --   function()
      --     vim.lsp.buf.code_action({
      --       filter = function(action)
      --         if action.command then
      --           -- clojure LSP
      --           return action.command.command == "forward-slurp"
      --         end
      --         return false
      --       end,
      --       apply = true
      --     })
      --   end,
      --   desc = "Forwards slurp"
      -- },
      -- {
      --   k .. "<S-Tab>",
      --   function()
      --     vim.lsp.buf.code_action({
      --       filter = function(action)
      --         if action.command then
      --           -- clojure LSP
      --           return action.command.command == "forward-barf"
      --         end
      --         return false
      --       end,
      --       apply = true
      --     })
      --   end,
      --   desc = "Forward barf"
      -- },
      -- {
      --   k .. "<Del>",
      --   function()
      --     vim.lsp.buf.code_action({
      --       filter = function(action)
      --         if action.command then
      --           -- clojure LSP
      --           return action.command.command == "backward-barf"
      --         end
      --         return false
      --       end,
      --       apply = true
      --     })
      --   end,
      --   desc = "Backwards barf"
      -- },
      -- {
      --   k .. "<BS>",
      --   function()
      --     vim.lsp.buf.code_action({
      --       filter = function(action)
      --         if action.command then
      --           -- clojure LSP
      --           return action.command.command == "backward-slurp"
      --         end
      --         return false
      --       end,
      --       apply = true
      --     })
      --   end,
      --   desc = "Backwards slurp"
      -- },
    },
  },
  -- elixirls,
  -- lexical,
  {
    -- https://clojure-lsp.io/features/#code-lenses-showing-symbol-references
    -- not working?? apparently zero lenses available in most files :l
    -- lua print(vim.inspect(vim.lsp.codelens.get()))
    'VidocqH/lsp-lens.nvim',
    config = function()
      local SymbolKind = vim.lsp.protocol.SymbolKind
      require 'lsp-lens'.setup({
        enable = true,
        include_declaration = false, -- Reference include declaration
        sections = {                 -- Enable / Disable specific request
          definition = false,
          references = true,
          implements = true,
        },
        ignore_filetype = {
          -- "prisma",
        },
        -- Target Symbol Kinds to show lens information
        target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
        -- Symbol Kinds that may have target symbol kinds as children
        wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
      })
    end,
  },

}
