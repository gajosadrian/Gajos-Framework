function onPlayerServeraction(user, key)
    if key == 1 then
        local menu = Menu.new(user, 'Test title', true)
        menu:addButton('Test button', 'test description', function()
            user:equip(45)
            user.weapon = 45
        end)

        menu:show()
    end
end
