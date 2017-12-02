local ga = gajosframework

ga.Skin = classExtends(Controller, function(user, path)
    self.user = user
    self.path = path

    self.img = TImage.LoadPlayerImage('<spritesheet:' .. self.path .. ':32:32>', TImage.mode.top, user.id, TFlags(TImage.flag.recoil))

    function self:remove()
    end
end)