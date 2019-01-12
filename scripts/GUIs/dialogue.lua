dialogue = {}

dialogue.showText = false
dialogue.text = {}

function dialogue:load() 

end

function dialogue:update(dt)

end

function dialogue:insert(text) 
    table.insert(dialogue.text, text)
    dialogue.showText = true
end
function dialogue:next() 
    if (next(dialogue.text) == nil) then

        dialogue.showText = false
    else
        print("I guess not!")
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
        love.graphics.printf( 'Hi, Edward! Nice color choice! You’re not going to be that color, though. \n\nSee that little black square there? THAT’S you. ', xPos + 24, yPos + 24, 500 - 32, 'left' )

        -- Writing directions
        love.graphics.setFont(smallFont)
        love.graphics.print( '(Press space)', xPos + 370, yPos + 170)
    end
    
end