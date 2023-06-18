-- TODO:: add keybinds to show only LSP suggetions or others,
-- e.g. show only Text suggestions or show only Snippet suggestions
-- Example: <C-l> in lua-snip to show only emmet snips
--
-- config from lazy vim, few changes
return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,preview",
          -- autocomplete = false,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- set behavior to "Select", I do not like the "Insert" behavior, I prefer
          -- selecting the items explicitly `cmp.mapping.confirm` before the text is inserted
          ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          -- page up and page down for menu
          ["<C-d>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 6 }),
          ["<C-u>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select, count = 6 }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<F2>"] = cmp.mapping.confirm({ select = true }),
          -- ["<CR>"] = cmp.mapping.abort(), --vim.NIL,
          ["<C-l>"] = vim.NIL, -- NOTE: this was changed from default config
          -- ["<C-n>"] = vim.NIL,
          ["<C-t>"] = function(fallback)
            if cmp.visible() then
              -- adapted from:
              -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/core.lua#L355
              -- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#replacing-actions
              local labels = {}
              local entries = cmp.get_entries()
              for _, e in ipairs(entries) do
                table.insert(labels, e.completion_item.label)
              end
              local pickers = require("telescope.pickers")
              local finders = require("telescope.finders")
              local conf = require("telescope.config").values
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              local telescope_cmp = function(opts)
                opts = opts or {}
                pickers
                  .new(opts, {
                    prompt_title = "Auto CMP",
                    finder = finders.new_table({
                      results = labels,
                    }),
                    sorter = conf.generic_sorter(opts),
                    attach_mappings = function(prompt_bufnr, map)
                      actions.select_default:replace(function()
                        actions.close(prompt_bufnr)
                        local selection = action_state.get_selected_entry()
                        local e = entries[selection.index]
                        print(vim.inspect(e.completion_item.label))
                        vim.schedule(function()
                          vim.cmd([[silent! undojoin]])
                          -- This logic must be used nvim_buf_set_text.
                          -- If not used, the snippet engine's placeholder wil be broken.
                          local context = require("cmp.context")
                          local ctx = context.new()
                          vim.api.nvim_buf_set_text(
                            0,
                            e.context.cursor.row - 1,
                            e:get_offset() - 1,
                            ctx.cursor.row - 1,
                            ctx.cursor.col,
                            {
                              e.completion_item.label,
                            }
                          )
                          vim.cmd("startinsert")
                          vim.api.nvim_win_set_cursor(
                            0,
                            { e.context.cursor.row, e:get_offset() + string.len(e.completion_item.label) - 1 }
                          )
                        end)
                      end)
                      return true
                    end,
                  })
                  :find()
              end
              telescope_cmp()
            else
              fallback()
            end
          end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },
}
