-- set up your windowfilter
switcher = hs.window.switcher.new()                                                                      -- default windowfilter: only visible windows, all Spaces
switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter {}) -- include minimized/hidden windows, current Space only
switcher_browsers = hs.window.switcher.new { 'Safari', 'Google Chrome' }                                 -- specialized switcher for your dozens of browser windows :)

-- bind to hotkeys; WARNING: at least one modifier key is required!
hs.hotkey.bind('alt', 'tab', 'Next window', function() switcher:next() end)
hs.hotkey.bind('alt-shift', 'tab', 'Prev window', function() switcher:previous() end)

-- you can also bind to `repeatFn` for faster traversing
hs.hotkey.bind('alt-shift', 'tab', 'Prev window', hs.window.switcher.previousWindow, nil,
  hs.window.switcher.previousWindow)
