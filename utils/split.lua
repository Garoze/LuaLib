local function split(str, ...)
  local r = {}
  local sep = ... or '%s'

  for t in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(r, t)
  end

  return r
end