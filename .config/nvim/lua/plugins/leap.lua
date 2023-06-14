return {
  {
    "ggandor/leap.nvim",
    config = function()
      -- empty config is necessary for `keys` to work (???)
    end,
    keys = {
      {
        "s",
        function()
          -- all windows search (includes bidirectional search) per docs
          local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0))
          require("leap").leap({ target_windows = focusable_windows_on_tabpage })
        end,
        mode = { "n", "x", "o" },
        desc = "Leap forward to",
      },
      {
        "S",
        require("plugins.leap.vertical"),
        mode = { "n", "x", "o" },
        desc = "Leap vertical to",
      },
      {
        "<C-k>",
        mode = { "n", "x", "o" },
        function()
          require("plugins.leap.word")("upwards")
        end,
        desc = "Leap by word upwards",
      },
      {
        "<C-j>",
        mode = { "n", "x", "o" },
        function()
          require("plugins.leap.word")("downwards")
        end,
        desc = "Leap by word downwards",
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
  { "ggandor/leap-spooky.nvim", dependencies = "ggandor/leap.nvim", opts = {} },
}
