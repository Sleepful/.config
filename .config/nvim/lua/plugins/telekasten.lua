return {
  -- NOTE: for peek.nvim to work/build I had to run:
  -- cd ~/.local/share/nvim/lazy/peek.nvim && deno task build:debug
  -- https://github.com/toppair/peek.nvim/issues/11#issuecomment-1491297809
  {
    "toppair/peek.nvim",
    opts = { app = "browser", filetype = { "markdown", "telekasten" } },
    build = "deno task --quiet build:fast",
  },
  { "renerocksai/calendar-vim" },
  {
    -- "sleepful/telekasten.nvim",
    "renerocksai/telekasten.nvim",
    -- dev = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = require("plugins.kasten.functions").default_opts,
    keys = {
      -- { "<leader>t", "<Cmd>Telekasten panel<CR>", desc = "Telekasten" },
      { "<leader>k",  desc = "Telekasten" },
      { "<leader>kp", "<Cmd>Telekasten panel<CR>" },
      { "<leader>kf", "<cmd>Telekasten find_notes<CR>" },
      { "<leader>kg", "<cmd>Telekasten search_notes<CR>" },
      { "<leader>kd", "<cmd>Telekasten goto_today<CR>" },
      { "<leader>kw", "<cmd>Telekasten goto_thisweek<CR>" },
      { "<leader>kz", "<cmd>Telekasten follow_link<CR>" },
      { "<leader>kn", "<cmd>Telekasten new_note<CR>" },
      { "<leader>ky", "<cmd>Telekasten yank_notelink<CR>" },
      { "<leader>kc", "<cmd>Telekasten show_calendar<CR>" },
      { "<leader>kb", "<cmd>Telekasten show_backlinks<CR>" },
      { "<leader>kB", "<cmd>Telekasten find_friends<CR>" },
      { "<leader>kr", "<cmd>Telekasten rename_note<CR>" },
      { "<leader>k#", "<cmd>Telekasten show_tags<CR>" },
      { "<leader>kI", "<cmd>Telekasten insert_img_link<CR>" },
      { "<leader>kl", "<cmd>Telekasten insert_link<CR>" },
      {
        "<leader>kt",
        function()
          require("telekasten").toggle_todo({ v = true })
        end,
        mode = { "n", "v" },
        desc = "Toggle todo",
      },
      { "<leader>kv", "<cmd>Telekasten switch_vault<CR>" },
      {
        "<leader>kc",
        function()
          local dirs = vim.split(require("telekasten").Cfg.home, "/")
          local last = dirs[#dirs]
          local prev_last = dirs[#dirs - 1]
          print(prev_last .. "/" .. last)
        end,
        desc = "Current vault",
      },
    },
  },
}
