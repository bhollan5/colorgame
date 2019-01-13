require "scripts/piet"
require "scripts/yellow_floor"
require "scripts/blue_floor"
require "scripts/red_floor"
require "scripts/black_floor"

require "scripts/levels/level1"

world = {}

-- table for love.physics objects
world.arena = {}

world.gravity = {
    x = 0,
    y = 1000
}

function world:load()
    
    self.world = love.physics.newWorld(self.gravity.x, self.gravity.y)
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    text = ""
    persisting = 0
    
end

function world:newArenaStructure(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) - (height / 2)

end

function world:update(dt)

    self.world:update(dt);
    particles:update(dt)
    
end

function world:draw()

    black:draw()
    red:draw()
    blue:draw()
    yellow:draw()

    if (debug) then
        drawDebug()
    end

end

-- contact behavior
function beginContact(a, b, coll)

    -- X and Y give a UNIT VECTOR from the first shape to the second
    -- So if a is piet and b is a block below him at normal orientation,
    -- X and Y will be (0, -1)
    local x, y = coll:getNormal() 
    local aType = a:getUserData()
    local bType = b:getUserData()
    --text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y    
    if ((aType == "black" or aType == "blue" or aType == "yellow") and bType == "piet") then
        if (x == 0 and y == -1) then
            piet.isGrounded = true
            piet.hasDouble = true
        end
    end
    if ((bType == "black" or bType == "blue" or bType == "yellow") and aType == "piet") then
        if (x == 0 and y == 1) then
            piet.isGrounded = true
            piet.hasDouble = true
        end
    end
    
    
end

function endContact(a, b, coll)
    persisting = 0
    piet.isNormal = false
    piet.isBouncy = false
    piet.isSticky = false
end
 
function preSolve(a, b, coll)
    local x, y = coll:getNormal() 
    local aType = a:getUserData()
    local bType = b:getUserData()
    if persisting == 0 then
        piet.isNormal = false
        piet.isBouncy = false
        piet.isSticky = false
    elseif persisting < 1 then
        preSolveCollisionChecks(aType, bType, x, y)
        preSolveCollisionChecks(bType, aType, x, y)
    end
    persisting = persisting + 0.1
end

function preSolveCollisionChecks(aType, bType, x, y) 
    if (aType == "yellow" and bType == "piet") then
        if ((x == -1 and y == 0) or (x == 1 and y == 0) or (x == 0 and y == 1)) then
            piet.isGrounded = false
            piet.isSticky = true
        elseif not ((x == -1 and y == 0) or (x == 1 and y == 0) or (x == 0 and y == 1)) then
            if (x == 0 and y == -1) then
                piet.isGrounded = true
                piet.isSticky = true
            end
        end
    elseif not (aType == "yellow" and bType == "piet") then
        if (aType == "black" and bType == "piet") then
            if (x == 0 and y == -1) then
                piet.isGrounded = true
                piet.isNormal = true
            end
        end
    
    end
    if (aType == "red" and bType == "piet") then
            piet:death()
    end
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 
end

function drawDebug() -- Used to output some debug values on screen
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.graphics.setFont(smallFont) 
    love.graphics.setColor(0,0,0, 1)

    local isGroundedString = 'false'
    if piet.isGrounded then
        isGroundedString = 'true'
    end
    local hasDoubleString = 'false'
    if piet.hasDouble then
        hasDoubleString = 'true'
    end


    local debugPrintouts = { -- This should hold a series of strings, to be printed out
        "piet.isGrounded:  " .. isGroundedString,
        "piet.hasDouble:  " .. hasDoubleString,
    }
    for i in ipairs(debugPrintouts) do
        love.graphics.print(debugPrintouts[i], piet.x - (w / 2) + 10, piet.y - (h / 2) + (i * 20))
    end
end