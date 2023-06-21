local state = {}

local M = {}

M.confirm = function()
  local cmp = require("cmp")
  local entry = state.entry
  cmp.core:confirm(entry, {}, function()
    cmp.core:complete(cmp.core:get_context({ reason = cmp.ContextReason.TriggerOnly }))
  end)
end

M.set_entry = function(entry)
  state.entry = entry
end

return M
