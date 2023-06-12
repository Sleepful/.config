M = {}
M.cmd = function(cmd)
  -- https://stackoverflow.com/a/75903122/2446144
  -- runs command on a sub-process.
  local handle = io.popen(cmd)
  -- reads command output.
  local output = handle:read("*a")
  -- replaces any newline with a space
  local format = output:gsub("[\n\r]", " ")
  return format
end

return M
