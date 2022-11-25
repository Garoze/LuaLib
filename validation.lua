local d = {
  string = function()
    local string = {
      type = 'string',
      f = function(str)
        return type(str) == 'string'
      end,
    }

    return setmetatable(string, { __call = function(self, ...) return self.f(...) end })
  end,
}

return d