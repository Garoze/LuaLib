local T = require('type')
local d = require('validation')
local inspect = require('inspect')

local IPerson = T {
  name = d.string(),
  address = d.string(),
}

local person = IPerson {
  name = 'Dev',
  address = 'rua qualquer'
}

inspect.print(person)