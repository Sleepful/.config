local left = { bound = "s", og = "h" }
local right = { bound = "l", og = "l" }
local up = { bound = "d", og = "k" }
local down = { bound = "k", og = "j" }
local left_helper_one = { key = "f" } -- leap
local left_helper_two = { key = "g" }
local right_helper_one = { key = "j" }
local right_helper_two = { key = "h" }
local delete = { bound = right_helper_one.key, og = "d" }

local M = {
  right = right,
  left = left,
  up = up,
  down = down,
  left_helper_one = left_helper_one,
  left_helper_two = left_helper_two,
  right_helper_one = right_helper_one,
  right_helper_two = right_helper_two,
  delete = delete
}

return M
