return {
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          -- Require providers
          require("hover.providers.lsp")
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
      })

      -- Setup keymaps
      -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end,
    keys = { {
      "gk",
      function()
        require("hover").hover_select()
      end,
      desc = "Hover.nvim (select)",
    } },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", require("hover").hover, desc = "Hover.nvim" }
    end,
  },
}
