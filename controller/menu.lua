local ga = gajosframework

ga.Menu = classExtends(Controller, function(user, title, noskip)
    self.user = user
    self.model = ga.MenuModel.new(self, user)
    self.view = ga.MenuView.new(user)

    self.cached_menu = false

    function self:addButton(name, desc, visible, onClick)
        self.model:addButton(name, desc, visible, onClick)
    end

    function self:setMenuType(type)
        self.model:setType(type)
    end

    function self:setNoskip(state)
        self.model:setNoskip(state)
    end

    function self:noskip()
        self:setNoskip(true)
    end

    function self:show(page)
        self.view:show(self, self.model.title, self.model.type, self.model.buttons, page)
    end

    -- constructor
    self:setTitle(title)
    self:noskip(noskip or false)
end
