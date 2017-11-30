local ga = gajosframework

ga.MainMenu = classExtends(Controller, function(user)
    self.user = user
    self.model = ga.MainMenuModel.new(self, user)
    self.view = ga.MainMenuView.new(user)

    function self:setBackground(path, darkness)
        self.model:setBackground(path)

        if darkness then
            self.model:setBackgroundColor(255 * (1 - darkness), 255 * (1 - darkness), 255 * (1 - darkness))
        end
    end

    function self:show()
        self.view:init()
        self.view:showBackground(self.model.background)
        self.view:drawNavItems(self.model.nav_items)
        self:loadNavItem()
    end

    function self:hide()
        self.view:hideBackground(self.model.background)
        self.view:remove()
    end

    function self:showTutorial()
        self.view:showTutorial()
    end

    function self:hideTutorial()
        self.view:hideTutorial()
    end

    function self:setNavItems(items)
        self.model:setNavItems(items)
    end

    function self:setPages(pages)
        self.model:setPages(pages)
    end

    function self:loadNavItem()
        local item = self.model.nav_items[self.view.current_nav_item]

        self.view:loadNavItem(self.view.current_nav_item, item.name, item.onShow, true)
        return true
    end
end)

ga.GUI_Window.AddStyle('ga_mainmenu', {
    width = 850,
    height = 400,
})

ga.GUI_Button.AddStyle('ga_arrow', {
    path = ga.DIR.gfx .. 'hud_arrow.bmp',
    width = 32,
    height = 32,
})

ga.GUI_Button.AddStyle('ga_slot', {
    width = 32,
    height = 32,
})

ga.GUI_Button.AddStyle('ga_bigslot', {
    width = 50,
    height = 50,
})

ga.GUI_Button.AddStyle('ga_nav_item', {
    -- path = 'debug',
    width = 100,
    height = 25,
})
