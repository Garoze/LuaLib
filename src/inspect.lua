local inspect = {}

local function depth(n, ...)
  local c = ... or ' '
  local r = ''

  for _ = 1, n do
    r = r .. c
  end

  return r
end

local function formatType(x)
  if (type(x) == 'string') then
    return '\"'..x..'\"'
  else
    return x
  end
end

function inspect.args(f) 
  local args = {}
    for i = 1, debug.getinfo(f).nparams, 1 do
        table.insert(args, debug.getlocal(f, i));
    end
    return table.concat(args, ', ');
end

function inspect.visitor(t, ...)
  -- assert(t ~= nil, '[inspect.visitor] - Expected a argument on #1 and got \'none\'')
  -- assert(type(t) == 'table', '[inspect.visitor] - Expected a \'table\' on #1 argument and got '..type(t))
  
  local d = ... or 1
  local r = ''

  if (t == nil) then return 'Empty {}' end

  for key, value in pairs(t) do
    if (type(value) ~= 'table') then
      if (type(value) == 'function') then
        r = r .. depth(d) .. key .. ': ' .. 'f('.. inspect.args(value) ..') => void,\n'
      else
        r = r .. depth(d) .. key .. ': ' .. formatType(value) .. ',\n'
      end
    else
      r = r .. depth(d) .. key .. ':'.. inspect.visitor(value, d + 1) .. ',\n'
    end
  end

  return depth(d - 1) .. '{\n'.. r ..depth(d - 1).. '}'
end

function inspect.print(t)
  print(inspect.visitor(t))
end

return inspect