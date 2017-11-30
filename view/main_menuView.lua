local ga = gajosframework

ga.MainMenuView = classExtends(View, function(user)
    self.user = user

    function self:showBackground(background)
        background:SetAlpha(1)
        user:hideWeapon()
    end

    function self:hideBackground(background)
        background:SetAlpha(0)
        user:showWeapon()
    end

    function self:drawNavItems()
    end
end)