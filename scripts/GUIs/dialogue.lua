dialogue = {}

dialogue.showText = false
dialogue.text = {}

function dialogue:load() 

end

function dialogue:update(dt)

end

function dialogue:insert(text) 
    table.insert(dialogue.text, 1, text)
    dialogue.showText = true
    print(dialogue.text[1])
end
function dialogue:next() 
    if not (next(dialogue.text) == nil) then
        dialogue.showText = false
        local text = table.remove(dialogue.text)
        
    else
        dialogue.showText = false
        local text = table.remove(dialogue.text)
    end
end

function dialogue:draw()
    if dialogue.showText then 
        -- Drawing dialogue box
        local w = love.graphics.getWidth()
        local h = love.graphics.getHeight()
        local xPos = piet.x - 250
        local yPos = piet.y + (h / 2) - 232
        love.graphics.setLineWidth( 16 )
        drawWhite()
        love.graphics.rectangle( 'fill', xPos, yPos, 500, 200 )
        drawBlack()
        love.graphics.rectangle( 'line', xPos, yPos, 500, 200 )

        -- Writing text
        love.graphics.setFont(dialogueFont)
        love.graphics.printf( dialogue.text[1], xPos + 24, yPos + 24, 500 - 32, 'left' )

        -- Writing directions
        love.graphics.setFont(smallFont)
        love.graphics.print( '(Press space)', xPos + 370, yPos + 170)
    end
    
end