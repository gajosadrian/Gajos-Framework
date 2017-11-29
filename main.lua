function enumDir(dir)
    local t = {}

    for name in io.enumdir(dir) do
        if name ~= '.' and name ~= '..' then
            table.insert(t, name)
        end
    end

    return t
end

function getPath()
    local str = debug.getinfo(2, 'S').source:sub(2)
    return str:match('(.*/)')
end

local _DIR = getPath()

dofile(_DIR .. 'config.lua')
dofile(_DIR .. 'hook.lua')

do
    local dir = _DIR .. 'lib/'

    for _, v in pairs(enumDir(dir)) do
        if v:sub(-4) == '.lua' then
            dofile(dir .. v)
        end
    end
end

dofile(_DIR .. 'functions.lua')
dofile(_DIR .. 'user.lua')
dofile(_DIR .. 'gui.lua')

do
    for _, v in pairs( {'model', 'view', 'controller'} ) do
        local dir = _DIR .. v .. '/'
        dofile(dir .. v .. '.lua')

        for k, w in pairs(enumDir(dir)) do
            if w:sub(-4) == '.lua' and w ~= v .. '.lua' then
                dofile(dir .. w)
            end
        end
    end
end

do
    local dir = _DIR .. 'app/',

    dofile(_DIR .. 'app/config.lua', true)
    for _, v in pairs(enumDir(dir)) do
        if v:sub(-4) == '.lua' and v ~= 'config.lua' and v ~= 'main.lua' then
            dofile(dir .. v)
        end
    end
    dofile(_DIR .. 'app/main.lua', true)
end

_VER = '1.00'
print('\169109104238Lua: Successfully loaded `Gajos Framework ' .. _VER .. '`')
