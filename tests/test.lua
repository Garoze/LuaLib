local T = require('src.interface')
local d = require('src.validation')
local inspect = require('src.inspect')

local IPerson = T {
  name = d.string(),
  address = d.string(),
}

local person = IPerson {
  name = 'Dev',
  address = 'rua qualquer'
}

inspect.print(person)