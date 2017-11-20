local ga = gajosframework

ga.Menu = classExtends(Model, function(controller, user)
    self.controller = controller
    self.user = user
    self.type = ''
    self.title = ''
    self.noskip = false
    self.buttons = {}

    function self:addButton(name, desc, onClick, visible)
        local name = name:gsub('|', 'l'):gsub(',', '.')
        local desc = desc:gsub('|', 'l'):gsub(',', '.')

        local str = name .. '|' .. desc
        if not visible then
            str = '(' .. str .. ')'
        end

        table.insert(self.buttons, {
            name = name:gsub('|', 'l'):gsub(',', '.'),
            desc = desc:gsub('|', 'l'):gsub(',', '.'),
            str = str,
            onClick = onClick,
        })
    end

    function self:setType(type)
        switch(type) {
            large = function()
                self.type = '@b'
            end,

            invisible = function()
                self.type = '@i'
            end

            [Default] = function()
                self.type = ''
            end,
        }
    end

    function self:setTitle(title)
        self.title = title
    end

    function self:setNoskip(state)
        self.noskip = state
    end

    function self:show()
        self.view:show()
    end

    function self:onMenu(page, btn, are_pages)
        if btn == 0 then
            if self.noskip then
                local function func()
                    controller:show(page)
                end
                timerEx(1, func, 1)
            end

            return
        end

        if not are_pages then
            self.buttons[btn].onClick(user)
        else
            if btn <= 7 then
                self.buttons[(page - 1) * 7 + btn].onClick(user)
            else
                controller:show(page + 1)
            end
        end
    end

    controller.cached_menu = self
end
