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
    "<C-g>c",
    "<cmd>Telescope neoclip plus<cr>",
    desc = "👻 neoClip",
  },
  fuzzy_current_buffer = {
    "<C-g>p",
    "<cmd>Telescope current_buffer_fuzzy_find<cr>",
    desc = "💤 lazy Page",
  },
  fuzzy_open_buffers = {
    "<C-g>o",
    function()
      require("telescope.builtin").grep_string({
        grep_open_files = true,
        { additional_args = { "--ignore-case" } },
      })
    end,
    desc = "💤 lazy Open buffers",
  },
  grep_open_buffers = {
    "<C-g><C-o>",
    function()
      require("telescope.builtin").live_grep({
        grep_open_files = true,
      })
    end,
    desc = "🪄 grep Open buffers",
  },
  grep_current_buffer = {
    "<C-g><C-p>",
    function()
      require("telescope.builtin").live_grep({
        search_dirs = { vim.fn.expand("%:p") },
      })
    end,
    desc = "🪄 grep Page",
  },
  grep_harpoon_filenames = {
    "<C-g>q",
    "<cmd>Telescope harpoon marks<cr>",
    desc = "🎣 Quick menu",
  },
  harpoon_menu = {
    "<C-g>m",
    function()
      require("harpoon.ui").toggle_quick_menu()
    end,
    desc = "🎣 Menu",
  },
  grep_harpoon_files = {
    "<C-g>s",
    live_grep_harpoon_files,
    desc = "🎣 Shark grep",
  },
  vim_bookmarks = {
    page = {
      "<C-g>b",
      "<cmd>Telescope vim_bookmarks current_file<cr>",
      desc = "📘 Bookmarks ",
    },
    all = {
      "<C-g>a",
      "<cmd>Telescope vim_bookmarks all<cr>",
      desc = "📚 All bookmarks",
    },
  },
  neotree = {
    rg = {
      "<C-g><C-t>",
      desc = "🌳 grep Tree!",
    },
  },
  pathogen = {
    fuzzy = {
      "<C-g>rl",
      function()
        local opts = {
          cwd = require("telescope.utils").buffer_dir(),
          additional_args = { "--ignore-case" },
        }
        require("telescope").extensions["pathogen"].grep_string(opts)
      end,
      "<cmd>Telescope pathogen live_grep<cr>",
      desc = "⚡️ Pathogen Lazy",
    },
    grep = {
      "<C-g>rg",
      function()
        local opts = {
          cwd = require("telescope.utils").buffer_dir(),
        }
        require("telescope").extensions["pathogen"].live_grep(opts)
      end,
      desc = "⚡️ Pathogen Grep",
    },
    files = {
      "<C-g>rf",
      function()
        local opts = {
          cwd = require("telescope.utils").buffer_dir(),
        }
        require("telescope").extensions["pathogen"].find_files(opts)
      end,
      desc = "⚡️ Pathogen Files",
    },
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
