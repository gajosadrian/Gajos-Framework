local ga = gajosframework

ga.SkinModel = classExtends(Model, function(controller, user)
    self.user = user
    self.path = false

    function self:setPath(path)
        self.path = path
    end
end)
