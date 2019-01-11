function drawRed() 
    love.graphics.setColor(redRGB[1],redRGB[2],redRGB[3], 1)
end

function drawYellow() 
    love.graphics.setColor(yellowRGB[1],yellowRGB[2],yellowRGB[3], 1)
end

function drawBlue() 
    love.graphics.setColor(blueRGB[1],blueRGB[2],blueRGB[3], 1)
end

function drawColor(color)   -- Takes a string, changes the draw color based on that string.
                            -- Useful if you want to iterate through a table of multiple colors, like in title:draw()
    if color == 'blue' then
        drawBlue()
    elseif color == 'yellow' then
        drawYellow() 
    elseif color == 'red' then 
        drawRed()
    end
end