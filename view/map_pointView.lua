local ga = gajosframework

ga.MapPointView = classExtends(View, function(user)
    self.user = user
    self.see = false

    function self:update(img, x, y, rotate)
        local playerX, playerY = user.x, user.y
        local dist = misc.point_distance(playerX, playerY, x, y)
        local angle = misc.point_direction(playerX, playerY, x, y)
        local edge_dist = misc.screen_border_dist(angle)

        local rot = 0
        if rotate then
            rot = angle
        end

        if dist > edge_dist then
            local newX, newY = misc.pos_trigger(425, 240, angle, edge_dist - 30)
            img:AnimatePosition(200, newX, newY, rot)

            if not self.see then
                self.see = true
                img:SetAlpha(1)
            end
        else
            if self.see then
                self.see = false
                img:SetAlpha(0)
            end
        end
    end

    function self:setColor(img, r, g, b)
        img:SetColor(r, g, b)
    end
end)
