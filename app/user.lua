local ga = gajosframework

ga.User = classExtends(App, function(id)
    self.id = id
    self._logic = ga.UserLogic.new(id)
    self._view = ga.UserView.new(id)

    function self:GetName()
        return player(id, "name")
    end
    function self:SetName(name, hide)
        setname(id, name, hide or 0)
    end
end)

ga.User.__index = function(self, key)
    local id = self.id

    if key == 'x' then
        return player(id, "x")
    elseif key == 'y' then
        return player(id, "y")
    elseif key == 'name' then
        return player(id, 'name')
    else
        return rawget(self, key)
    end
end

ga.User.__newindex = function(self, key, value)
    local id = self.id

    if key == 'x' then
        setpos(id, value, self.y)
    elseif key == 'y' then
        setpos(id, self.x, value)
    elseif key == 'name' then
        setname(id, value, 0)
    elseif key == 'name2' then
        setname(id, value, 1)
    else
        rawset(self, key, value)
    end
end
