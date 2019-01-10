-- Tiling solid blocks: 
for i in ipairs(self.arena) do
    -- *Start calculates the top right corner of the box
    local xStart = self.arena[i].x - (self.arena[i].w / 2)
    local yStart = self.arena[i].y - (self.arena[i].h / 2)

    -- These will be used to iterate through the width and height in increments of 32
    local widthRemaining = self.arena[i].w

    -- We'll subtract 32 from widthRemaining until it's 0
    while widthRemaining > 0 do
        local xVal = xStart + self.arena[i].w - widthRemaining
        local heightRemaining = self.arena[i].h

        while heightRemaining > 0 do
            local yVal = yStart + self.arena[i].h - heightRemaining
            love.graphics.setColor(83,100,229, 1)
            love.graphics.draw(blueTile, xVal, yVal, 0, 1, 1)
            heightRemaining = heightRemaining - 32
        end

        widthRemaining = widthRemaining - 32
    end

    love.graphics.draw(yellowTile, xStart, yStart, 0, 1, 1)
    love.graphics.draw(blueTile, xStart, yStart, 0, 1, 1)
    
end