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

function class(constructor)
    namespace = {}
    namespace.__index = namespace
    namespace.new = function(...)
        local outerSelf = self
        -- aliases
        local this = {}
        self = this
        -- finish
        setmetatable(this,namespace)
        constructor(unpack(arg))
        self = outerSelf -- used to allow constructors inside constructors
        return this
    end
    return namespace
end

function classExtends(extend,constructor)
    namespace = {}
    namespace.__index = namespace
    namespace.new = function(...)
        local outerSelf = self
        -- aliases
        local this = extend.new()
        self = this
        -- finish
        --setmetatable(this,namespace)
        constructor(unpack(arg))
        self = outerSelf -- used to allow constructors inside constructors
        return this
    end
    return namespace
end

abstract_class = class

-- how to

--[[
classname = {}
Class(classname,function(my_arguments)
    self.something = my_arguments
end) -- do not return

function classname:method()
    print(this)
end
]]--
