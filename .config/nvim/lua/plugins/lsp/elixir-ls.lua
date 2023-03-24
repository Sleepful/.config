local root_dir = function(fname)
  local lspconfig = require("lspconfig")
  local root = lspconfig.util.root_pattern(".git")(fname) or vim.loop.os_homedir()
  return root
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      elixirls = {
        mason = false,
        cmd = { "/Users/jose/Code/GitBuilds/elixir-ls/release-Elixir-1.14.3-OTP-25/language_server.sh" },
        autostart = false,
        root_dir = root_dir,
      },
    },
  },
}
