local User = {
  constructor = function(self, name, age)
    self.name = name or 'Guest'
    self.age = age or 99

    return self
  end,

  setName = function(self, name)
    self.name = name

    return self
  end,

  setAge = function(self, age)
    self.age = age

    return self
  end,

  show = function(self)
    print('Name: '..self.name)
    print('Age: '..self.age)
  end,
}

setmetatable(User, { __call = function(self, ...) return self:constructor(...) end })


local u = User()
  :setName('Dev')
  :setAge(12)
  
u:show()
