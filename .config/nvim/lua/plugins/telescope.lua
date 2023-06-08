local Util = require("lazyvim.util")

-- Good candidates for removal:
-- <leader>..
-- sm -> jump to mark: marks are really bad in vim,
-- sH -> search highlight groups: why tho?
-- all the funny searches ... can go into their own sub-key to declutter
--  autocmds, keymaps, manpages, cmds, diagnostics, etc
--
-- TODO:
-- [ ] - add telescope command to search directories, then re_use this
-- function to implement foos without having to open buffers or stand on neotree:
-- example: [ ] - spectre search by directory
-- https://github.com/nvim-pack/nvim-spectre#custom-functions

return {
  { "kkharji/sqlite.lua" },
  { "brookhong/telescope-pathogen.nvim" },
  { "nvim-telescope/telescope-symbols.nvim" },
  {
    "AckslD/nvim-neoclip.lua",
    config = function(LazyV, opts)
      require("neoclip").setup(opts)
    end,
    opts = {
      enable_persistent_history = true,
      continuous_sync = true,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "telescope-pathogen.nvim" },
      { "telescope-symbols.nvim" },
      { "AckslD/nvim-neoclip.lua" },
    },
    config = function(LazyPlugin, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("harpoon")
      require("telescope").load_extension("neoclip")
      require("telescope").load_extension("pathogen")
      vim.keymap.set("v", "<space>g", require("telescope").extensions["pathogen"].grep_string)
    end,
    opts = {
      defaults = {
        layout_strategy = "vertical",
        enable_preview = true,
        layout_config = {
          mirror = true,
          prompt_position = "top",
          vertical = {
            width = { padding = 0 },
            height = { padding = 0 },
            preview_cutoff = 2,
            preview_height = 5,
          },
        },
        sorting_strategy = "ascending",
        winblend = 0,
        scroll_strategy = "limit",
        mappings = {
          i = {
            ["<C-u>"] = require("telescope.actions").results_scrolling_up,
            ["<C-d>"] = require("telescope.actions").results_scrolling_down,
            ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
          n = {
            ["<C-u>"] = require("telescope.actions").results_scrolling_up,
            ["<C-d>"] = require("telescope.actions").results_scrolling_down,
            ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
          },
        },
      },
    },
    key = {
      {
        "gy",
      },
      {
        "<leader>y",
        "<cmd>Telescope neoclip plus<cr>",
        desc = "👻 Neoclip",
      },
      {
        "gy",
        "<cmd>Telescope neoclip plus<cr>",
        desc = "👻 Neoclip",
      },
      {
        -- help pages, moved from `leader sh`
        "<leader>smh",
        "<cmd>Telescope help_tags<cr>",
        desc = "help pages",
      },
      {
        "<leader>sms",
        "<cmd>Telescope symbols<cr>",
        desc = "Symbols 🤪",
      },
      -- search
      { "<leader>sa" },
      { "<leader>sma", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sC", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>smc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sH" },
      { "<leader>smH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk" },
      { "<leader>smk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM" },
      { "<leader>smM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm" },
      { "<leader>smj", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so" },
      { "<leader>smo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      -- {
      --   "<leader>t",
      --   desc = "Telescope",
      -- },
      -- currently a lot inside the `s` key
      -- default search/find functionality from lazy vim always goes to `root_dir`,
      -- it looks like `cwd` defaults to `root_dir`
      -- not sure if I misunderstand the `cwd` or whut, but lets overwrite them
      -- probably due to the pick between git_files and find_files
      {
        -- TODO: override "<leader>ff" because there is also "<leader><space>", redundant
        -- - [ ] also add a hotkey to update the CWD to traverse up the directory structure
        -- ADVANCED:
        -- - [ ] add hotkey that sends files to live_grep
        --  - marked files or all? maybe both like quickfix list
        -- - [ ] and add another hotkey to traverse into the directory structure for good measure, this one requires an arg, how to?
        --  - perhaps the arg to this one is currently selected file, derive the 1 level traversal from there
        -- - [ ] and for extra good measure, add a hotkey that resets the traversal to the leaf directory of currently highlit file
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "🔎 Find Files (cwd)",
      },
      {
        -- this one includes parent dir, unlike <leader>ff which does not
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = vim.fs.dirname(vim.fn.expand("%:p:h")),
          })
        end,
        desc = "🔎 Find Files (parent dir)",
      },
      -- TODO: also replace
      -- - [x] "<leader>sg", -> real live_grep cwd
      -- because they all do a grep on root dir, one of them says CWD but fails :shrug:
      -- because they are redundant and all do the same as "<leader>/"
      -- add:
      -- - [ ] live_grep on files in harpoon list
      --
      -- TODO: Add a `live_grep` inside open buffers
      -- - [x] <leader>sb
      {
        "<leader>ss",
        function()
          require("telescope.builtin").live_grep({
            cwd = require("telescope.utils").buffer_dir(),
          })
        end,
        desc = "🔍 Live Grep (cwd)",
      },
      {
        "<leader>sG", -- just delete default binding, useless
      },
      {
        -- changes from default <leader>sb binding
        "<leader>sc",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "🔍 Fuzzy search (current buffer)",
      },
      {
        "<leader>so",
        function()
          require("telescope.builtin").live_grep({
            grep_open_files = true,
          })
        end,
        desc = "🔍 Live Grep (open buffers)",
      },
      { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>sls",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      { "<leader>sS" },
      {
        "<leader>slS",
        Util.telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
      -- NOTE: the same as default lazy vim afaik
      -- TODO: replace with live_grep_args plugin for telescope, or add a hotkey that upgrades a live_grep to live_grep_args?
      { "<leader>/", Util.telescope("live_grep"), desc = "Live Grep (root)" },
      {
        "<leader>uC",
        function()
          require("telescope.builtin")["colorscheme"]({
            layout_strategy = "horizontal",
            enable_preview = true,
            layout_config = {
              prompt_position = "bottom",
              horizontal = {
                width = { padding = 0 },
                height = { padding = 0 },
                preview_cutoff = 20,
                preview_height = 10,
              },
            },
          })
        end,
        desc = "Colorscheme with preview",
      },
    },
  },
}
