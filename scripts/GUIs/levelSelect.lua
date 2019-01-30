levelSelect = {}

levelSelect.selection = "Level1"
levelSelect.keyBuffer = true

levelSelect.startChange = false
levelSelect.textHeight = 0

function levelSelect:load()
    self.logo = love.graphics.newImage("assets/title/logo.png")
    self.uncompleted = love.graphics.newImage("assets/levelSelect/uncompletedLevel.png")
    self.completed = love.graphics.newImage("assets/levelSelect/completedLevel.png")
    self.menu = love.graphics.newImage("assets/levelSelect/menuButton.png")
    self.cursor = love.graphics.newImage("assets/levelSelect/cursor.png")
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


    -- logo
    local midX = love.graphics.getWidth() / 2

    local logoXPos = midX - 320
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.logo, logoXPos, 32 - levelSelect.textHeight)

    --
    love.graphics.setFont(titleFont) -- This *is* the levelSelect screen, after all

    local startYPos = 350
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("Start", midX - ((titleFontSize / 4) * 5), startYPos - levelSelect.textHeight) 
                                -- Note this centering pattern:
                                -- Middle of the screen, minus 1/4 the font size times the character count

    local levelSelectYPos = 425
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("Levels", midX - ((titleFontSize / 4) * 6), levelSelectYPos - levelSelect.textHeight) 

    -- 
    -- OPTION SELECT INDICATOR:
    --
    local selectPositions = {-200, -168, -136, 136, 168, 200} -- Lets us loop through the square positions
    local selectColors = {'blue', 'yellow', 'red', 'red', 'yellow', 'blue'}

    for i in ipairs(selectPositions) do 
        local selectYPos = 0
        if (levelSelect.selection == 'start') then
            selectYPos = startYPos + 15
        elseif levelSelect.selection == 'levels' then 
            selectYPos = levelSelectYPos + 15
        end
        local selectXPos = midX - selectPositions[i]

        drawColor(selectColors[i])
        love.graphics.rectangle( 'fill', selectXPos, selectYPos - levelSelect.textHeight, 16, 16 )
    end

    --
    -- CONTROL DESCRIPTIONS:
    --
    
    love.graphics.setFont(dialogueFont)

    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("(use arrow keys and enter to select)", midX - ((dialogueFontSize / 4) * 36), 500 - levelSelect.textHeight)


end