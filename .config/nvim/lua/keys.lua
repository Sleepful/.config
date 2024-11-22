local left = { bound = "r", og = "h" }
local right = { bound = "a", og = "l" }
local up = { bound = "t", og = "k" }
local down = { bound = "e", og = "j" }
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
