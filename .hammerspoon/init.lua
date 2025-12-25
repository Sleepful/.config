-- Look for Spoons in ~/.hammerspoon/MySpoons as well
-- package.path = package.path .. ";" ..  hs.configdir .. "/MySpoons/?.spoon/init.lua"

-- https://github.com/minusf/FuzzySwitcher.spoon
-- hs.loadSpoon("FuzzySwitcher")
-- spoon.FuzzySwitcher:bindHotkeys({ show_switcher = { { "option" }, "space" } })
-- spoon.FuzzySwitcher:start()


-- some switcher gist that didn't work well:
-- https://gist.github.com/RainmanNoodles/70aaff04b20763041d7acb771b0ff2b2

-- function pasteMultilineString(str)
--   local lines = stringy.split(str, "\n")
--   local is_first_line = true
--   for _, line in ipairs(lines) do
--     if is_first_line then
--       is_first_line = false
--     else
--       hs.eventtap.keyStroke({}, "return")
--     end
--     hs.eventtap.keyStrokes(line)
--   end
-- end

local lume = require("./lume")
local util = require("./util")
local d = util.dump

-- Defeat paste blocking (per hammerspoon "getting started")
--  https://www.hammerspoon.org/go/
hs.hotkey.bind({ "ctrl" }, "v", function()
  local contents = hs.pasteboard.getContents()
  local result = {};
  for line in string.gmatch(contents .. "\n", "(.-)\n") do
    table.insert(result, line);
  end
  for idx = 1, #result do
    hs.eventtap.keyStrokes(result[idx])
    hs.timer.usleep(200 * 1000)
    hs.eventtap.keyStroke({}, "return")
  end
end)

function inputKeys(str)
  local strN = str .. "\n"
  print(strN)
  hs.eventtap.keyStrokes(strN)
  hs.timer.usleep(200 * 1000)
  hs.eventtap.keyStroke({}, "return")
end

-- defeat hackerrank, ignores whitespace to allow HR autoindent
-- it's kind of odd, the HR IDE is a bit slow with keystrokes, so might requiree slowing down the "returs"
hs.hotkey.bind({ "ctrl" }, "g", function()
  local contents = hs.pasteboard.getContents()
  local result = {};
  for line in string.gmatch(contents .. "\n", "(.-)\n") do
    table.insert(result, line);
  end
  for idx = 1, #result do
    local str = lume.trim(result[idx])
    print(idx)
    hs.timer.doAfter(idx, function()
      inputKeys(str)
    end)
  end
end)


require("./redCircleMouse")

-- local wm = require("./windowsModule")
-- hs.hotkey.bind({ "cmd" }, "space", function() wm:showSwitcher() end)

-- hs.hotkey.bind({ "cmd", "alt" }, "W", function() wm:showSwitcher() end)
-- hs.hotkey.bind('alt', 'tab', 'Next window', function() switcher:next() end)




-- Disabled:
-- require("./cmdReplacement")
-- cmd+tab replacement looks crazy
