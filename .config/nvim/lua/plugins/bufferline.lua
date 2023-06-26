local function fmt(buf)
  local name = buf.name:match("(.+)%..+$")
  if name == nil then
    -- the file has no extension, so just return the name
    name = buf.name
  end
  if string.len(name) > 14 then
    local first = string.sub(name, 1, 9)
    local last = string.sub(name, -4)
    name = first .. "💧" .. last
  end
  return name
end

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bQ", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bO", "<Cmd>BufferLineCloseRight<CR>" },
      { "<leader>bI", "<Cmd>BufferLineCloseLeft<CR>" },
      { "<leader>ba", "<Cmd>BufferLinePick<CR>" },
      { "<leader>bW", "<Cmd>BufferLinePickClose<CR>" },
    },
    opts = {
      options = {
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
        separator_style = "thick",
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
