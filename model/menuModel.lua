local ga = gajosframework

ga.Menu = classExtends(Model, function(controller, user)
    self.id = id
    self.controller = controller
    self.type = ''
    self.title = ''
    self.noskip = false

    function self:addButton(name, desc, visible, onClick)
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

    function self:noskip(state)
        self.noskip = state
    end

    function self:show()
        self.view:show()
    end
end
