local function get_line_starts(winid)
  local wininfo = vim.fn.getwininfo(winid)[1]
  local cur_line = vim.fn.line(".")

  -- Get targets.
  local targets = {}
  local lnum = wininfo.topline
  while lnum <= wininfo.botline do
    local fold_end = vim.fn.foldclosedend(lnum)
    -- Skip folded ranges.
    if fold_end ~= -1 then
      lnum = fold_end + 1
    else
      if lnum ~= cur_line then
        table.insert(targets, { pos = { lnum, 1 } })
      end
      lnum = lnum + 1
    end
  end
  -- Sort them by vertical screen distance from cursor.
  local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
  local function screen_rows_from_cur(t)
    local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
    return math.abs(cur_screen_row - t_screen_row)
  end
  table.sort(targets, function(t1, t2)
    return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
  end)

  if #targets >= 1 then
    return targets
  end
end

-- Usage:
local function leap_to_line()
  local winid = vim.api.nvim_get_current_win()
  require("leap").leap({
    target_windows = { winid },
    targets = get_line_starts(winid),
  })
end

return {
  {
    "ggandor/leap.nvim",
    config = function()
      -- vim.keymap.set({ "n", "v" }, "S", leap_to_line())
    end,
    keys = {
      {
        "s",
        function()
          -- all windows search (includes bidirectional search) per docs
          local focusable_windows_on_tabpage = vim.tbl_filter(function(win)
            return vim.api.nvim_win_get_config(win).focusable
          end, vim.api.nvim_tabpage_list_wins(0))
          -- table.insert(focusable_windows_on_tabpage, current_window)
          require("leap").leap({ target_windows = focusable_windows_on_tabpage })
        end,
        mode = { "n", "x", "o" },
        desc = "Leap forward to",
      },
      { "S", leap_to_line, mode = { "n", "x", "o" }, desc = "Leap backward to" },
    },
  },
  {
    "ggandor/flit.nvim",
    opts = {
      -- from docs:
      keys = { f = "f", F = "F", t = "t", T = "T" },
      -- A string like "nv", "nvo", "o", etc.
      labeled_modes = "nv",
      multiline = true,
      -- Like `leap`s similar argument (call-specific overrides).
      -- E.g.: opts = { equivalence_classes = {} }
      opts = {},
    },
  },
}
