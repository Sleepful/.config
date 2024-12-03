-- DEPRECATED:
-- TODO delete all references to this file (require.*keys)
local left = { bound = "h", og = "h" }
local right = { bound = "l", og = "l" }
local up = { bound = "k", og = "k" }
local down = { bound = "j", og = "j" }
local left_helper_one = { key = "c" }
-- local left_helper_two = { key = "g" }
local right_helper_one = { key = "l" }
-- local right_helper_two = { key = "h" }
local delete = { bound = "d", og = "d" }

local M = {
  right = right,
  left = left,
  up = up,
  down = down,
  left_helper_one = left_helper_one,
  -- left_helper_two = left_helper_two,
  right_helper_one = right_helper_one,
  -- right_helper_two = right_helper_two,
  delete = delete
}

return M
