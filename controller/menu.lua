local ga = gajosframework

ga.Menu = classExtends(Controller, function(user, title, noskip)
    self.user = user
    self.model = ga.MenuModel.new(self, user)
    self.view = ga.MenuView.new(user)

    function self:addButton(name, desc, onClick, visible)
        self.model:addButton(name, desc, onClick, (visible == nil) and true or visible)
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
        self.view:show(self.model.title, self.model.type, self.model.buttons, page)
        user._cached_menu = self
    end

    -- constructor
    self.model:setTitle(title)
    self:setNoskip(noskip or false)
end)

local function onMenu(id, t, btn)
    local user = getPlayerInstance(id)
    local are_pages = t:find('#')
    local page = 1

    if are_pages then
        page = tonumber(misc.toTable(t, '#')[2])
    end

    user._cached_menu.model:onMenu(page, btn, are_pages)
end
addhook('menu', onMenu)
