-- NOTE: abort Cmp completion with <C-e> to use <Tab> with LuaSnip
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    keys = {
      {
        "<leader>S",
        desc = "LuaSnip",
      },
      {
        "<leader>SS",
        function()
          require("luasnip.loaders").edit_snippet_files({})
        end,
        desc = "List all marks!",
      },
    },
    opts = {
      region_check_events = "InsertEnter",
    },
    config = function(LazyPlugin, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").load({
        paths = "~/.config/nvim/lua/plugins/snippets",
        -- not working to override friendly_snippes, probably because of CMP sorting:
        override_priority = 100000,
        default_priority = 100000,
      })
      -- add "markdown" snippets to "telekasten" filetype
      require("luasnip").filetype_extend("telekasten", { "markdown" })
    end,
  },
}
