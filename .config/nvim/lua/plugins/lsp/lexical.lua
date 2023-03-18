local custom_attach = function()
  print("Lexical has started.")
end

local lexical = {
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  cmd = { "/Users/jose/Code/lexical/_build/dev/rel/lexical/start_lexical.sh" },
  root_dir = function(fname)
    local lspconfig = require("lspconfig")
    local root = lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
    print("Root dir:", root)
    return root
  end,
}
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lexical = {
        mason = false, -- do not set up with mason
        filetypes = lexical.filetypes,
        on_attach = custom_attach,
      },
    },
    setup = {
      lexical = function(_, _)
        local configs = require("lspconfig.configs")
        -- need to add the key with `configs.lexical = ...`
        -- so that configs.__new_index() runs before the setup that happens
        -- aftewards inside lazyvim setup:
        configs.lexical = {
          default_config = {
            filetypes = lexical.filetypes,
            cmd = lexical.cmd,
            root_dir = lexical.root_dir,
          },
        }
        -- returns false to use the set-up from lazy.vim with lspconfig
        -- (adds capabilities key, executes lspconfig.lexical.setup(opts))
        return false
      end,
    },
  },
}
