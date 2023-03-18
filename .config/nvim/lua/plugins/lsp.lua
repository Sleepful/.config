local custom_attach = function()
  print("Lexical has started.")
end

local lexical = {
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  cmd = { "/Users/jose/Code/lexical/_build/dev/rel/lexical/start_lexical.sh" },
  settings = {},
}
return {
  {
    "neovim/nvim-lspconfig",
    opts = { servers = { tsserver = {} } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lexical = {
          mason = false,
          filetypes = lexical.filetypes,
          on_attach = custom_attach,
          settings = lexical.settings,
        },
      },
      setup = {
        lexical = function(_, _)
          local lspconfig = require("lspconfig")
          local configs = require("lspconfig.configs")
          configs.lexical = {
            default_config = {
              filetypes = lexical.filetypes,
              root_dir = function(fname)
                local root = lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
                print("Root dir:", root)
                return root
              end,
              cmd = lexical.cmd,
            },
          }
          return false
        end,
      },
    },
  },
}
