local ga = gajosframework

ga.User = classExtends(App, function(id)
    self.id = id
    self._logic = ga.UserLogic.new(id)
    self._view = ga.UserView.new(id)
end)

ga.User.__index = function(self, key)
    local id = self.id

    return switch(case) {
        x = function()
            return math.round(player(id, 'x'))
        end,

        y = function()
            return math.round(player(id, 'y'))
        end,

        name = function()
            return player(id, 'name')
        end,

        [Default] = function()
            rawget(self, key)
        end,
    }
end

ga.User.__newindex = function(self, key, value)
    local id = self.id

    switch(case) {
        x = function()
            setpos(id, value, self.y)
        end,

        y = function()
            setpos(id, self.x, value)
        end,

        name = function() -- server message while changing
            setname(id, value, 0)
        end,
        name2 = function() -- hidden
            setname(id, value, 1)
        end,

        [Default] = function()
            rawset(self, key, value)
        end,
    }
end
