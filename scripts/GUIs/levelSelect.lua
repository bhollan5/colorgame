levelSelect = {}


levelSelect.levelOptions = {{'1', '2', '3'},
                            {'4', '5', '6'}}    -- Note, this is a double linked array!
                                                -- You can reference any of it's values like this:
                                                -- levelOptions[2][3] would return '6'
levelSelect.selection = {1, 1}
levelSelect.keyBuffer = true

levelSelect.startChange = false
levelSelect.textHeight = 0

function levelSelect:load()

end

function levelSelect:update(dt)

    -- Selecting with keyboard
    if (love.keyboard.isDown("up") or love.keyboard.isDown("down")) and levelSelect.keyBuffer then
        if levelSelect.selection == 'start' then
            levelSelect.selection = 'levels'
        else 
            levelSelect.selection = 'start'
        end
        levelSelect.keyBuffer = false
    elseif not love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
        levelSelect.keyBuffer = true
    end
    if love.keyboard.isDown("return") and not self.startChange then 
        if levelSelect.selection == 'start' then
            self.startChange = true
            -- changeGameState('lvl1')
            
        elseif levelSelect.selection == 'levels' then

        end
    end
    if self.startChange then 
        levelSelect.textHeight = (levelSelect.textHeight + 1) * (1.1) -- makes a kind of quadratic curve, an ease in 
        if levelSelect.textHeight >= 500 then 
            changeGameState('lvl1')
        end
    end

end

function levelSelect:draw()

    -- Finding the midway x value
    local midX = love.graphics.getWidth() / 2


    -- TITLE TEXT:
    love.graphics.setFont(headerFont) -- Biggest font yet

    local startYPos = 100
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("MONDRIAN", midX - ((headerFontSize / 4) * 8), startYPos - levelSelect.textHeight) 
                                -- Note this centering pattern:
                                -- Middle of the screen, minus 1/4 the font size times the character count
    -- 
    -- TITLE DECORATIONS:
    --
    local selectPositions = {-300, -268, -236, -204, -172, 172, 204, 236, 268, 300} -- Lets us loop through the square positions
    local selectColors = {'black', 'black', 'blue', 'black', 'black', 
                            'black', 'yellow', 'black', 'black', 'red'}

    for i in ipairs(selectPositions) do 
        local selectYPos = 120
        local selectXPos = midX - selectPositions[i]

        drawColor(selectColors[i])
        love.graphics.rectangle( 'fill', selectXPos, selectYPos - self.textHeight, 16, 16 )
    end

    -- SUBTITLE:
    love.graphics.setColor(0,0,0, 1)
    love.graphics.setFont(dialogueFont) -- Biggest font yet
    love.graphics.print("Level Select", midX - ((dialogueFontSize / 4) * 12), 170 - levelSelect.textHeight) 

    -- 
    -- LEVEL OPTIONS:
    -- 
    love.graphics.setLineWidth( 16 ) -- Making our lines thicc

    local startYPos = 250       -- Where the level selection options start
    local boxSize = 120         -- Indicates the height/width of the boxes
    local boxGap = 64           -- Gap in between options

    for i in ipairs(self.levelOptions[1]) do 

        if (self.selection[1] == 1 and self.selection[2] == i) then 
            drawBlue()    -- If we're on the selected level, draw a diff color!
                            -- (or do whatever, this is just to show how to detect what we've selected)
        else
            drawBlack()     -- Otherwise, draw black!
        end


        local adjustedXPos = midX - (boxSize/2);            -- Leaving it like this centers it
        adjustedXPos = adjustedXPos - (boxSize + boxGap)    -- AdjustedXPos now is at our leftmost position
        adjustedXPos = adjustedXPos + ((i - 1) * (boxSize + boxGap))    -- THE MAGIC

        local adjustedYPos = startYPos - self.textHeight                -- For Edward to mess with

        love.graphics.rectangle('line',                                 -- Outline mode
                                adjustedXPos,                           -- xPosition
                                adjustedYPos,                           -- yPosition
                                boxSize,                                -- Width
                                boxSize )                               -- Height

        love.graphics.setFont(dialogueFont) 
        love.graphics.print("Lvl", adjustedXPos + 43, adjustedYPos + 15) 
        love.graphics.setFont(headerFont) 
        love.graphics.print(self.levelOptions[1][i], adjustedXPos + 43, adjustedYPos + 35) 
    end


end