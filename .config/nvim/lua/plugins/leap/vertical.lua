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
        local line_length = string.len(line)
        local col_pos = nil
        if line_length < cur_col then
          col_pos = line_length + 1
        else
          col_pos = cur_col
        end
        -- print(line)
        table.insert(targets, { pos = { lnum, col_pos } })
      end
      lnum = lnum + 1
    end
  end
  if #targets == 0 then return end
  -- Sort them by vertical screen distance from cursor.
  local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
  for _, t in ipairs(targets) do
    local pos = vim.fn.screenpos(winid, t.pos[1], t.pos[2])
    if pos.row > 0 and pos.col > 0 then
      t.screen_line_diff = math.abs(cur_screen_row - pos.row)
    else
      t.screen_line_diff = math.huge
    end
  end
  table.sort(targets, function(t1, t2) return t1.screen_line_diff < t2.screen_line_diff end)
  return targets
end

-- Usage:
return function()
  local winid = vim.api.nvim_get_current_win()
  require("leap").leap({
    target_windows = { winid },
    targets = get_line_starts(winid),
  })
end
