pause = {}

pause.unpauseBuffer = false         -- True if the player has released the pause button 

pause.selection = "start"
pause.keyBuffer = true

pause.startChange = false   -- True while the pause is rising up
pause.textHeight = 0        -- Used for easy lift transition

function pause:load(dt) 
    self.logo = love.graphics.newImage( 'assets/title/pause.png' ) -- Dimensions: 738x250px

end

function pause:update(dt)
    -- Selecting with keyboard
    if (love.keyboard.isDown("up") or love.keyboard.isDown("down") 
        or love.keyboard.isDown("w") or love.keyboard.isDown("s")) and self.keyBuffer then
        if self.selection == 'start' then
            self.selection = 'levels'
        else 
            self.selection = 'start'
        end
        self.keyBuffer = false
    elseif not love.keyboard.isDown("up") and not love.keyboard.isDown("down") 
            and not love.keyboard.isDown("w") and not love.keyboard.isDown("s") then
        self.keyBuffer = true
    end
    -- Enter:
    if love.keyboard.isDown("return") and not self.startChange then 
        if pause.selection == 'start' then
            
        elseif pause.selection == 'levels' then

        end
    end
    -- Unpausing:
    -- Pausing the game
    if (love.keyboard.isDown("p") or love.keyboard.isDown("return")) and self.unpauseBuffer then
        self.unpauseBuffer = false
        isPaused = false
    elseif not love.keyboard.isDown("p") and not love.keyboard.isDown("return") then
        self.unpauseBuffer = true
    end

    -- Moving the entire context upwards:
    if self.startChange then 
        pause.textHeight = (pause.textHeight + 1) * (1.1) -- makes a kind of quadratic curve, an ease in 
        if pause.textHeight >= 500 then 
            changeGameState('lvl1')
        end
    end
end

function pause:draw() 

    -- NOTE:
    -- All y-positions in this section are incremented by title.textHeight for the title transition.

    --
    --  LOGO: 
    --

    local midX = love.graphics.getWidth() / 2

    local logoXPos = midX - (738 / 2)               -- Adjusting logo so it will actually be centered
    love.graphics.setColor(1,1,1, 1)                -- Setting graphics color to white, so our logo doesn't have a weird overlay
    love.graphics.draw(self.logo, logoXPos, 32 - self.textHeight)


    --
    -- MENU OPTIONS: 
    --

    love.graphics.setFont(titleFont) -- This *is* the title screen, after all

    local startYPos = 350
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("Options", midX - ((titleFontSize / 4) * 6.5), startYPos - self.textHeight) 
                                -- Note this centering pattern:
                                -- Middle of the screen, minus 1/4 the font size times the character count
                                -- This one uses 6.5 instead of 7 because the "i" is skinny

    local levelSelectYPos = 425
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("Levels", midX - ((titleFontSize / 4) * 6), levelSelectYPos - self.textHeight) 

    -- 
    -- OPTION SELECT INDICATOR:
    --
    local selectPositions = {-200, -168, -136, 136, 168, 200} -- Lets us loop through the square positions
    local selectColors = {'blue', 'yellow', 'red', 'red', 'yellow', 'blue'}

    for i in ipairs(selectPositions) do 
        local selectYPos = 0
        if (self.selection == 'start') then
            selectYPos = startYPos + 15
        elseif self.selection == 'levels' then 
            selectYPos = levelSelectYPos + 15
        end
        local selectXPos = midX - selectPositions[i]

        drawColor(selectColors[i])
        love.graphics.rectangle( 'fill', selectXPos, selectYPos - self.textHeight, 16, 16 )
    end

    --
    -- CONTROL DESCRIPTIONS:
    --
    
    love.graphics.setFont(dialogueFont)

    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("(use arrow keys and enter to select)", midX - ((dialogueFontSize / 4) * 36), 500 - self.textHeight) 
end