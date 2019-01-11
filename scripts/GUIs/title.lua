title = {}

title.selection = "start"

function title:load(dt) 
    self.logo = love.graphics.newImage( 'assets/title/logo.png' ) -- Dimensions: 640x250px
end

function title:update(dt)
    love.graphics.setFont(titleFont) -- This *is* the title screen, after all
    

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

end