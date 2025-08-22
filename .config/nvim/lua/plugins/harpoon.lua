local function prepare_harpoon_results()
  local list = require("harpoon").get_mark_config().marks
  local next = {}
  for idx = 1, #list do
    if list[idx].filename ~= "" then
      local path = vim.loop.cwd() .. "/" .. list[idx].filename
      table.insert(next, path)
      print(path)
    end
  end
  return next
end

local live_grep_harpoon_files = function()
  require("telescope.builtin").live_grep({
    search_dirs = prepare_harpoon_results(),
  })
end

require("which-key").add({ "<leader>h", group = 'Harpoon' })

return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>hs",
        live_grep_harpoon_files,
        desc = "🐡 Big one incoming! (live grep)",
      },
      {
        "<leader>ht",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "🎣 Where is my fishing rod? (telescope files)",
      },
      {
        "<leader>h",
        desc = "Harpoon",
      },
      {
        "<leader>hh",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "🐟 Give them to me! (show list)",
      },
      {
        "<leader>ha",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Add file to harpoon list",
      },
      -- TODO: kill all buffers that are not harpoon
      --
      -- NOTE: commented out over preference for bufferline keys
      -- {
      --   "",
      --   function()
      --     require("harpoon.ui").nav_prev()
      --   end,
      -- },
      -- {
      --   "",
      --   function()
      --     require("harpoon.ui").nav_next()
      --   end,
      -- },
      -- {
      --   "<M-0>",
      --   function()
      --     require("harpoon.ui").nav_file(99)
      --   end,
      -- },
      -- <F7><F8><F9>
      -- <F7><F8><F9><F4><F5><F6>
      {
        "<F7>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "<F8>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "<F9>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "<F4>",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
      {
        "<F5>",
        function()
          require("harpoon.ui").nav_file(5)
        end,
      },
      {
        "<F6>",
        function()
          require("harpoon.ui").nav_file(6)
        end,
      },
      -- {
      --   "<M-7>",
      --   function()
      --     require("harpoon.ui").nav_file(7)
      --   end,
      -- },
      -- {
      --   "<M-8>",
      --   function()
      --     require("harpoon.ui").nav_file(8)
      --   end,
      -- },
      -- {
      --   "<M-9>",
      --   function()
      --     require("harpoon.ui").nav_file(9)
      --   end,
      -- },
    },
  },
}
