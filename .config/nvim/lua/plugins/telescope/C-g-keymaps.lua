local cgLeader = "<F2>" -- used to be <C-g>

return {
  cgLeader = cgLeader,
  file_browser = {
    cgLeader .. "d",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    desc = "📁 Directory",
  },
  neoclip = {
    cgLeader .. "n",
    "<cmd>Telescope neoclip plus extra=0<cr>",
    desc = "👻 neoClip",
  },
  fuzzy_current_buffer = {
    cgLeader .. "p",
    function()
      require("telescope.builtin").current_buffer_fuzzy_find({
        -- tiebreak function from
        -- https://github.com/nvim-telescope/telescope.nvim/pull/1401#issuecomment-957234973
        tiebreak = function(entry1, entry2, prompt)
          local start_pos1, _ = entry1.ordinal:find(prompt)
          if start_pos1 then
            local start_pos2, _ = entry2.ordinal:find(prompt)
            if start_pos2 then
              return start_pos1 < start_pos2
            end
          end
          return false
        end,
        additional_args = { "--ignore-case", "--pcre2" },
      })
    end,
    desc = "💤 fuzzy buffer",
  },
  fuzzy_open_buffers = {
    cgLeader .. "o",
    function()
      require("telescope.builtin").grep_string({
        grep_open_files = true,
        additional_args = { "--ignore-case", "--pcre2" },
      })
    end,
    desc = "💤 fuzzy all buffers",
  },
  grep_open_buffers = {
    cgLeader .. "O",
    function()
      require("telescope.builtin").live_grep({
        grep_open_files = true,
        additional_args = { "--ignore-case", "--pcre2" },
      })
    end,
    desc = "🪄 grep all buffers",
  },
  grep_current_buffer = {
    cgLeader .. "P",
    function()
      require("telescope.builtin").live_grep({
        search_dirs = { vim.fn.expand("%:p") },
      })
    end,
    desc = "🪄 grep buffer",
  },
  vim_bookmarks = {
    page = {
      cgLeader .. cgLeader,
      "<cmd>Telescope vim_bookmarks current_file<cr>",
      desc = "📘 Bookmarks in buffer",
    },
    all = {
      cgLeader .. "a",
      "<cmd>Telescope vim_bookmarks all<cr>",
      desc = "📘 All Bookmarks",
    },
  },
  marks = {
    cgLeader .. "m",
    function()
      require("telescope.builtin").marks()
    end,
    desc = "vim marks",
  },
  neotree = {
    rg = {
      cgLeader .. "<C-t>",
      desc = "🌳 grep Tree!",
    },
  },
  pathogen = {
    fuzzy = {
      cgLeader .. "l",
      function()
        local opts = {
          cwd = require("telescope.utils").buffer_dir(),
          additional_args = { "--ignore-case", "--pcre2" },
        }
        require("telescope").extensions["pathogen"].grep_string(opts)
      end,
      desc = "⚡️ Pathogen this word",
    },
    grep = {
      cgLeader .. "/",
      function()
        local opts = {
          cwd = require("telescope.utils").buffer_dir(),
        }
        require("telescope").extensions["pathogen"].live_grep(opts)
      end,
      desc = "⚡️ Pathogen Grep",
    },
    files = {
      cgLeader .. "f",
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
      cgLeader .. "f",
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
