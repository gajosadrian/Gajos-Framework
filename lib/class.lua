--Class_uniqueID_counter = 0
function Class(namespace,constructor)
    namespace.__index = namespace
    namespace.new = function(...)
        local outerSelf = self -- used to allow constructors inside constructors
        -- aliases
        local this = {}
        self = this
        -- id counter
            --Class_uniqueID_counter = Class_uniqueID_counter + 1
            --this.uniqueID = Class_uniqueID_counter
        -- finish
        setmetatable(this,namespace)
        constructor(unpack(arg))
        self = outerSelf -- used to allow constructors inside constructors
        return this
    end
end

local function tableContains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function class(constructor)
  local namespace = {}
  namespace.__index = namespace
  namespace.new = function(...)
    local outerSelf = self
    -- aliases
    local this = {}
    self = this
    -- metatable
    setmetatable(this, namespace)
    constructor(namespace)
    -- constructor
    if this.__construct then
      this:__construct(unpack(arg))
    end
    -- finish
    self = outerSelf -- used to allow constructors inside constructors
    return this
  end
  return namespace
end

function classExtends(extend, constructor)
  namespace = {}
  namespace.__index = namespace
  namespace.new = function(...)
    local outerSelf = self
    -- aliases
    local this = extend.new()
    self = this
    -- metatable
    -- setmetatable(this,namespace)
    constructor(namespace)
    -- copying statics
    local notAllowedVarNames = {'__index', '__newindex'}
    for varName, varValue in pairs(namespace) do
      if not tableContains(notAllowedVarNames, varName) then
        extend[varName] = varValue
      end
    end
    for varName, varValue in pairs(extend) do
      if not tableContains(notAllowedVarNames, varName) then
        namespace[varName] = varValue
      end
    end
    -- constructor
    if this.__construct then
      this:__construct(unpack(arg))
    end
    -- finish
    self = outerSelf -- used to allow constructors inside constructors
    return this
  end
  return namespace
end

abstract_class = class

-- how to

--[[
classname = class(function(static)
  static.SOMETHING = false

  function self:__construct(my_arguments)
    self.something = my_arguments
  end

  function self:method()
    print(this)
  end
end) -- do not return
]]--
