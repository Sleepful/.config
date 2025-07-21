-- TODO:: add keybinds to show only LSP suggetions oconfirm after close r others,
-- e.g. show only Text suggestions or show only Snippet suggestions
-- Example: <C-l> in lua-snip to show only emmet snips
return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "mattn/emmet-vim",
      "dcampos/cmp-emmet-vim",
    },
    opts = function()
      local cmp = require("cmp")
      -- disable for lisp to prefer slimv
      cmp.setup.filetype({ 'lisp' }, {
        enabled = false
      })
      return {
        completion = {
          completeopt = "menu,menuone,noinsert,preview",
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          -- set behavior to "Select", I do not like the "Insert" behavior, I prefer
          -- selecting the items explicitly `cmp.mapping.confirm` before the text is inserted
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<F29>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<PageDown>"] = cmp.mapping.select_next_item({ count = 7, behavior = cmp.SelectBehavior.Select }),
          ["<PageUp>"] = cmp.mapping.select_prev_item({ count = 7, behavior = cmp.SelectBehavior.Select }),
          ["<S-PageUp>"] = cmp.mapping.scroll_docs(-4),
          ["<S-PageDown>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = function(fallback)
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
          ["<Right>"] = function(fallback)
            if cmp.visible() then
              cmp.abort()
              fallback()
            else
              fallback()
            end
          end,
          ["<Left>"] = function(fallback)
            if cmp.visible() then
              cmp.abort()
              fallback()
            else
              fallback()
            end
          end,
          ["<F2>"] = function(fallback)
            if cmp.visible() then
              -- create new "undo" point
              vim.cmd("let &undolevels = &undolevels")
              cmp.confirm()
            else
              fallback()
            end
          end,
          -- ["<End>"] = function(fallback)
          --   if cmp.visible() then
          --     -- create new "undo" point
          --     vim.cmd("let &undolevels = &undolevels")
          --     cmp.confirm()
          --   else
          --     fallback()
          --   end
          -- end,
          ["<C-b>"] = cmp.mapping.complete({
            config = {
              sources = {
                { name = "nvim_lsp" },
              },
            },
          }),
          ["<C-l>"] = cmp.mapping.complete({
            config = {
              sources = {
                { name = "luasnip" },
              },
            },
          }),
          -- could change this to "if filetype" and then add more functionality
          ["<C-e>"] = cmp.mapping.complete({
            config = {
              sources = {
                -- Add Emmet from dcampos/cmp-emmet-vim
                {
                  name = "emmet_vim",
                  option = {
                    filetypes = {
                      -- elixir because Heex sometimes doesn't ID the HTML under cursor
                      "elixir",
                      -- the rest are defaults from emmet-cmp
                      "html",
                      "templ",
                      "xml",
                      "typescriptreact",
                      "javascriptreact",
                      "css",
                      "sass",
                      "scss",
                      "less",
                      "heex",
                      "tsx",
                      "jsx",
                    },
                  },
                },
              },
            },
          }),
          ["<C-s>"] = function(fallback)
            -- TODO:
            -- [ ] - does not work great with snippets yet
            -- [ ] - does not preview anything, should preview docs for LSP and snippets for snipets
            if cmp.visible() then
              -- adapted from:
              -- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/core.lua#L355
              -- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#replacing-actions
              local entries = cmp.get_entries()
              local utils = require("plugins.cmp.utils")
              cmp.close()

              local pickers = require("telescope.pickers")
              local finders = require("telescope.finders")
              local conf = require("telescope.config").values
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              local displayer = require("telescope.pickers.entry_display").create({
                separator = "▏",
                items = {
                  { width = 6 },
                  { width = 12 },
                  { remaining = true },
                },
              })

              local fmt_source_name = function(name)
                if name == "nvim_lsp" then
                  return "LSP"
                end
                if name == "buffer" then
                  return "Text"
                end
                if name == "luasnip" then
                  return "Snip"
                end
                return name
              end

              local fmt_source_kind = function(kind)
                if kind == "" or kind == nil then
                  return " "
                end
                local types = require("cmp.types")
                return types.lsp.CompletionItemKind[kind]
              end

              local telescope_cmp = function(opts)
                opts = opts or {}
                pickers
                    .new(opts, {
                      prompt_title = "Auto CMP",
                      finder = finders.new_table({
                        results = entries,
                        entry_maker = function(entry)
                          return {
                            value = entry,
                            ordinal = fmt_source_name(entry.source.name) .. " " .. fmt_source_kind(
                              entry.completion_item.kind
                            ) .. " " .. entry.completion_item.label,
                            display = function(e)
                              return displayer({
                                fmt_source_name(e.value.source.name),
                                fmt_source_kind(e.value.completion_item.kind),
                                e.value.completion_item.label,
                              })
                            end,
                          }
                        end,
                      }),
                      sorter = conf.generic_sorter(opts),
                      attach_mappings = function(prompt_bufnr, map)
                        actions.select_default:replace(function()
                          actions.close(prompt_bufnr)
                          local selection = action_state.get_selected_entry()
                          local e = selection.value
                          utils.set_entry(e)
                          vim.schedule(function()
                            -- feedkeys necessary
                            -- https://github.com/hrsh7th/nvim-cmp/discussions/1629
                            vim.fn.feedkeys(
                              vim.api.nvim_replace_termcodes(
                                'a<Cmd>lua require("plugins.cmp.utils").confirm()<CR>',
                                true,
                                true,
                                true
                              )
                            )
                          end)
                        end)
                        return true
                      end,
                    })
                    :find()
              end

              telescope_cmp()

              return true
            else
              fallback()
            end
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("util").icons.kinds
            if icons[item.kind] then
              -- add icons and keep the name of the "kind"
              item.kind = icons[item.kind] -- .. item.kind
            end
            if item.menu then
              -- shorten really long URLs/paths
              item.menu = item.menu:sub(1, 20)
            end
            item.abbr = item.abbr:sub(1, 25)
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
