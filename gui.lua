local ga = gajosframework

ga.GUI = class(function(user)
    self.user = user

    -- windows --
    self.clicked = false

    function self:newWindow(...)
        local window = ga.GUI_Window.new(self, ...)
        return window
    end

    -- hudtxts --
	self.is_hudtxt = {}
	for i = 0, 49 do
		self.is_hudtxt[i] = true
    end

    function self:newHudtxt(...)
        local hudtxt = ga.GUI_Hudtxt.new(self, ...)
        return hudtxt
    end

    function self:requestHudtxtId()
        for i = 0, 49 do
            if self.is_hudtxt[i] then
                self.is_hudtxt[i] = false
                return i
            end
        end
        return -1
    end

    function self:addHudtxtId(hudtxt_id)
        self.is_hudtxt[hudtxt_id] = true
    end
end)

ga.GUI_Window_list = {}
ga.GUI_Window_styles = {}
ga.GUI_Window = class(function(gui, style, align, x, y)
    local screenw, screenh = 850, 480
    if Game.mp_hudscale == 0 then
        screenw, screenh = user.screenh, user.screenh
    end

    self.user = gui.user; local user = self.user
    self.gui = gui
    self.style = ga.GUI_Window_styles[style]
    self.x, self.y = ga.GUI.fixpos(align, screenw, screenh, self.style.width, self.style.height, x, y)

    self.img = false
    if self.style.path then
        self.img = TImage.LoadGUIImage(self.style.path, self.x + math.floor(self.style.width / 2), self.y + math.floor(self.style.height / 2), TFlags(nil), user.id)
    end

    if self.style.alpha then
        self.img:SetAlpha(self.style.alpha)
    end

    self.buttons = {}
    self.hudtxts = {}
    self.images = {}

    function self:addButton(...)
        local button = ga.GUI_Button.new(self, ...)
        table.insert(self.buttons, button)

        return button
    end

    function self:addHudtxt(text, x, y, window_align, size)
        local hudtxt = user:addHudtxt(text, x, y, window_align, size, self)
        table.insert(self.hudtxts, hudtxt)

        return hudtxt
    end

    function self:insertImage(img)
        table.insert(self.images, img)
    end

    function self:removeImage(img)
        table.removeValue(self.images, img)
    end

    function self:go(duration, x, y)
        if x then self.x = self.x + x end
        if y then self.y = self.y + y end
        if self.img then
            self.img:AnimatePosition(duration, self.x, self.y, 0)
        end

        for _, v in pairs(self.buttons) do
            v:go(duration, x, y)
        end

        for _, v in pairs(self.hudtxts) do
            v:go(duration, x, y)
        end

        for _, v in pairs(self.images) do
            v:AnimatePosition(duration, x, y, 0)
        end
    end

    function self:remove()
        if self.img then
            self.img:Remove()
            self.img = false
        end

        for _, v in pairs(self.buttons) do
            v:remove()
            table.removeValue(self.buttons, self)
        end

        for _, v in pairs(self.hudtxts) do
            v:remove()
        end

        for _, v in pairs(self.images) do
            v:Remove()
        end

        table.removeValue(ga.GUI_Window_list, self)
    end

    table.insert(ga.GUI_Window_list, self)
end)

ga.GUI_Button_list = {}
ga.GUI_Button_styles = {}
ga.GUI_Button = class(function(window, style, align, x, y)
    self.user = window.user; local user = self.user
    self.window = window
    self.style = ga.GUI_Button_styles[style]
    self.hover_alpha = self.style.hover_alpha or 0.3
    self.x, self.y = ga.GUI.fixpos(align, self.window.style.width, self.window.style.height, self.style.width, self.style.height, x, y)
    self.x = self.x + self.window.x
    self.y = self.y + self.window.y
    self.img_x, self.img_y = self.x + math.floor(self.style.width / 2), self.y + math.floor(self.style.height / 2)

    self.img = false
    if self.style.path == 'debug' then
        self.img = TImage.LoadGUIImage(ga.DIR.gfx .. '1x1.png', self.img_x, self.img_y, TFlags(nil), user.id)
        self.img:SetScale(self.style.width, self.style.height)
        self.img:SetColor(255, 0, 0)
    elseif self.style.path then
        self.img = TImage.LoadGUIImage(self.style.path, self.img_x, self.img_y, TFlags(nil), user.id)
    end

    if self.style.alpha then
        self.img:SetAlpha(self.style.alpha)
    end

    self.hover_img = false
    if self.style.hover_path == 'auto' then
        self.hover_img = TImage.LoadGUIImage(ga.DIR.gfx .. '1x1.png', self.img_x, self.img_y, TFlags(nil), user.id)
        self.hover_img:SetScale(self.style.width, self.style.height)
        self.hover_img:SetAlpha(0)
    elseif self.style.hover_path then
        self.hover_img = TImage.LoadGUIImage(self.style.hover_path, self.img_x, self.img_y, TFlags(nil), user.id)
        self.hover_img:SetAlpha(0)
    end

    self.onClick = false
    self.onHover = false
    self.hovered = false
    self.hudtxts = {}

    function self:click()
        if self.onClick and self.onClick(self.user, self.window, user.mousex, user.mousey) == 1 then
            return
        end
        -- do nothing
    end

    function self:hover()
        if not self.hovered then
            self.hovered = true

            if self.onHover and self.onHover(self.user, self.window, user.mousex, user.mousey) == 1 then
                return
            end

            if self.hover_img then
                self.hover_img:SetAlpha(self.hover_alpha)
            end
        end
    end

    function self:unhover()
        if self.hovered then
            self.hovered = false

            if self.onUnhover and self.onUnhover(self.user, self.window, user.mousex, user.mousey) == 1 then
                return
            end

            if self.hover_img then
                self.hover_img:SetAlpha(0)
            end
        end
    end

    function self:addHudtxt(text, x, y, button_align, size)
        local hudtxt = user:addHudtxt(text, x, y, button_align, size, self)
        table.insert(self.hudtxts, hudtxt)

        return hudtxt
    end

    function self:setAlpha(alpha, time)
        if not time or time == 0 then
            self.img:SetAlpha(alpha)
        else
            self.img:AnimateAlpha(time, alpha)
        end
    end

    function self:setRot(rot)
        self.img:SetPosition(self.img.x, self.img.y, rot)
    end

    function self:go(duration, x, y)
        if x then self.x = self.x + x end
        if y then self.y = self.y + y end
        if self.img or self.hover_img then
            if x then self.img_x = self.img_x + x end
            if y then self.img_y = self.img_y + y end
        end
        if self.img then
            self.img:AnimatePosition(duration, self.img_x, self.img_y, 0)
        end
        if self.hover_img then
            self.hover_img:AnimatePosition(duration, self.img_x, self.img_y, 0)
        end

        for _, v in pairs(self.hudtxts) do
            v:go(duration, x, y)
        end
    end

    function self:remove()
        if self.img then
            self.img:Remove()
            self.img = false
        end

        if self.hover_img then
            self.hover_img:Remove()
            self.hover_img = false
        end

        for _, v in pairs(self.hudtxts) do
            v:remove()
        end

        table.removeValue(ga.GUI_Button_list, self)
    end

    table.insert(ga.GUI_Button_list, self)
end)

ga.GUI_Hudtxt = class(function(gui, text, x, y, gui_obj_align, size, gui_obj)
    local screenw, screenh = 850, 480
    if Game.mp_hudscale == 0 then
        screenw, screenh = user.screenh, user.screenh
    end

    self.user = gui.user; local user = self.user
    self.gui = gui
    self.text = text
    self.x, self.y = ga.GUI.fixpos(gui_obj_align, screenw, screenh, 0, 0, x, y)
    self.size = size or 13

    self.align = 0
    self.valign = 0
    if gui_obj_align == 'c' then
        self.align = 1
        self.valign = 1
    elseif gui_obj_align == 'tr' then
        self.align = 2
        self.valign = 0
    elseif gui_obj_align == 'br' then
        self.align = 2
        self.valign = 2
    elseif gui_obj_align == 'bl' then
        self.align = 0
        self.valign = 2
    elseif gui_obj_align == 'tc' then
        self.align = 1
        self.valign = 0
    elseif gui_obj_align == 'bc' then
        self.align = 1
        self.valign = 2
    elseif gui_obj_align == 'lc' then
        self.align = 0
        self.valign = 1
    elseif gui_obj_align == 'rc' then
        self.align = 2
        self.valign = 1
    end

    if gui_obj then
        self.x, self.y = ga.GUI.fixpos(gui_obj_align, gui_obj.style.width, gui_obj.style.height, 0, 0, x, y)
        self.x = self.x + gui_obj.x
        self.y = self.y + gui_obj.y
    end

    self.hudtxt_id = self.gui:requestHudtxtId()
    hudtxt2(self.user.id, self.hudtxt_id, self.text, self.x, self.y, self.align, self.valign, self.size)

    function self:setText(txt)
        self:remove()
        user:addHudtxt(txt or '', x, y, gui_obj_align, self.size, gui_obj)
    end

    function self:setAlpha(alpha, duration)
        hudtxtalphafade(user.id, self.hudtxt_id, duration or 1, alpha)
    end

    function self:go(duration, x, y)
        if x then self.x = self.x + x end
        if y then self.y = self.y + y end

        hudtxtmove(self.user.id, self.hudtxt_id, duration, self.x, self.y)
    end

    function self:remove()
        hudtxt2(self.user.id, self.hudtxt_id, '', 0, 0, 0, 0, '')
        self.gui:addHudtxtId(self.hudtxt_id)
    end
end)

-- static methods --
function ga.GUI_Window.AddStyle(key, tab)
    ga.GUI_Window_styles[key] = tab
end

function ga.GUI_Button.AddStyle(key, tab)
    ga.GUI_Button_styles[key] = tab
end

function ga.GUI.fixpos(align, xarea, yarea, width, height, x, y, oy)
    if align == 'tr' then
        x = xarea - x - width
    elseif align == 'br' then
        x = xarea - x - width
        y = yarea - y - height + (oy or 0)
    elseif align == 'bl' then
        y = yarea - y - height + (oy or 0)
    elseif align == 'c' then
        x = xarea - x - math.floor(xarea / 2) - math.floor(width / 2)
        y = yarea - y - math.floor(yarea / 2) - math.floor(height / 2)
    elseif align == 'tc' then
        x = xarea - x - math.floor(xarea / 2) - math.floor(width / 2)
    elseif align == 'bc' then
        x = xarea - x - math.floor(xarea / 2) - math.floor(width / 2)
        y = yarea - y - height + (oy or 0)
    end

    return x, y
end

-- init --
local function update(user)
    local x, y = user.mousex, user.mousey

    for _, v in pairs(ga.GUI_Button_list) do
        if v.user == user then
            if misc.isInside(x, y, v.x, v.y, v.x + v.style.width, v.y + v.style.height) then
                if user._gui.clicked then
                    v:click()
                else
                    local func = function()
                        v:hover()
                    end
                    timerEx(1, func, 1)
                end
            else
                v:unhover()
            end
        end
    end

    user._gui.clicked = false
end

local function onClick(id, key, state)
    local user = getPlayerInstance(id)

    if user then
        if key == 'mouse1' then
            if state == 0 then
                user._gui.clicked = true
                reqcld(user.id, 0)
            end
        end

        update(user)
    end
end
addhook('key', onClick)
addbind('mouse1')

local function onHover()
    for _, id in pairs(player(0, 'table')) do
        local user = getPlayerInstance(id)
        reqcld(user.id, 0)
        update(user)
    end
end
addhook('ms100', onHover)

--TEST
function onClientdata(id, mode, x, y)
    local user = getPlayerInstance(id)

    if not user then return end

    if mode == 0 then
        user.mousex, user.mousey = x, y
    end
end
addhook('clientdata', onClientdata)
