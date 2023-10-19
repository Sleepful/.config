-- Functions based on Leap examples:
-- https://github.com/ggandor/leap.nvim#calling-leap-with-custom-arguments

local function get_line_starts(winid)
  local wininfo = vim.fn.getwininfo(winid)[1]
  local cur_line = vim.fn.line(".")
  local cur_col = vim.fn.virtcol(".")

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
        -- table.insert(targets, { pos = { lnum, 1 } })
        local line = vim.fn.getline(lnum)
        local max_col = string.len(line)
        local col_pos = nil
        if max_col < cur_col then
          col_pos = max_col
        else
          col_pos = cur_col
        end
        print(line)
        table.insert(targets, { pos = { lnum, col_pos } })
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
return function()
  local winid = vim.api.nvim_get_current_win()
  require("leap").leap({
    target_windows = { winid },
    targets = get_line_starts(winid),
  })
end
