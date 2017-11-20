local ga = gajosframework

ga.MenuView = classExtends(Model, function(user)
    self.user = user

    function self:show(title, menu_type, buttons, page)
        page = (not page or page > math.ceil(#buttons / 7)) and 1 or page

        local loop_start, loop_end
        local custom_title, custom_str = '', ''
        if #buttons <= 9 then
            loop_start = 1
            loop_end = 9
        else
            loop_start = page * 7 - 6
            loop_end = page * 7
            custom_title = ' #' .. page
            if math.ceil(#buttons / 7) == page then for i = 1, 7 - #buttons % 7 do
                custom_str = custom_str .. ','
            end end
            custom_str = custom_str .. ',,Next|\187'
        end

        local tab = {}
        for i = loop_start, loop_end do
            local button = buttons[i]
            if not button then break end

            table.insert(tab, button.str)
        end

        menu(user.id, title .. custom_title .. menu_type .. ',' ..  table.concat(tab, ',') .. custom_str)
    end
end)
