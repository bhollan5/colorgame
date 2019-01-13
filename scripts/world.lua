require "scripts/piet"
require "scripts/yellow_floor"
require "scripts/blue_floor"
require "scripts/red_floor"
require "scripts/black_floor"
require "scripts/particles"

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
    --yellow:newBlock(0, 14, 8, 1)
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

end

-- contact behavior
function beginContact(a, b, coll)

    -- X and Y give a UNIT VECTOR from the first shape to the second
    -- So if a is piet and b is a block below him at normal orientation,
    -- X and Y will be (0, -1)
    x, y = coll:getNormal() 
    aType = a:getUserData()
    bType = b:getUserData()
    --text = text.."\n"..a:getUserData().." colliding with "..b:getUserData().." with a vector normal of: "..x..", "..y    
    if ((aType == "black" or aType == "blue" or aType == "yellow") and bType == "piet") then
        if (x == 0 and y == -1) then
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
    --piet.fixture:setRestitution(0)

end
 
function preSolve(a, b, coll)
    if persisting == 0 then
        piet.isNormal = false
        piet.isBouncy = false
        piet.isSticky = false

    elseif persisting < 1 then
        if (aType == "yellow" and bType == "piet") then
            if ((x == -1 and y == 0) or (x == 1 and y == 0) or (x == 0 and y == 1)) then
                --world.world:setGravity(0, -1000)
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
            elseif not (aType == "black" and bType == "piet") then
                
            end
        
        
        end
        if (aType == "red" and bType == "piet") then
            piet.dead = true
        end
        
    end
    persisting = persisting + 0.1
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
    
end