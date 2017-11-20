local ga = gajosframework

ga.Menu = classExtends(Model, function(controller, user)
    self.id = id
    self.controller = controller
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

    function self:noskip()
        self:setNoskip(true)
    end

    function self:show()
        self.view:show()
    end

    controller.cached_menu = self
end
