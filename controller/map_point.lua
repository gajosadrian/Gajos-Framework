local ga = gajosframework

MapPoint = classExtends(Controller, function(user, path, x, y, rotate)
    self.user = user
    self.model = ga.MapPointModel.new(self, user)
    self.view = ga.MapPointView.new(user)

    function self:update()
        local playerX, playerY = user.x, user.y
        local dist = misc.point_distance(playerX, playerY, x, y)
        local angle = misc.point_direction(playerX, playerY, x, y)
        local edge = misc.screen_border_dist(angle)
        local rot = 0
        if rotate then
            rot = angle
        end

        if dist > edge then
            local newX, newY = misc.pos_trigger(playerX, playerY, angle, edge)
            imagepos(point.img.image, newX, newY, rot)
        else
            imagepos(point.img.image, point.x, point.y, rot)
        end
    end

    function self:remove()

    end
end)