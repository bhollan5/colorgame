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

    --the platforms below are ordered as follows: left to right, top to bottom
    black:newBlock(0, 18, 8, 1)
    
    blue:newBlock(10, 30, 8, 3)
    yellow:newBlock(10, 33, 8, 2)
    red:newBlock(10, 35, 8, 1)

    black:newBlock(21, 28, 7, 1)

    --red square with black square inside
    red:newBlock(34, 16, 8, 2)
    red:newBlock(42, 22, 2, 8)
    red:newBlock(36, 24, 8, 2)
    red:newBlock(34, 24, 2, 8)
    black:newBlock(38, 20, 2, 2)

    --yellow angle platform
    yellow:newBlock(31, 30, 19, 3)
    yellow:newBlock(47, 27, 3, 16)

    red:newBlock(31, 33, 8, 2)
    blue:newBlock(31, 35, 8, 1)

    blue:newBlock(51, 33, 2, 2)
    blue:newBlock(55, 33, 2, 2)
    red:newBlock(58, 18, 18, 1)
    yellow:newBlock(58, 22, 18, 3)
    blue:newBlock(59, 33, 2, 2)
    
end

function world:newArenaStructure(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) - (height / 2)

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
    local x, y = coll:getNormal() 
    local aType = a:getUserData()
    local bType = b:getUserData()
    -- text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..    
    if ((aType == "black" or aType == "blue" or aType == "yellow") and bType == "piet") then
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
