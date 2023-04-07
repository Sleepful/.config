-- all the requires and stuff from luasnip docs:
local snips = function()
  local ls = require("luasnip")
  local s = ls.snippet
  local sn = ls.snippet_node
  local isn = ls.indent_snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local c = ls.choice_node
  local d = ls.dynamic_node
  local r = ls.restore_node
  local events = require("luasnip.util.events")
  local ai = require("luasnip.nodes.absolute_indexer")
  local extras = require("luasnip.extras")
  local l = extras.lambda
  local rep = extras.rep
  local p = extras.partial
  local m = extras.match
  local n = extras.nonempty
  local dl = extras.dynamic_lambda
  local fmt = require("luasnip.extras.fmt").fmt
  local fmta = require("luasnip.extras.fmt").fmta
  local conds = require("luasnip.extras.expand_conditions")
  local postfix = require("luasnip.extras.postfix").postfix
  local types = require("luasnip.util.types")
  local parse = require("luasnip.util.parser").parse_snippet
  local ms = ls.multi_snippet

  ls.add_snippets("all", {
    -- review DOC.md for LuaSnip
    -- EXAMPLE:
    s("ternary", {
      -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
      i(1, "cond"),
      t(" ? "),
      i(2, "then"),
      t(" : "),
      i(3, "else"),
    }),
  })
end

-- NOTE: abort Cmp completion with <C-e> to use <Tab> with LuaSnip
return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    config = function(LazyPlugin, opts)
      -- set up opts, then use
      require("luasnip").setup(opts)
      snips()
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

      -- Add Emmet from dcampos/cmp-emmet-vim
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emmet_vim" },
      }))

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
      })
    end,
  },
}
