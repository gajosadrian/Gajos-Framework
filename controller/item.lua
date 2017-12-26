Item = classExtends(Controller, function(item_id, amount)
    local conf = ITEMS[item_id]

    self.id = item_id
    self.name = conf.name
    self.path_d = conf.path_d .. '.png'
    self.path = conf.path .. '.png'
    self.drop = conf.drop
    self.drop_amount = conf.drop_amount or 1
    self.health = conf.health
    self.stack = conf.stack or 1
    self.vars = conf.vars or false
    self.amount = 0
    self.onHover = false
    self.onUnhover = false

    function self:setVar(name, value)
        self.vars[name] = value
    end

    function self:getVar(name)
        return self.vars[name] or nil
    end

    function self:addHP(hp)
        self.health = self.health + hp

        if self.health <= 0 then
            self:remove()
            return false
        end
        return true
    end

    function self:addAmount(amount)
        if self.amount + amount <= self.stack then
            self.amount = self.amount + amount

            if self.amount <= 0 then
                self:remove()
            end

            return true, 0
        else
            local temp = self.amount
            self.amount = self.stack

            return false, (temp + amount - self.stack)
        end
    end

    function self:remove()
        self = false
    end

    -- constructor
    if not self:addAmount(amount or 1) then
        self.amount = self.stack
    end

    -- CONTROLLER --
    function self:onHover(...)
        if self.onHover then
            self.onHover(...)
        end
    end

    function self:onUnhover(...)
        if self.onUnhover then
            self.onUnhover(...)
        end
    end
end)
