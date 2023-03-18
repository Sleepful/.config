return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      elixirls = {
        mason = false,
        cmd = { "/Users/jose/Code/GitBuilds/elixir-ls/release-Elixir-1.14.3-OTP-25/language_server.sh" },
        autostart = false,
      },
    },
  },
}
