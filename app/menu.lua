local ga = gajosframework

ga.Menu = classExtends(App, function(id)
    self.id = id
    self._logic = ga.MenuLogic.new(id)
    self._view = ga.MenuView.new(id)

    function self:addButton(name, desc, visible)
    end

    function self:setMenuType(type)
    end

    function self:noskip()
    end
end
