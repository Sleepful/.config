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
  neoclip = {
    "<C-g>y",
    "<cmd>Telescope neoclip plus<cr>",
    desc = "👻 Neoclip",
  },
  pathogen_fuzzy = {
    "<C-g>w",
    function()
      local opts = {
        cwd = require("telescope.utils").buffer_dir(),
      }
      require("telescope").extensions["pathogen"].grep_string(opts)
    end,
    "<cmd>Telescope pathogen live_grep<cr>",
    desc = "⚡️ Pathogen Fuzzy",
  },
  pathogen_grep = {
    "<C-g>r",
    function()
      local opts = {
        cwd = require("telescope.utils").buffer_dir(),
      }
      require("telescope").extensions["pathogen"].live_grep(opts)
    end,
    desc = "⚡️ Pathogen Grep",
  },
  fuzzy_current_buffer = {
    "<C-g>z",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    desc = "🔍 Fuzzy here",
  },
  fuzzy_open_buffers = {
    "<C-g><C-z>",
    function()
      require("telescope.builtin").grep_string({
        grep_open_files = true,
      })
    end,
    desc = "🔍 Fuzzy buffers",
  },
  grep_open_buffers = {
    "<C-g>b",
    function()
      require("telescope.builtin").live_grep({
        grep_open_files = true,
      })
    end,
    desc = "🔍 Grep buffers",
  },
  grep_current_buffer = {
    "<C-g><C-b>",
    function()
      require("telescope.builtin").live_grep({
        search_dirs = { vim.fn.expand("%:p") },
      })
    end,
    desc = "🔍 Grep here",
  },
  grep_harpoon_filenames = {
    "<C-g>f",
    "<cmd>Telescope harpoon marks<cr>",
    desc = "🎣 Files",
  },
  harpoon_menu = {
    "<C-g>h",
    function()
      require("harpoon.ui").toggle_quick_menu()
    end,
    desc = "🎣 Menu",
  },
  grep_harpoon_files = {
    "<C-g>s",
    live_grep_harpoon_files,
    desc = "🎣 Grep",
  },
  obsolete = {
    {
      -- TODO: override "<leader>ff" because there is also "<leader><space>", redundant
      -- - [ ] also add a hotkey to update the CWD to traverse up the directory structure
      -- ADVANCED:
      -- - [ ] add hotkey that sends files to live_grep
      --  - marked files or all? maybe both like quickfix list
      -- - [ ] and add another hotkey to traverse into the directory structure for good measure, this one requires an arg, how to?
      --  - perhaps the arg to this one is currently selected file, derive the 1 level traversal from there
      -- - [ ] and for extra good measure, add a hotkey that resets the traversal to the leaf directory of currently highlit file
      "<C-g>f",
      function()
        require("telescope.builtin").find_files({
          cwd = require("telescope.utils").buffer_dir(),
        })
      end,
      desc = "🔎 Find Files (cwd)",
    },
    {
      "<leader>ss",
      function()
        require("telescope.builtin").live_grep({
          cwd = require("telescope.utils").buffer_dir(),
        })
      end,
      desc = "🔍 Live Grep (cwd)",
    },
  },
}
