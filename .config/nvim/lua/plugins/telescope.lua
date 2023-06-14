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
  { "sleepful/telescope-pathogen.nvim" },
  { "nvim-telescope/telescope-symbols.nvim" },
  {
    -- TODO: neoclip needs better sorting on its results
    -- has weird keybindgs for now (C-p in insert, leader+y in normal)
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
            -- need to use lowercase c so that it properly
            -- overrides the default mapping in lazyvim
            ["<c-t>"] = require("telescope.actions").to_fuzzy_refine,
          },
          n = {
            ["<C-u>"] = require("telescope.actions").results_scrolling_up,
            ["<C-d>"] = require("telescope.actions").results_scrolling_down,
            ["<C-f>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-b>"] = require("telescope.actions").preview_scrolling_down,
            -- need to use lowercase c so that it properly
            -- overrides the default mapping in lazyvim
            ["<c-t>"] = require("telescope.actions").to_fuzzy_refine,
          },
        },
      },
    },
    keys = {

      { -- same as <leader>sw
        "<leader>?",
        Util.telescope("grep_string", { additional_args = { "--ignore-case" } }),
        desc = "Fuzzy Word (root dir)",
      },
      --- <C-g> keymaps
      require("plugins.telescope.C-g-keymaps").neoclip,
      require("plugins.telescope.C-g-keymaps").pathogen.fuzzy,
      require("plugins.telescope.C-g-keymaps").pathogen.grep,
      require("plugins.telescope.C-g-keymaps").pathogen.files,
      require("plugins.telescope.C-g-keymaps").fuzzy_current_buffer,
      require("plugins.telescope.C-g-keymaps").grep_open_buffers,
      require("plugins.telescope.C-g-keymaps").fuzzy_open_buffers,
      require("plugins.telescope.C-g-keymaps").grep_current_buffer,

      require("plugins.telescope.C-g-keymaps").grep_harpoon_filenames,
      require("plugins.telescope.C-g-keymaps").harpoon_menu,
      require("plugins.telescope.C-g-keymaps").grep_harpoon_files,
      -- Custom keymaps
      {
        -- help pages, moved from `leader sh`
        "<leader>smh",
        "<cmd>Telescope help_tags<cr>",
        desc = "help pages",
      },
      {
        "<leader>sR",
        "<cmd>Telescope symbols<cr>",
        desc = "Symbols",
      },
      {
        "<leader>se",
        function()
          require("telescope.builtin").symbols({ sources = { "emoji" } })
        end,
        desc = "Emojis 🤪",
      },
      {
        "<leader>sk",
        function()
          require("telescope.builtin").symbols({ sources = { "kaomoji", "gitmoji" } })
        end,
        desc = "GitKao moji ⚗️ ",
      },
      -- more
      { "<leader>smn", "<cmd>Telescope notify<cr>", desc = "Notify messages" },
      -- search
      { "<leader>sa" },
      { "<leader>sma", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      {
        "<leader>sC",
        -- remove default "Commands"
      },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>smc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sH" },
      { "<leader>smH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>smk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM" },
      { "<leader>smM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm" },
      { "<leader>smj", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so" },
      { "<leader>smo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>ss", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sG",
      },
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
