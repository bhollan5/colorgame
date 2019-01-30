levelSelect = {}

levelSelect.selection = "Level1"
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


    -- logo
    local midX = love.graphics.getWidth() / 2

    local logoXPos = midX - 320
    love.graphics.setColor(1, 1, 1, 1)

    --
    love.graphics.setFont(titleFont) -- This *is* the levelSelect screen, after all

    local startYPos = 350
    love.graphics.setColor(0,0,0, 1)
    love.graphics.print("game level thing", midX - ((titleFontSize / 4) * 5), startYPos - levelSelect.textHeight) 
                                -- Note this centering pattern:
                                -- Middle of the screen, minus 1/4 the font size times the character count
end