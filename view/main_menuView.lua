local ga = gajosframework

ga.MainMenuView = classExtends(View, function(user)
    local this = self
    local room_speed = 400
    self.user = user

    self.nav_items = {}
    self.nav_marker = false
    self.current_nav_item = 1

    function self:init()
        self.prev_window = false
        self.window = user:newWindow('ga_mainmenu', 'tl', 0, 40)
        self.nav_window = user:newWindow('ga_mainmenu', 'tl', 0, 40)
        self.tut_window = user:newWindow('ga_mainmenu', 'tl', 0, 40)        

        self.nav_marker = TImage.LoadGUIImage(ga.DIR.gfx .. '1x1.png', 0, 0, TFlags(nil), user.id)
        self.nav_marker:SetScale(70, 1)
        self.nav_marker:SetAlpha(0.5)
    end

    function self:remove()
        self.window:remove()
        self.nav_window:remove()
        self.tut_window:remove()

        self.nav_marker:Remove()

        if self.prev_window then
            self.prev_window:remove()
        end
    end

    function self:setNavItem(nav_item_id, x, y)
        self.nav_items[nav_item_id] = {
            x = x,
            y = y,
        }
    end

    function self:markNavItem(nav_item_id, instant)
        local nav_item = self.nav_items[nav_item_id]

        if not instant then
            self.nav_marker:AnimatePosition(room_speed, nav_item.x, nav_item.y, 0)
        else
            self.nav_marker:SetPosition(nav_item.x, nav_item.y, 0)
        end
    end

    function self:showBackground(background)
        background:SetAlpha(1)
        user:hideWeapon()
    end

    function self:hideBackground(background)
        background:SetAlpha(0)
        user:showWeapon()
    end

    function self:showTutorial()
        local window = self.tut_window

        local button = window:addButton('ga_arrow', 'bl', 55, 0)
        button:setRot(180)
        button:addHudtxt(COLOR.white .. 'Click `Map`', 0, 35, 'bc', 16)

        local button = window:addButton('ga_bigslot', 'bl', 45, -45)
        button.onClick = function()
            this:hideTutorial(window)
        end
    end

    function self:hideTutorial()
        local window = self.tut_window

        if window then
            window:remove()
        end
    end

    function self:drawNavItems(items)
        local window = self.nav_window

        local hudtxt_size = 16
        local root_x, root_y = 40, 20
        local adder = 80
        local img_y = root_y + hudtxt_size + 50

        do
            local x_scale = root_x + #items * adder
            local x = x_scale / 2
            local img = TImage.LoadGUIImage(ga.DIR.gfx .. '1x1.png', x, img_y, TFlags(nil), user.id)
            img:SetScale(x_scale, 1)
            img:SetAlpha(0.1)
            window:insertImage(img)
        end

        for _, item in pairs(items) do
            local x = root_x + (_ - 1) * adder

            local button = window:addButton('ga_nav_item', 'tl', x, root_y)
            button.onClick = function()
                self:loadNavItem(_, item.name, item.onShow)
            end

            local hudtxt = button:addHudtxt(COLOR.grey_lighten .. item.name, 0, 0, 'c', hudtxt_size)
            button.onHover = function()
                hudtxt:setAlpha(1, room_speed)
            end
            button.onUnhover = function()
                hudtxt:setAlpha(0.8, room_speed)
            end
            hudtxt:setAlpha(0.8)

            self:setNavItem(_, x + adder / 2, img_y)
        end
    end

    function self:loadNavItem(nav_item_id, name, onShow, instant)
        if self.current_nav_item == nav_item_id and not instant then
            return false
        end

        local adder
        if nav_item_id > self.current_nav_item then
            adder = 850
        elseif nav_item_id < self.current_nav_item then
            adder = -850
        end
        self.current_nav_item = nav_item_id
        self:markNavItem(nav_item_id, instant)

        if instant then
            onShow(user, self.window)
        else
            local old_window = self.window
            old_window:go(room_speed, -adder, false)
            local function func()
                old_window:remove()
            end
            timerEx(room_speed, func, 1)

            local window = user:newWindow('ga_mainmenu', 'tl', adder, 40)
            onShow(user, window)
            window:go(room_speed, -adder, false)
            self.window = window
        end

        return true
    end
end)
