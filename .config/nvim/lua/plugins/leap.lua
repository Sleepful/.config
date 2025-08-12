return {
  {
    "Sleepful/leap-by-word.nvim",
    dependencies = { "ggandor/leap.nvim", "ggandor/leap-spooky.nvim" },
    -- dev = true,
    keys = { {
      "s",
      function()
        require("leap-by-word").leap()
      end,
      mode = { "x", "n" },
      desc = "Leap by word first letter",
    }, {
      "s",
      function()
        require("leap-by-word").EXPERIMENTAL_spooky_leap(nil, { paste_on_remote_yank = true })
      end,
      mode = { "o" },
      desc = "Spooki",
    } }
  },
  {
    "ggandor/leap.nvim",
    config = function()
      -- empty config is necessary for `keys` to work (???)
    end,
    keys = {
      {
        "z",                              -- removes the folding key, meh (create folds, etc)
        require("plugins.leap.vertical"), -- this is my custom jump
        mode = { "n", "x", "o" },
        desc = "Leap vertical to",
      },
      {
        "zf", -- annoying default: "Create fold"
        "<Nop>",
        mode = { "n", "x", "o" },
      },
      {
        "f",
        function()
          require('leap').leap({})
        end,
        desc = "Standard leap"
      },
      {
        "F",
        function()
          require('leap').leap({ backward = true })
        end,
        desc = "Standard leap"
      },
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
    },
  },
  {
    "ggandor/flit.nvim", -- included with lazyvim, but this is default config for flit:
    dependencies = "ggandor/leap.nvim",
    enabled = false,
    opts = {
      -- from docs:
      keys = {
        f = "f",
        F = "F",
        t = "t",
        T = "T"
      },
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
