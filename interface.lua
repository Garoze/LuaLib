local T = {}

function T.interface(interface)
  local proto = {
    i = interface,

    create = function(self, proto)
      local instance = {}
      setmetatable(instance, { __index = self })

      for k, v in pairs(self.i) do
        if (proto[k] ~= nil) then
          if (v(proto[k])) then
            instance[k] = proto[k]
          else
            return print('['.. k ..'] - Expected a \''.. v.type ..'\' but got \''..type(proto[k])..'\'')
          end
        else 
          return print('[create] - Missing required field \''.. k ..'\' in type <Type>')
        end
      end

      return instance
    end,
  }
  setmetatable(proto, {
    __call = function(self, ...) return self:create(...) end
  })

  return proto
end

return T.interface