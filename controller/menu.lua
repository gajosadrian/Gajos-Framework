local ga = gajosframework

ga.Menu = classExtends(Controller, function(id)
    self.id = id
    self._logic = ga.MenuModel.new(id)
    self._view = ga.MenuView.new(id)

    function self:addButton(name, desc, visible)
    end

    function self:setMenuType(type)
    end

    function self:noskip()
    end

    function self:show()
    end
end
