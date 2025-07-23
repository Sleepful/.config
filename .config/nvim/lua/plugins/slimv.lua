return {
  {
    "ludovicchabant/vim-gutentags",
    -- seems like slimv manages tags just fine without any help, just compile the files so swank knows about the definitions
    enabled = false,
    ft = "lisp",
    config = function()
      -- https://github.com/ludovicchabant/vim-gutentags/blob/master/doc/gutentags.txt#L329
      -- vim.g.gutentags_project_root = 2
      -- vim.g.gutentags_ctags_extra_args = { '--tag-relative' }
    end,
  },
  -- {
  --   "craigemery/vim-autotag",
  --   ft = "lisp",
  -- },
  {
    -- enabled = false,
    ft = "lisp",
    "kovisoft/slimv",
    config = function()
      -- https://github.com/kovisoft/slimv/blob/master/doc/paredit.txt#L96
      vim.g.paredit_mode = 0
      vim.g.slimv_keybindings = 2
      vim.g.slimv_completions = "fuzzy" -- as opposed to "simple"
      -- vim.g.slimv_tags_file = "tags"
      -- vim.g.slimv_ctags = "" -- disable the tags to manage them through gutentags
      -- vim.g.slime_input_pid = false
      -- vim.g.slime_suggest_default = true
    end,
    keys = {
      { ",u", "<Cmd>:call SlimvFindDefinitions()<Cr>", desc = "Find definition" },
      { ";",  "<Cmd>:Telescope menu slimv<Cr>",        desc = "Telescope menu" },
    },
    init = function()
      require('which-key').add {
        { ",e", group = "Evaluation" },
        { ",d", group = "Debug/Documentation" },
        { ",s", group = "Stepper" },
        { ",c", group = "Compile" },
        { ",m", group = "Macro" },
        { ",x", group = "Cross Reference" },
        { ",p", group = "Profile" },
        { ",r", group = "Repl" },
        { ",f", group = "Find" },
      }
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          vim.cmd("set omnifunc=SlimvOmniComplete")
        end,
        pattern = { "REPL", "*.lisp" }
      })
    end
  }
}
