local ga = gajosframework

ga.MainMenuView = classExtends(View, function(user)
    function self:showBackground(background)
        background:SetAlpha(1)
    end

    function self:drawNavItems()
    end
end)