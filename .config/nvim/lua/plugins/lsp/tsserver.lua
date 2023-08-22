return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        -- mason = false, -- do not set up with mason
        -- setup = true,
        root_dir = require("lspconfig").util.root_pattern("package.json"),
        single_file_support = false,
      },
    },
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
    },
  },
}
