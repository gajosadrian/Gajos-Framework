function onPlayerServeraction(user, key)
    if key == 1 then
        local menu = user:newMenu('Test title', true)
        menu:addButton('Test button', 'test description', function()
            user:equip(45)
            user.weapon = 45
        end)

        menu:show()
    end
end

function onPlayerBind(user, key, state)
    if state == 1 then
        msg('test')
        parse('speedmod 1 15')
    end
    if state == 0 then
        parse('speedmod 1 0')
    end
    return 1
end
addbind('space')




local img = image('gfx/gui_load.bmp', 0, 0, 2)
local rot = 0
function onServerAlways()
    local dist = misc.screen_border_dist(rot)
    local x, y = misc.pos_trigger(425, 240, rot, dist - 20)

    imagepos(img, x, y, 0)

    rot = rot + 1
    if rot == 360 then rot = 0 end
end
