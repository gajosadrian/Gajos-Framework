local _game = game
local game = class(function()
end)

game.__index = function(self, key)
    local v = _game(key)
    if tonumber(v) then
        v = tonumber(v)
    end

    return v
end

Game = game.new()
