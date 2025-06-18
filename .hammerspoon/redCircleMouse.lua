-- from the "getting started" docs:
-- https://www.hammerspoon.org/go/

local mouseCircle = nil
local mouseCircleTimer = nil

local h = hs
-- local hs
function mouseHighlight()
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
  mouseCircle = h.drawing.circle(h.geometry.rect(mousepoint.x - 40, mousepoint.y - 40, 80, 80))
  mouseCircle:setStrokeColor({ ["red"] = 1, ["blue"] = 0, ["green"] = 0, ["alpha"] = 1 })
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
h.hotkey.bind(megaLeaderModifier, "D", mouseHighlight)
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
end

local function recordWindowTap(evt)
  RecordTap:stop()
  print(evt)
  local key = evt:getKeyCode()
  local chars = evt:getCharacters()
  print("got keycode, ", key)
  print("got chars, ", chars)
  local currentW = h.window.focusedWindow()
  KeyWindowDict[chars] = currentW
  print("Added: ", KeyWindowDict[chars])
  return true
  -- adds window to a given keymap
end

RecordTap = h.eventtap.new({ h.eventtap.event.types.keyDown }, recordWindowTap)
local function recordWindowBegin()
  -- adds window to a given keymap
  RecordTap:start()
  JumpTap:start()
  print("began recordTap")
end

local function jumpToWindowTap(evt)
  -- tries to find window from keyWindowDict, otherwise just output red circle
  -- if window is found, it becomes focused
  -- lets hope that focused window makes OS jump to the right space/monitor, otherwise add more code to handle these edge cases
  -- print(evt)
  local chars = evt:getCharacters()
  local mods = h.eventtap.checkKeyboardModifiers()
  -- print(require('util').dump(mods))
  if mods["cmd"] and mods["shift"] and mods then
    -- cmd and shift is the key identifier to grab a character
    local key = evt:getKeyCode()
    if key == 36 then -- ignore shift+cmd+enter
      return false
    end
    print("got cmd and shift for: ", chars, key)
  end
  return false
end

JumpTap = h.eventtap.new({ h.eventtap.event.types.keyDown }, jumpToWindowTap)

local function test()
  mouseHighlight()
  print("hello world")
  local currentW = h.window.focusedWindow()
  local id = currentW.id()
end

local leaderModifier = { "cmd", "alt" }

h.hotkey.bind(leaderModifier, "r", recordWindowBegin)
h.hotkey.bind(leaderModifier, "x", clearWindows)

h.hotkey.bind({ "cmd", "shift" }, "n", test)


local state = {}
