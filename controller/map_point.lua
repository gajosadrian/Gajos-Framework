local ga = gajosframework

ga.MapPoint_list = {}
ga.MapPoint = classExtends(Controller, function(user, path, x, y, alpha, rotate)
    self.user = user
    self.model = ga.MapPointModel.new(self, user)
    self.view = ga.MapPointView.new(user)

    self.x, self.y = misc.tile_to_pixel(x), misc.tile_to_pixel(y)

    function self:update()
        self.view:update(self.model.img, self.x, self.y, rotate)
    end

    function self:setColor(r, g, b)
        self.view:setColor(self.model.img, r, g, b)
    end

    function self:remove()
        self.model:remove()
        table.removeValue(ga.MapPoint_list, self)
    end

    -- constructor --
    self.model:init(path, alpha)
    table.insert(ga.MapPoint_list, self)
end)

local function onMs100()
    for _, v in pairs(ga.MapPoint_list) do
        v:update()
    end
end
addhook('ms100', onMs100)
