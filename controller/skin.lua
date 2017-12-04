local ga = gajosframework

ga.Skin = classExtends(Controller, function(user, path)
    self.user = user
    self.model = ga.SkinModel.new(self, user)
    self.view = ga.SkinView.new(user)

    function self:update(weapon_id)
        self.view:update(weapon_id)
    end

    function self:remove()
        self.view:remove()
    end

    -- constructor --
    self.view:init(path)
    self:update(user.weapon)
end)

local function onSelect(id)
    local user = getPlayerInstance(id)

    if user._skin then
        user._skin:update(user.weapon)
    end
end
addhook('select', onSelect)
