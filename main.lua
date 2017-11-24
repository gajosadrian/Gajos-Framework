function getDirectories(dir)
    local t = {}

    for name in io.enumdir(dir) do
        if name ~= '.' and name ~= '..' then
            table.insert(t, name)
        end
    end

    return t
end

function ga.msg(id, message, _type, custom_tag)
    local tag
    if _type == 'warning' then
        tag = COLOR.red
    elseif _type == 'info' then
        tag = COLOR.blue
    elseif _type == 'alert' then
        tag = COLOR.orange
    elseif _type == 'success' then
        tag = COLOR.light_green_accent
    else
        tag = '\169' .. VAR.server_color
    end
    tag = tag .. (custom_tag or VAR.server_tag)
    local txt = tag .. ': ' .. COLOR.white

    message = message:gsub('[>][>]', COLOR.red_lighten)
    message = message:gsub('[<][<]', COLOR.white)

    if not id or id == 0 then
        msg(txt .. message)
    elseif id == -1 then
        return txt .. message
    else
        msg2(id, txt .. message)
    end
end
