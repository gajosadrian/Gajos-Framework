local ga = gajosframework

mp_respawndelay(255) -- 4min 15s
mp_hudscale(1)

ga.GUI_Window.AddStyle('ga_mainmenu', {
    path = 'gfx/test.jpg',
    width = 850,
    height = 400,
})

ga.GUI_Button.AddStyle('slot', {
    path = 'debug',
    hover_path = 'auto',
    width = 100,
    height = 100,
})

function onPlayerJoin(user)
    local menu = user.mainMenu
    menu:setBackground('gfx/starwars/menu-background.jpg', 0.2)
    menu:setNavItems({
        {
            name = 'HOME',
            onShow = function(user)
                msg('home')
            end,
        },
        {
            name = 'SOLDIER',
            onShow = function(user)
                msg('soldier')
            end,
        },
        {
            name = 'STORE',
            onShow = function(user)
                msg('store')
            end,
        },
    })
end

function onPlayerServeraction(user, key)
    if key == 1 then
        local window = user:newWindow('ga_mainmenu', 'tl', 0, 40)
        window:addHudtxt('Button 123', 0, 0, 2, 0, false, 'br')
        local btn = window:addButton('slot', 'c', 0, 0)
        btn.onClick = function()
            msg('works')
        end
        btn:addHudtxt('BTN', 0, 0, 'c')
    elseif key == 3 then
        local menu = user:newMenu('Test title', true)
        menu:addButton('Test button', 'test description', function()
            user:equip(45)
            user.weapon = 45
        end)

        menu:show()
    end
end

function onPlayerJoined(user)
    user.mainMenu:show()

    -- local p1 = user:newMapPoint('gfx/hud_arrow.bmp', 45, 53, 1, true)
    -- local p2 = user:newMapPoint('gfx/hud_arrow.bmp', 16, 16, 1, true)
    -- p2:setColor(255, 0, 0)
end

function onPlayerAttack(user)
    local blaster_lighting = TImage.LoadMapImage('gfx/starwars/blaster-lighting_red.png', 1, user.x, user.y, TFlags(nil), 0)
    blaster_lighting:SetPosition(user.x, user.y, user.rot)
    blaster_lighting:SetAlpha(0.7)

    local x, y = misc.pos_trigger(user.x, user.y, user.rot, 1000)
    blaster_lighting:AnimatePosition(500, x, y, user.rot)
end

-- function onPlayerBind(user, key, state)
--     if state == 1 then
--         msg('test')
--         parse('speedmod 1 15')
--     end
--     if state == 0 then
--         parse('speedmod 1 0')
--     end
--     return 1
-- end
-- addbind('space')

-- local img = image('gfx/gui_load.bmp', 0, 0, 2)
-- local rot = 0
-- function onServerAlways()
--     local dist = misc.screen_border_dist(rot)
--     local x, y = misc.pos_trigger(425, 240, rot, dist - 20)

--     imagepos(img, x, y, 0)

--     rot = rot + 1
--     if rot == 360 then rot = 0 end
-- end
