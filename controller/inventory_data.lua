InventoryData = classExtends(Controller, function(user)
    self.user = user
    self.xsize = xsize
    self.ysize = ysize

    self.slots = {}
    for y = 1, self.ysize do
        for x = 1, self.xsize do
            self.slots[x .. '-' .. y] = {
                locked = false,
                original_slot = false,
                item = false,
                xy = x .. '-' .. y,
            }
        end
    end

    function self:addItem(item)
        for y = 1, self.ysize do
            for x = 1, self.xsize do
                local slot = self.slots[x .. '-' .. y]
                local function isItem(item)
                    for yy = 0, item.size - 1 do
                        if self.slots[x .. '-' .. (y + yy)].item then
                            return true
                        end
                    end
                    return false
                end

                if not isItem(slot.item) then
                    slot.item = item
                    for yy = 1, item.size - 1 do
                        local new_slot = self.slots[x .. '-' .. (y + yy)]
                        new_slot.item = item
                        new_slot.locked = true
                        new_slot.original_slot = slot.xy
                    end
                    return true
                elseif slot.item.id == item.id and slot.item.amount < slot.item.stack then
                    local is_added, amount_residue = slot.item:addAmount(item.amount)

                    if amount_residue > 0 and amount_residue < item.amount then
                        item.amount = amount_residue
                        return self:addItem(item)
                    elseif is_added then
                        return true
                    end
                end
            end
        end

        return false
    end

    function self:isItem(item_id, amount, xy)
        if not xy then
            local temp_amount = 0
            local temp_slots = {}

            for y = self.ysize, 1, -1 do
                for x = self.xsize, 1, -1 do
                    local slot = self.slots[x .. '-' .. y]

                    if slot.item and slot.item.id == item_id and not slot.locked then
                        if slot.item.amount + temp_amount >= amount then
                            local temp_slot = false

                            if slot.item.amount > amount - temp_amount then
                                temp_slot = slot
                            else
                                table.insert(temp_slots, slot)
                            end

                            return true, temp_slots, temp_slot, amount - temp_amount
                        else
                            temp_amount = temp_amount + slot.item.amount
                            table.insert(temp_slots, slot)
                        end
                    end
                end
            end
        else
            local slot = self.slots[xy]

            if slot.item and slot.item.id == item_id and not slot.locked then
                return true, {slot}, false, 0
            end
        end

        return false
    end

    function self:removeItem(item_id, amount, xy)
        local is_item, slots_to_remove, slot_to_subtract, withdraw = self:isItem(item_id, amount, xy)

        if is_item then
            for _, i in pairs(slots_to_remove) do
                i.item = false

                if not i.locked then
                    local array = table.toTable(i.item.xy, '-')
                    local x, y = array[1], array[2]
                    for yy = 1, i.size - 1 do
                        local new_slot = self.slots[x .. '-' .. (y + yy)]
                        new_slot.item = false
                    end
                end
            end

            if slot_to_subtract then
                slot_to_subtract.item:addAmount(-withdraw)
            end

            return true
        end

        return false
    end
end)

function InventoryData:swapSlots(slot1, slot2)
    local temp1, temp2 = slot1.item, slot2.item

    slot1.item = temp2
    slot2.item = temp1
end
