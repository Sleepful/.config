-- from the "getting started" docs:
-- https://www.hammerspoon.org/go/

local mouseCircle = nil
local mouseCircleTimer = nil

local h = hs
-- local hs
function blueCircle()
  local stroke = { ["red"] = 0, ["blue"] = 1, ["green"] = 0, ["alpha"] = 1 }
  local radius = 20
  mouseHighlight(stroke, radius)
end

function whiteCircle()
  local stroke = { ["red"] = 1, ["blue"] = 1, ["green"] = 1, ["alpha"] = 1 }
  local radius = 20
  mouseHighlight(stroke, radius)
end

function blackCircle()
  local stroke = { ["red"] = 0, ["blue"] = 0, ["green"] = 0, ["alpha"] = 1 }
  local radius = 20
  mouseHighlight(stroke, radius)
end

function greenCircle()
  local stroke = { ["red"] = 0, ["blue"] = 0, ["green"] = 1, ["alpha"] = 1 }
  local radius = 30
  mouseHighlight(stroke, radius)
end

function redCircle()
  local stroke = { ["red"] = 1, ["blue"] = 0, ["green"] = 0, ["alpha"] = 1 }
  local radius = 40
  mouseHighlight(stroke, radius)
end

function mouseHighlight(stroke, radius)
  -- Delete an existing highlight if it exists
  if mouseCircle then
    mouseCircle:delete()
    if mouseCircleTimer then
      mouseCircleTimer:stop()
    end
  end
  -- Get the current co-ordinates of the mouse pointer
  mousepoint = h.mouse.absolutePosition()
  -- Prepare a big red circle around the mouse pointer
  mouseCircle = h.drawing.circle(h.geometry.rect(mousepoint.x - radius, mousepoint.y - radius, radius * 2, radius * 2))
  mouseCircle:setStrokeColor(stroke)
  mouseCircle:setFill(false)
  mouseCircle:setStrokeWidth(5)
  mouseCircle:show()

  -- Set a timer to delete the circle after 3 seconds
  mouseCircleTimer = h.timer.doAfter(3, function()
    mouseCircle:delete()
    mouseCircle = nil
  end)
end

local megaLeaderModifier = { "cmd", "alt", "shift" }
h.hotkey.bind(megaLeaderModifier, "D", redCircle)
h.hotkey.bind(megaLeaderModifier, "r", function() -- RELOAD CONSOLE
  print("Reloading config")
  h.console.clearConsole()
  h.reload()
  h.openConsole()
end)
h.hotkey.bind(megaLeaderModifier, "t", function() -- TOGGLE CONSOLE
  local win = h.console.hswindow()
  if win == nil then
    h.openConsole()
  else
    win:close()
    h.window.frontmostWindow():focus()
  end
end)

local KeyWindowDict = {}

local function clearWindows()
  KeyWindowDict = {}
  whiteCircle()
end

local function recordWindowTap(evt)
  RecordTap:stop()
  print(evt)
  local key = evt:getKeyCode()
  local chars = evt:getCharacters()
  print("got keycode, ", key)
  print("got chars, ", chars)
  local currentW = h.window.focusedWindow()
  KeyWindowDict[key] = currentW
  print("Added: ", KeyWindowDict[key])
  blueCircle()
  return true
  -- adds window to a given keymap
end

RecordTap = h.eventtap.new({ h.eventtap.event.types.keyDown }, recordWindowTap)
local function recordWindowBegin()
  -- adds window to a given keymap
  RecordTap:start()
  print("began recordTap")
  blackCircle()
end

-- the codes are numbers for some reason, the numbers represent the letters:
-- l = 37
-- t = 17
-- k = 40
-- w = 13
-- s = 1
-- d = 2
local PredefWindoKeys = {
  [17] = "firefox",
  [40] = "kitty",
  [13] = "WhatsApp",
  [1] = "Spotify",
  [2] = "Discord",
}

local function jumpToWindowTap(evt)
  -- tries to find window from keyWindowDict, otherwise just output red circle
  -- if window is found, it becomes focused
  -- lets hope that focused window makes OS jump to the right space/monitor, otherwise add more code to handle these edge cases
  local mods = h.eventtap.checkKeyboardModifiers()
  print(require('util').dump(mods))
  if mods["ctrl"] and mods then -- activates window picker with this modifier key
    -- local chars = evt:getCharacters() -- ctrl combinations do not have characters.
    local code = evt:getKeyCode()
    print("got cmd and shift for: ", code)
    local win = KeyWindowDict[code]
    if win == nil then
      hint = PredefWindoKeys[code]
      if hint == nil then
        print("Did not find window")
        return false
      end
      print("Looking for predefined window")
      app = h.application.find(hint)
      if app then
        app:mainWindow():focus()
        return true
      end
      print("Did not find window")
      return false
    end
    greenCircle()
    win:focus()
    return true
  end
  return false
end

JumpTap = h.eventtap.new({ h.eventtap.event.types.keyDown }, jumpToWindowTap)
-- JumpTap:start() initiates keypress monitoring
JumpTap:start()

local leaderModifier = { "cmd", "alt" }

h.hotkey.bind(leaderModifier, "r", recordWindowBegin)
h.hotkey.bind(leaderModifier, "x", clearWindows)
