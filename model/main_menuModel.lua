local ga = gajosframework

ga.MainMenuModel = classExtends(Model, function(controller, user)
    self.controller = controller
    self.user = user
    self.background = false
    self.nav_items = false

    function self:setBackground(path)
        self.background = TImage.LoadGUIImage(path, 425, 240, TFlags(nil), user.id)
        self.background:SetAlpha(0)
    end

    function self:setBackgroundColor(r, g, b)
        self.background:SetColor(r, g, b)
    end

    function self:setNavItems(items)
        self.nav_items = items
    end
end)