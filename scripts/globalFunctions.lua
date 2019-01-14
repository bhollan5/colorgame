function drawRed() 
    love.graphics.setColor(redRGB[1],redRGB[2],redRGB[3], 1)
end

function drawYellow() 
    love.graphics.setColor(yellowRGB[1],yellowRGB[2],yellowRGB[3], 1)
end

function drawBlue() 
    love.graphics.setColor(blueRGB[1],blueRGB[2],blueRGB[3], 1)
end

function drawBlack()
    love.graphics.setColor(blackRGB[1], blackRGB[2], blackRGB[3], 1)
end

function drawWhite()
    love.graphics.setColor(whiteRGB[1], whiteRGB[2], whiteRGB[3], 1)
end

function drawColor(color)   -- Takes a string, changes the draw color based on that string.
                            -- Useful if you want to iterate through a table of multiple colors, like in title:draw()
    if color == 'solid' then 
        love.graphics.setColor(solidColor[1], solidColor[2], solidColor[3], 1)
    elseif color == 'bouncy' then 
        love.graphics.setColor(bouncyColor[1], bouncyColor[2], bouncyColor[3], 1)
    elseif color == 'sticky' then 
        love.graphics.setColor(stickyColor[1], stickyColor[2], stickyColor[3], 1)
    elseif color == 'death' then 
        love.graphics.setColor(deathColor[1], deathColor[2], deathColor[3], 1)
    elseif color == 'background' then 
        love.graphics.setColor(backgroundColor[1], backgroundColor[2], backgroundColor[3], 1)
    elseif color == 'blue' then
        drawBlue()
    elseif color == 'yellow' then
        drawYellow() 
    elseif color == 'red' then 
        drawRed()
    elseif color == 'black' then
        drawBlack()
    elseif color == 'white' then
        drawWhite()
    end
end