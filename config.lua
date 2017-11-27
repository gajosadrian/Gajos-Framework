gajosframework = {
    users = {},
}

COLOR_VALUE = {
    ['white'] = '255255255',
    ['black'] = '000000000',
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

-- init --
COLOR = {}
for _, v in pairs(COLOR_VALUE) do
    COLOR[_] = '\169' .. v
end