dialogue = {}

dialogue.showText = false
dialogue.text = {}

dialogue.skipBuffer = true

function dialogue:load() 

end

function dialogue:update(dt)

end

function dialogue:insert(text) 
    if not debug then
        table.insert(dialogue.text, text)
        dialogue.showText = true
    end
end
function dialogue:next() 
    if not (dialogue.text[2] == nil) then
        table.remove(dialogue.text, 1)
        
    else
        table.remove(dialogue.text, 1)
        dialogue.showText = false
    end
end

function dialogue:draw()
    if dialogue.showText and not world.isTransitioningDown then 
        -- Drawing dialogue box
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()
        local xPos = piet.x - 250
        local yPos = piet.y + (h / 2) - 232
        love.graphics.setLineWidth( 16 )
        drawColor('background')
        love.graphics.rectangle( 'fill', xPos, yPos, 500, 200 )
        drawColor('solid')
        love.graphics.rectangle( 'line', xPos, yPos, 500, 200 )

        -- Writing text
        love.graphics.setFont(dialogueFont)
        if (dialogue.text[1] == nil) == false then 
            love.graphics.printf( dialogue.text[1], xPos + 24, yPos + 24, 500 - 32, 'left' )
        end

        -- Writing directions
        love.graphics.setFont(smallFont)
        love.graphics.print( '(Press space)', xPos + 370, yPos + 170)
    end
    
end