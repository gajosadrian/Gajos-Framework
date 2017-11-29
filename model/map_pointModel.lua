local ga = gajosframework

ga.MapPointModel = classExtends(Model, function(controller, user)
    self.controller = controller
    self.user = user

    function self:init(path, alpha)
        self.img = TImage.LoadGUIImage(path, 0, 0, TFlags(nil), user.id)

        if alpha then
            self.img:SetAlpha(alpha)
        end

        controller:update()
    end

    function self:remove()
        self.img:Remove()
    end
end)
