local _game = game
local game = class(function()
end)

game.__index = function(self, key)
    return _game(key)
end

Game = game.new()