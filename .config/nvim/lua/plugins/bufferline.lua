-- TODO: :
-- add shortcut to search, to mark buffers for deletion? should be easy with:
-- actions.delete_buffer({prompt_bufnr})      *telescope.actions.delete_buffer()*
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt
-- > can also create a shortcut for the inverse

-- sort_by_groups
-- sorts the results in the same order as naturally displayed in the bufferline
local function sort_by_groups(components)
  -- print(vim.inspect(require("bufferline").groups.get_all()))
  -- print(vim.inspect(require("bufferline.buffers").get_components(require("bufferline.state"))))
  local bufferline = require("bufferline")
  local groups = bufferline.groups.get_all()
  table.sort(components, function(a, b)
    if a.group ~= b.group then
      return groups[a.group].priority < groups[b.group].priority
    end
    return a.ordinal < b.ordinal
  end)
  return components
end

-- sort_by_recently_visited
-- sorts the buffers by most recently visited
local function sort_by_recently_sorter(a, b)
  -- last_visited is created on autocmd "buffer_metadata"
  local a_time = vim.fn.getbufinfo(a.id)[1].variables.last_visited or 0
  local b_time = vim.fn.getbufinfo(b.id)[1].variables.last_visited or 0
  return a_time > b_time
end

local function sort_by_recently_visited(components)
  -- print(vim.inspect(require("bufferline").groups.get_all()))
  -- print(vim.inspect(require("bufferline.buffers").get_components(require("bufferline.state"))))
  local bufferline = require("bufferline")
  table.sort(components, sort_by_recently_sorter)
  return components
end

local function search_buffers(sort_entries_callback)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local sorters = require("telescope.sorters")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local displayer = require("telescope.pickers.entry_display").create({
    separator = "▏",
    items = {
      -- group | buffer name | a bit of dir path (?)
      -- if it is closed or open !
      { width = 12 },
      { width = 12 },
      { remaining = true },
    },
  })

  local bufline = require("bufferline")

  local bufs = require("bufferline.buffers").get_components(require("bufferline.state"))
  local entries = sort_entries_callback(bufs)

  local groups = bufline.groups.get_all()

  local function telescope_bufline_buffers(opts)
    opts = opts or {}
    pickers
      .new(opts, {
        prompt_title = "Search bufline",
        finder = finders.new_table({
          results = entries,
          entry_maker = function(entry)
            return {
              value = entry,
              ordinal = (groups[entry.group].string_name or groups[entry.group].name)
                .. " "
                .. entry.name
                .. " "
                .. entry.path,
              display = function(e)
                return displayer({
                  groups[e.value.group].string_name or groups[entry.group].name,
                  e.value.name,
                  vim.fn.fnamemodify(e.value.path, ":."),
                })
              end,
            }
          end,
        }),
        sorter = sorters.fuzzy_with_index_bias(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection and vim.api.nvim_buf_is_valid(selection.value.id) then
              vim.api.nvim_set_current_buf(selection.value.id)
            end
          end)
          return true
        end,
      })
      :find()
  end
  telescope_bufline_buffers()
end

local function close_all_groups()
  local bufferline = require("bufferline")
  local all = bufferline.groups.get_all()
  for name, props in pairs(all) do
    if name ~= "pinned" and name ~= "ungrouped" then
      bufferline.groups.action(name, "close")
    end
  end
end

local function hide_all_groups()
  local bufferline = require("bufferline")
  local all = bufferline.groups.get_all()
  -- print(vim.inspect(all))
  for name, props in pairs(all) do
    if name ~= "pinned" and name ~= "ungrouped" then
      -- print(vim.inspect(name))
      bufferline.groups.set_hidden(name, true)
    end
  end
end

local function expand_all_groups()
  local bufferline = require("bufferline")
  local all = bufferline.groups.get_all()
  for name, props in pairs(all) do
    if name ~= "pinned" and name ~= "ungrouped" then
      bufferline.groups.set_hidden(name, false)
    end
  end
end

local function toggle_group_by_search()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local displayer = require("telescope.pickers.entry_display").create({
    separator = "▏",
    items = {
      { width = 12 },
      { width = 12 },
      { remaining = true },
    },
  })

  local entries = {}
  local bufline = require("bufferline")
  for name, props in pairs(bufline.groups.get_all()) do
    if name ~= "pinned" and name ~= "ungrouped" then
      table.insert(entries, props)
    end
  end

  local telescope_groups = function(opts)
    opts = opts or {}
    pickers
      .new(opts, {
        prompt_title = "Toggle groups",
        finder = finders.new_table({
          results = entries,
          entry_maker = function(entry)
            return {
              value = entry,
              ordinal = entry.string_name,
              display = function(e)
                return displayer({
                  e.value.hidden and "Hidden" or "Visible",
                  e.value.name,
                  e.value.string_name,
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
            if selection then
              local e = selection.value
              bufline.groups.action(e.name, "toggle")
            end
          end)
          return true
        end,
      })
      :find()
  end

  telescope_groups()
end

local function sort_by_modified(buffer_a, buffer_b)
  local path_a = buffer_a.path
  local path_b = buffer_b.path
  local ls_a = vim.uv.fs_lstat(path_a)
  local ls_b = vim.uv.fs_lstat(path_b)
  -- fs_lstat returns nil for files that it cannot find:
  local mtime_a = ls_a and ls_a.mtime.sec or 0
  local mtime_b = ls_b and ls_b.mtime.sec or 0
  return mtime_a > mtime_b
end

local function fmt(buf)
  local separator = "💧"
  local name = buf.name:match("(.+)%..+$")
  if name == nil then
    -- the file has no extension, so just return the name
    name = buf.name
  end
  local starts_with_numbers = name:match("^(%d+)")
  if starts_with_numbers ~= nil then
    local new_name = name:match("^%d+.(.+)$")
    separator = "☔"
    name = new_name
  end
  local max_len = 11
  local trailing_chars = 4
  if string.len(name) > max_len + 1 then
    local trim = max_len - trailing_chars - 1
    local first = string.sub(name, 1, trim)
    local last = string.sub(name, -trailing_chars)
    name = first .. separator .. last
  end
  return name
end

return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { "RRethy/nvim-base16", "LazyVim/LazyVim" },
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bQ", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bP" },
      { "<leader>bO", "<Cmd>BufferLineCloseRight<CR>" },
      { "<leader>bI", "<Cmd>BufferLineCloseLeft<CR>" },
      { "<leader>ba", "<Cmd>BufferLinePick<CR>" },
      { "<leader>bW", "<Cmd>BufferLinePickClose<CR>" },
      -- some bindings in keymaps.lua
      { "<leader>bse", "<Cmd>BufferLineSortByExtension<CR>" },
      { "<leader>bsd", "<Cmd>BufferLineSortByDirectory<CR>" },
      {
        "<leader>bsm",
        function()
          require("bufferline").sort_by(sort_by_modified)
        end,
        desc = "Sort by last time the file was modified",
      },
      {
        "<leader>bsr",
        function()
          require("bufferline").sort_by(sort_by_recently_sorter)
        end,
        desc = "Sort by recently visited buffer",
      },
      { "<leader>bi", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Travel to first buffer" },
      { "<leader>bo", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Travel to last buffer" },
      { "<leader>bgh", hide_all_groups, desc = "Hide all groups" },
      { "<leader>bgc", close_all_groups, desc = "Close all groups" },
      { "<leader>bge", expand_all_groups, desc = "Expand all groups" },
      { "<leader>bgt", toggle_group_by_search, desc = "Toggle group (search)" },
      {
        "<leader>bf",
        function()
          search_buffers(sort_by_groups)
        end,
        desc = "Find buffer",
      },
      {
        "<leader>,",
        function()
          search_buffers(sort_by_groups)
        end,
        desc = "Switch buffer (bufferline)",
      },
      {
        "<leader>br",
        function()
          search_buffers(sort_by_recently_visited)
        end,
        desc = "Find buffer (recently visited)",
      },
    },
    opts = {
      options = {
        themable = true,
        groups = {
          options = {
            toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
          },
          items = {
            {
              name = "🧪T", -- Mandatory
              string_name = "Test",
              priority = 2, -- determines where it will appear relative to other groups (Optional)
              -- icon = "🧪", -- Optional
              separator = { -- Optional
                -- style = require("bufferline.groups").separator.tab,
              },
              -- auto_close = true,
              matcher = function(buf) -- Mandatory
                -- print(vim.inspect(buf))
                return buf.path:match("%test") or buf.path:match("%spec")
              end,
              highlight = {
                -- empty, colors set in flavours.lua
              },
            },
            require("bufferline.groups").builtin.ungrouped,
            {
              name = "📚D",
              string_name = "Docs",
              auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
              matcher = function(buf)
                return buf.path:match("%.md") or buf.path:match("%.txt")
              end,
              separator = {
                -- style = require("bufferline.groups").separator.tab,
              },
            },
            {
              name = "⚙️R", -- Mandatory
              string_name = "Rc",
              separator = {},
              auto_close = true,
              matcher = function(buf) -- Mandatory
                local name = buf.name:match("^%..+$")
                if name == nil then
                  return false
                end
                return true
              end,
              highlight = {},
            },
            {
              name = "?", -- Mandatory
              string_name = "Unnamed",
              auto_close = true,
              separator = {},
              matcher = function(buf) -- Mandatory
                local name = buf.name:match("^%[No Name%]$")
                if name == nil then
                  return false
                end
                return true
              end,
              highlight = {},
            },
          },
        },
        show_buffer_icons = false,
        truncate_names = true,
        show_buffer_close_icons = false,
        name_formatter = fmt,
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        separator_style = "slope",
        -- separator_style = "thin",
        indicator = {
          -- style = "underline",
        },
        tab_size = 6,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
