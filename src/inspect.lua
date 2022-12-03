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

function inspect.ret(f, ...)
  local ok, r = pcall(f, ...) 
  if (ok) then
    print(r)
    return type(r) ~= 'nil' and type(r) or 'void'
  end

  return 'void'
end

function inspect.visitor(t, ...) 
  local d = ... or 1
  local r = ''

  if (t == nil) then return 'Empty {}' end

  for key, value in pairs(t) do
    if (type(value) ~= 'table') then
      if (type(value) == 'function') then
        r = r .. depth(d) .. key .. ': ' .. 'f('.. inspect.args(value) ..') => '..inspect.ret(value)..',\n'
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