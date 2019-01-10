require "scripts/piet"
require "scripts/yellow_floor"
require "scripts/blue_floor"
require "scripts/red_floor"
require "scripts/black_floor"

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

    blue:newBlock(2, 3, 2, 1)
    black:newBlock(0, 16, 32, 1)
    red:newBlock(10, 6, 4, 1)
    yellow:newBlock(6, 8, 8, 1)
    
end

function world:newArenaStructure(x, y, w, h)
    width = w * 32
    height = h * 32

    xPos = (x * 32) + (width / 2)
    yPos = (y * 32) - (height / 2)

end

function world:update(dt)

    self.world:update(dt);
    
end

function world:draw()

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    love.graphics.translate(-piet.x + w / 2, -piet.y + h / 2)

    black:draw()
    red:draw()
    blue:draw()
    yellow:draw()

end

-- contact behavior
function beginContact(a, b, coll)

    -- X and Y give a UNIT VECTOR from the first shape to the second
    -- So if a is piet and b is a block below him at normal orientation,
    -- X and Y will be (0, -1)
    x, y = coll:getNormal() 
    local aType = a:getUserData()
    local bType = b:getUserData()
    -- text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..    
    if (aType == "black" and bType == "piet") then
        if (x == 0 and y == -1) then
            piet.isGrounded = true
            piet.hasDouble = true
        end
    end
    
end

function endContact(a, b, coll)

 
end
 
function preSolve(a, b, coll)
 
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 
end
