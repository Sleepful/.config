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
          require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = nil,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = true,
        title = true,
      })

      -- Setup keymaps
      -- vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    end,
    keys = { {
      "K",
      function()
        local api = vim.api
        local hover_win = vim.b.hover_preview
        if hover_win and api.nvim_win_is_valid(hover_win) then
          api.nvim_set_current_win(hover_win)
        else
          require("hover").hover()
        end
      end,
      desc = "Hover.nvim",
    }, {
      "gk",
      function()
        require("hover").hover_select()
      end,
      desc = "Hover.nvim (select)",
    } },
  },
}
