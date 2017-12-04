local ga = gajosframework

local weapons = {
    pistols = {1, 2, 3, 4, 5, 6},
    rifles = {10, 11, 20, 21, 22, 23, 24, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 91, 40, 45, 46, 47, 48, 49, 88, 90},
    melees = {50, 69, 74, 85, 51, 52, 53, 54, 72, 73, 75, 76, 86, 89, 77, 87, 41, 55},
    hands = {78},
}

ga.SkinView = classExtends(View, function(user)
    self.user = user
    self.img = false

    function self:init(path)
        -- init --
        self.img = TImage.LoadPlayerImage(path, TImage.mode.top, user.id, TFlags(TImage.flag.recoil))
        local width, height = self.img.width, self.img.height
        self.img:Remove()
        -- end init --

        local frame_width, frame_height = (width / 2), (height / 3)
        local scale = 32 / frame_width
        self.img = TImage.LoadPlayerImage('<spritesheet:' .. path .. ':' .. frame_width .. ':' .. frame_height .. '>', TImage.mode.top, user.id, TFlags(TImage.flag.recoil))

        if scale < 1 then
            self.img:SetScale(scale, scale)
        end
    end

    function self:update(weapon_id)
        local function getItemIndex()
            for index, w in pairs(weapons) do
                for _, v in pairs(w) do
                    if v == weapon_id then
                        return index
                    end
                end
            end
        end

        local item_index = getItemIndex()
        if item_index == 'pistols' then
            self.img:SetFrame(4)
        elseif item_index == 'rifles' then
            self.img:SetFrame(5)
        elseif item_index == 'melees' then
            self.img:SetFrame(1)
        elseif item_index == 'hands' then
            self.img:SetFrame(3)
        end
    end

    function self:remove()
        self.img:Remove()
        self.img = false
    end
end)
