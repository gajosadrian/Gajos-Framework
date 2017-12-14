Lottery = class(function()
    -- list of entries in the lottery. Elements are of the form
    self._entries = {}

    -- total number of lots in the pool
    -- Lots can come in decimals as well, like 0.02
    self._lotsTotal = 0

    -- Adds a new entry to the lottery, 
    -- i.e. a participant with a given number of lots
    function self:addEntry(participant, lots)
        lots = lots or 1

        table.insert(self._entries, {
            ['participant'] = participant,
            ['lots'] = lots,
        })

        self._lotsTotal = self._lotsTotal + lots
    end

    -- Determines the winner of the lottery based on the number of lots that
    -- each participant has. Lots and their owners are all lined up, then
    -- the RNG determines the position of the winning lot.
    function self:getWinner()
        if(self._lotsTotal == 0) then return(false) end

        -- * 1,000,000, to make sure that lots in decimal form are handled correctly
        local rand = math.random(0, self._lotsTotal * 1000000)

        local currentLot = 0
        for _, entry in pairs(self._entries) do
            currentLot = currentLot + entry['lots'] * 1000000

            if(currentLot >= rand) then
                return entry['participant']
            end
        end

        return false -- should never happen
    end
end)
