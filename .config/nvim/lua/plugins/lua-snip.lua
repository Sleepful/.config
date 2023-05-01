-- NOTE: abort Cmp completion with <C-e> to use <Tab> with LuaSnip
return {
  {
    "L3MON4D3/LuaSnip",
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
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/plugins/snippets" })
    end,
  },
  -- grabbed this from LAZYVIM examples:
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "mattn/emmet-vim",
      "sleepful/cmp-emmet-vim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-l>"] = cmp.mapping.complete({
          config = {
            sources = {
              -- Add Emmet from dcampos/cmp-emmet-vim
              {
                name = "emmet_vim",
                option = {
                  -- elixir because Heex sometimes doesn't ID the HTML under cursor
                  filetypes = { "elixir" },
                },
              },
            },
          },
        }),
      })
    end,
  },
}
