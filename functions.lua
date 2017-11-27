-- local ga = gajosframework

-- function ga.getMessage(message, type, custom_tag)
--     local tag = switch() {
--         warning = function()
--             return COLOR.red
--         end,

--         info = function()
--             return COLOR.blue
--         end,

--         alert = function()
--             return COLOR.orange
--         end,

--         success = function()
--             return COLOR.light_green_accent
--         end,

--         [Default] = function()
--             return '\169' .. VAR.server_color
--         end,
--     }

--     tag = tag .. (custom_tag or VAR.server_tag)
--     local txt = tag .. ': ' .. COLOR.white

--     message = message:gsub('[>][>]', COLOR.red_lighten)
--     message = message:gsub('[<][<]', COLOR.white)

--     return txt .. message
-- end

_dofile = dofile
function dofile(path, create)
    if not io.exists(path) then
        if create then
            local file = io.open(path, 'w')
            io.close(file)

            print('The file "'..path..'" couldn\'t be found or opened, creating new one...', 'notice')
        else
            print('The file "'..path..'" couldn\'t be found or opened!', 'error')
        end

        return false
    end

    _dofile(path)
    return true
end

function io.exists(path)
    local file = io.open(path, 'r')

    if file then
        io.close(file)
        return true
    else
        return false
    end
end

_msg = msg
function msg(text, type, prefix)
    message = ga.getMessage(text, type, prefix)
    _msg(message)
end

_msg2 = msg2
function msg2(id, text, type, prefix)
    message = ga.getMessage(text, type, prefix)
    _msg2(id, message)
end

function print2(text, type, prefix)
    message = ga.getMessage(text, type, prefix)
    print(message)
end

function log(message)
end
