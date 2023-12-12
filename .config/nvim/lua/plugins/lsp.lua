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
    dependencies = { { "nvim-telescope/telescope.nvim" } },
    config = function()
      -- tsserver.setup()
      marksman.setup()
      deno.setup()
      lua.setup()
      clojure.setup()
      autoformat.autoformat()
      require 'lspconfig'.csharp_ls.setup {}
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
