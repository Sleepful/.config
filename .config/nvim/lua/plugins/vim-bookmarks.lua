local K = require("keys")

-- function to have bookmarks per workdir per buffer
-- taken from official docs iirc
local vim_bookmarks_fun = [[
" Finds the Git super-project directory based on the file passed as an argument.
function! g:BMBufferFileLocation(file)
    let filename = 'vim-bookmarks'
    let location = ''
    if isdirectory(fnamemodify(a:file, ":p:h").'/.git')
        " Current work dir is git's work tree
        let location = fnamemodify(a:file, ":p:h").'/.git'
    else
        " Look upwards (at parents) for a directory named '.git'
        let location = finddir('.git', fnamemodify(a:file, ":p:h").'/.;')
    endif
    if len(location) > 0
        return simplify(location.'/.'.filename)
    else
        return simplify(fnamemodify(a:file, ":p:h").'/.'.filename)
    endif
endfunction
]]

require("which-key").add({ "<leader>e", group = 'Bookmarks' })

return {
  { -- https://github.com/chentoast/marks.nvim
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require 'marks'.setup {
        -- whether to map keybinds or not. default true
        default_mappings = false,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {}
      }
    end,
    keys = {
      {
        -- I did not like the preview too much:
        -- require("plugins.telescope.C-g-keymaps").cgLeader .. "i",
        "<leader>ep",
        "<Plug>(Marks-preview)",
        desc = "📙 Preview vim marks"
      },
      {
        "<leader>el",
        "<Plug>(Marks-deleteline)",
        desc = "📙 Delete line"
      },
      {
        "<leader>ed",
        "<Plug>(Marks-deletebuf)",
        desc = "📙 Delete buffer marks"
      }
    }
  },
  {
    "MattesGroeger/vim-bookmarks",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
    },
    lazy = false,
    init = function()
      vim.g.bookmark_manage_per_buffer = 1
      vim.g.bookmark_auto_save = 1
      vim.g.bookmark_no_default_key_mappings = 1
      vim.cmd(vim_bookmarks_fun)
      require("telescope").load_extension("vim_bookmarks")
    end,
    -- the key to set bookmarks is `mm`
    -- https://github.com/MattesGroeger/vim-bookmarks#usage
    keys = {
      {
        "<leader>eb",
        "<cmd>Telescope vim_bookmarks current_file<cr>",
        desc = "📘 Bookmarks in buffer (tele)",
      },
      {
        "<leader>et",
        "<cmd>Telescope vim_bookmarks all<cr>",
        desc = "📘 All Bookmarks (tele)",
      },
      {
        "<leader>ee", "<Plug>BookmarkToggle", desc = "📗 Set bookmark (toggle)",
      },
      { "<leader>ec", "<Plug>BookmarkAnnotate", desc = "📗 annotate with comment" },
      { "<leader>ea", "<Plug>BookmarkShowAll", desc = "📗 all qf" },
      -- { "<leader>ej",  "<Plug>BookmarkNext",       desc = "next" },
      -- { "<leader>ek",  "<Plug>BookmarkPrev",       desc = "prev" },
      { "<leader>ed", "<Plug>BookmarkClear", desc = "📗 clear buffer" },
      { "<leader>ex", "<Plug>BookmarkClearAll", desc = "📗 clear all" },
      -- { "<leader>ekk", "<Plug>BookmarkMoveUp",     desc = "move up" },
      -- { "<leader>ejj", "<Plug>BookmarkMoveDown",   desc = "move down" },
      -- { "<leader>eg",  "<Plug>BookmarkMoveToLine", desc = "move to line" },
    },
  },
}
