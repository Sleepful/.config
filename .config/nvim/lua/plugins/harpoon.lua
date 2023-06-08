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

return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>hs",
        live_grep_harpoon_files,
        desc = "🐡 Big one incoming!",
      },
      {
        "<leader>hf",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "🎣 Where is my fishing rod?",
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
        desc = "🐟 Give them to me!",
      },
      {
        "<C-g>h",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "🐟 Give them to me!",
      },

      {
        "",
        function()
          require("harpoon.ui").nav_prev()
        end,
      },
      {
        "",
        function()
          require("harpoon.ui").nav_next()
        end,
      },
      {
        "<S-F10>",
        function()
          require("harpoon.mark").add_file()
        end,
      },
      {
        "<S-F1>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
      },
      {
        "<S-F2>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
      },
      {
        "<S-F3>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
      },
      {
        "<S-F4>",
        function()
          require("harpoon.ui").nav_file(4)
        end,
      },
      {
        "<S-F5>",
        function()
          require("harpoon.ui").nav_file(5)
        end,
      },
      {
        "<S-F6>",
        function()
          require("harpoon.ui").nav_file(6)
        end,
      },
      {
        "<S-F7>",
        function()
          require("harpoon.ui").nav_file(7)
        end,
      },
      {
        "<S-F8>",
        function()
          require("harpoon.ui").nav_file(8)
        end,
      },
      {
        "<S-F9>",
        function()
          require("harpoon.ui").nav_file(9)
        end,
      },
    },
  },
}
