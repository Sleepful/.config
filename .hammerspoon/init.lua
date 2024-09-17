-- Look for Spoons in ~/.hammerspoon/MySpoons as well
-- package.path = package.path .. ";" ..  hs.configdir .. "/MySpoons/?.spoon/init.lua"

-- https://github.com/minusf/FuzzySwitcher.spoon
hs.loadSpoon("FuzzySwitcher")
spoon.FuzzySwitcher:bindHotkeys({ show_switcher = { { "option" }, "space" } })
spoon.FuzzySwitcher:start()


-- some switcher gist that didn't work well:
-- https://gist.github.com/RainmanNoodles/70aaff04b20763041d7acb771b0ff2b2

-- Defeat paste blocking (per hammerspoon "getting started")
--  https://www.hammerspoon.org/go/
hs.hotkey.bind({ "cmd", "alt" }, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

require("./redCircleMouse")
require("./windowsModule")


-- Disabled:
-- require("./cmdReplacement")
-- cmd+tab replacement looks crazy
