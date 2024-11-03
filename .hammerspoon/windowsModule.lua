-- jose's window module

local u = require("./util")

local M = {}

-- defaults:
M.logger = hs.logger.new("WindowSwitcher", "info")
-- Remember last selection in the popup
M.remember_last = false

function M:init()
  self.wf_current = hs.window.filter.new()
  self.wf_current:setCurrentSpace(true)
  self.wf_other = hs.window.filter.new()
  self.wf_other:setCurrentSpace(false)
  self.chooserPopup = hs.chooser.new(hs.fnutils.partial(self.processSelected, self))
  self.chooserPopup:choices(hs.fnutils.partial(self.getWindowChoices, self))
  self.chooserPopup:searchSubText(true)
  self.spaceWatcher = hs.spaces.watcher.new(hs.fnutils.partial(self.spaceChangeHandler, self))
end

function M:getWindowChoices()
  -- DEBUG PRINT:
  -- print("getWindowChoices")
  -- ugly hack to get all windows?
  -- basically using a filter that gets windows for "all spaces" (not setting current space option)
  -- will FAIL to get all windows
  -- https://github.com/Hammerspoon/hammerspoon/issues/3276
  local current_space_windows = self.wf_current:getWindows()
  local other_space_windows = self.wf_other:getWindows()
  local all_windows = {}
  for i, v in pairs(current_space_windows) do table.insert(all_windows, v) end
  if #all_windows > 1 then
    -- switch first and second windows
    -- that way currently selected window isn't the first option
    local temp = all_windows[1]
    all_windows[1] = all_windows[2]
    all_windows[2] = temp
  end
  for i, v in pairs(other_space_windows) do table.insert(all_windows, v) end
  local result = {}
  for i, v in ipairs(all_windows) do
    -- local maxLen = 15
    -- local appTitle = v:application():title():sub(1, maxLen)
    -- local largeText = appTitle .. " | " .. v:title()
    local text = v:application():title()
    local subtext = v:title()
    table.insert(result,
      {
        subText = hs.styledtext.new(subtext,
          { font = { size = 16 }, color = hs.drawing.color.definedCollections.hammerspoon.white }),
        text = hs.styledtext.new(text,
          { font = { size = 18 }, color = hs.drawing.color.definedCollections.hammerspoon.grey }),
        hs_window_id = v:id(),
      })
  end
  return result
end

function M:processSelected(row)
  if row ~= nil then
    M.logger.df("selected '%s'", row.text)
    self.chooserPopup:hide()
    local id = row.hs_window_id
    -- find if window is in current space, if so, just switch
    local windowSpace = hs.spaces.windowSpaces(id)[1]
    -- Question: is it possible that a window is in multiple spaces? could bug out the logic here
    if hs.spaces.focusedSpace() == windowSpace then
      hs.window.find(id):focus()
    else
      -- store the window selection for the handler
      self.lastWindowSelection = id
      -- go to space first
      self.spaceWatcher:start()
      hs.spaces.gotoSpace(windowSpace)
      -- the space watcher handler (spaceChangeHandler) will focus the window
    end
    --
  end
end

function M:spaceChangeHandler(i)
  self.spaceWatcher:stop()
  -- DEBUG PRINT:
  -- print("handler acting")
  local id = self.lastWindowSelection
  local hs_window = hs.window.find(id)
  hs_window:focus()
end

function M:showSwitcher()
  if self.chooserPopup ~= nil then
    self.chooserPopup:refreshChoicesCallback()
    if M.remember_last == false then
      self.chooserPopup:query("")
    end
    self.chooserPopup:show()
  else
    hs.notify.show("Seems that the WindowSwitcher has not been initialized.", "")
  end
end

-- DEBUG FUNCTION
-- function M:windowsFoo()
--   local ws = hs.window.allWindows() -- only in current screen/workspace
--   print(ws)
--   print(u.dump(ws))
--
--   local wf = hs.window.filter.new()
--   local all_w = wf:getWindows()
--   print(all_w)
--   print(u.dump(all_w))
--   hs.alert.show("windo!")
-- end

M:init()

return M
