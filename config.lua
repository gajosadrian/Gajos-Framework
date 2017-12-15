parse('transfer_speed 500')

gajosframework = {
    users = {},
    DIR = {
        gfx = 'gfx/gajosframework/',
    },
}

COLOR_VALUE = {
    ['white'] = '255255255',
    ['black'] = '000000000',
    ['grey'] = '100100100',
    ['grey_lighten'] = '220220220',
    ['red'] = '255050000',
    ['red_lighten'] = '255100050',
    ['magenta'] = '255000255',
    ['blue'] = '050150255',
    ['blue_lighten'] = '090175235',
    ['orange'] = '255128000',
    ['cyan'] = '000255255',
    ['yellow_lighten'] = '241230192',
    ['yellow'] = '255220000',
    ['yellow_darken'] = '240220035',
    ['green'] = '076175080',
    ['light_green'] = '139195074',
    ['light_green_accent'] = '100221023',
}

VAR = {
    server_tag = '[SERVER]',
    server_color = '175255100',
}

COLOR_CODE = string.char(0xC2) .. string.char(0xA9)

-- init --
function C(r, g, b)
    local code = COLOR_CODE

    -- update: return color code when no args are passed
    if not r then
        return code
    end

    g = g or 0
    b = b or 0
    return string.format('%s%0.3u%0.3u%0.3u', code, r, g, b)
end

COLOR = {}
for _, v in pairs(COLOR_VALUE) do
    COLOR[_] = C() .. v
end
