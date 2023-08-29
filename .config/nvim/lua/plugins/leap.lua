return {
  {
    "ggandor/leap.nvim",
    config = function()
      -- empty config is necessary for `keys` to work (???)
    end,
    keys = {
      -- {
      --   "S",
      --   function()
      --     -- all windows search (includes bidirectional search) per docs
      --     local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
      --       return vim.api.nvim_win_get_config(win).focusable
      --     end, vim.api.nvim_tabpage_list_wins(0))
      --     require("leap").leap({ target_windows = focusable_windows_on_tabpage })
      --   end,
      --   mode = { "n", "x", "o" },
      --   desc = "Leap forward to",
      -- },
      {
        "s",
        require("plugins.leap.vertical"),
        mode = { "n", "x", "o" },
        desc = "Leap vertical to",
      },
      {
        "S",
        function()
          require("plugins.leap.word")("both")
        end,
        mode = { "n", "x", "o" },
        desc = "Leap by word first letter",
      },
      -- {
      --   "<C-k>",
      --   function()
      --     require("plugins.leap.word")("upwards")
      --   end,
      --   mode = { "n", "x", "o" },
      --   desc = "Leap by word upwards",
      -- },
      -- {
      --   "<C-j>",
      --   function()
      --     require("plugins.leap.word")("downwards")
      --   end,
      --   mode = { "n", "x", "o" },
      --   desc = "Leap by word downwards",
      -- },
      {
        "<C-w>e",
        require("plugins.leap.window"),
        desc = "Leap to window",
      },
      {
        "<C-w><C-e>",
        require("plugins.leap.window"),
        desc = "Leap to window",
      },
      {
        "<C-e>",
        mode = { "i" },
        require("plugins.leap.window"),
        desc = "Leap to window",
      },
    },
  },
  {
    "ggandor/flit.nvim", -- included with lazyvim, but this is default config for flit:
    dependencies = "ggandor/leap.nvim",
    opts = {
      -- from docs:
      keys = { f = "f", F = "F", t = "t", T = "T" },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "nvo",
      multiline = true,
      -- Like `leap`s similar argument (call-specific overrides).
      -- E.g.: opts = { equivalence_classes = {} }
      opts = {},
    },
  },
  {
    "ggandor/leap-spooky.nvim",
    dependencies = "ggandor/leap.nvim",
    commit = "b9dcc30866e6b916b2d8f3e2f3d6a2c207fffd73",
    config = function()
      require("leap-spooky").setup({
        affixes = {
          -- Mappings will be generated corresponding to all native text objects,
          -- like: (ir|ar|iR|aR|im|am|iM|aM){obj}.

          -- Special line objects will also be added, by repeating the affixes.
          -- E.g. `yrr<leap>` and `ymm<leap>` will yank a line in the current
          -- window.

          -- The cursor moves to the targeted object, and stays there.
          magnetic = { window = "m", cross_window = "M" },
          -- The operation is executed seemingly remotely (the cursor boomerangs
          -- back afterwards).
          remote = { window = "r", cross_window = "R" },
        },
        -- Defines text objects like `riw`, `raw`, etc., instead of
        -- targets.vim-style `irw`, `arw`.
        prefix = false,
        -- The yanked text will automatically be pasted at the cursor position
        -- if the unnamed register is in use.
        paste_on_remote_yank = false,
      })
    end,
  },
}
