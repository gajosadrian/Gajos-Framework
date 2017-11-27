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

dofile(_DIR .. 'functions.lua')

do
    local dirs = {
        _DIR .. 'lib/',
        _DIR .. 'app/',
    }

    dofile(_DIR .. 'app/config.lua')

    for k, dir in pairs(dirs) do
        for _, v in pairs(enumDir(dir)) do
            if v:sub(-4) == '.lua' then
                dofile(dir .. v)
            end
        end
    end

    dofile(_DIR .. 'app/main.lua')
end

dofile(_DIR .. 'config.lua')
dofile(_DIR .. 'user.lua')