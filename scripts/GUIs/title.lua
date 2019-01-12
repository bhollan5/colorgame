title = {}

title.selection = "start"
title.keyBuffer = true

function title:load(dt) 
    self.logo = love.graphics.newImage( 'assets/title/logo.png' ) -- Dimensions: 640x250px

end

function title:update(dt)
    -- Selecting with keyboard
    if (love.keyboard.isDown("up") or love.keyboard.isDown("down")) and title.keyBuffer then
        if title.selection == 'start' then
            title.selection = 'levels'
        else 
            title.selection = 'start'
        end
        title.keyBuffer = false
    elseif not love.keyboard.isDown("up") and not love.keyboard.isDown("down") then
        title.keyBuffer = true
    end
    if love.keyboard.isDown("return") then 
        if title.selection == 'start' then
            dialogue.insert('Hi, Edward! Nice color choice! You’re not going to be that color, though. \n\nSee that little black square there? THAT’S you.')
            gamestate = 'lvl1' 
        end
    end
end

function title:draw() 

    --
    --  LOGO: 
    --

    local midX = love.graphics.getWidth() / 2

    local logoXPos = midX - 320                     -- Adjusting logo so it will actually be centered
    love.graphics.setColor(1,1,1, 1)                -- Setting graphics color to white, so our logo doesn't have a weird overlay
    love.graphics.draw(self.logo, logoXPos, 32)


    --
    -- MENU OPTIONS: 
    --

    love.graphics.setFont(titleFont) -- This *is* the title screen, after all

    local startYPos = 350
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("Start", midX - ((titleFontSize / 4) * 5), startYPos) 
                                -- Note this centering pattern:
                                -- Middle of the screen, minus 1/4 the font size times the character count

    local levelSelectYPos = 425
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("Levels", midX - ((titleFontSize / 4) * 6), levelSelectYPos) 

    -- 
    -- OPTION SELECT INDICATOR:
    --
    local selectPositions = {-200, -168, -136, 136, 168, 200} -- Lets us loop through the square positions
    local selectColors = {'blue', 'yellow', 'red', 'red', 'yellow', 'blue'}

    for i in ipairs(selectPositions) do 
        local selectYPos = 0
        if (title.selection == 'start') then
            selectYPos = startYPos + 15
        elseif title.selection == 'levels' then 
            selectYPos = levelSelectYPos + 15
        end
        local selectXPos = midX - selectPositions[i]

        drawColor(selectColors[i])
        love.graphics.rectangle( 'fill', selectXPos, selectYPos, 16, 16 )
    end

    --
    -- CONTROL DESCRIPTIONS:
    --
    
    love.graphics.setFont(dialogueFont)

    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("(use arrow keys and enter to select)", midX - ((dialogueFontSize / 4) * 36), 500) 

end