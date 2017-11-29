local ga = gajosframework

ga.MainMenu = classExtends(Controller, function(user)
    self.model = ga.MainMenuModel.new(self, user)
    self.view = ga.MainMenuView.new(user)

    function self:setBackground(path, darkness)
        self.model:setBackground(path)

        if darkness then
            self.model:setBackgroundColor(255 * (1 - darkness), 255 * (1 - darkness), 255 * (1 - darkness))
        end
    end

    function self:show()
        self.view:showBackground(self.model.background)
    end

    function self:setNavItems(items)
        self.model:setNavItems(items)
    end
end)