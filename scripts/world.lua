require "scripts/piet"

world = {}

-- table for love.physics objects
world.arena = {}

world.gravity = {
    x = 0,
    y = 1000
}

function world:load()
    yellowTile = love.graphics.newImage("/assets/yellow.png")
    blueTile = love.graphics.newImage("/assets/blue.png")

    psystem2 = love.graphics.newParticleSystem(yellowTile, 10)
    psystem2:setParticleLifetime(2, 5)
    psystem2:setEmissionRate(5)
    psystem2:setSizeVariation(1)
    psystem2:setLinearAcceleration(-20, -20, -20, 0)
    psystem2:setSpeed(5, 10)
    psystem2:setColors(255, 255, 255, 255, 255, 255, 255, 0)

    self.world = love.physics.newWorld(self.gravity.x, self.gravity.y)
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    


    -- platform
    blueFloor = world:newArenaStructure(1, 2, 1, 1)
    world:newArenaStructure(2, 3, 2, 1)
    world:newArenaStructure(4, 15, 1, 1)
    world:newArenaStructure(0, 16, 32, 1)
end

function world:newArenaStructure(x, y, w, h)
    width = w * 32
    height = h * 32

    xPos = (x * 32) + (width / 2)
    yPos = (y * 32) - (height / 2)

    local blueFloor = {} -- defining a new structure, which we'll later be able to pass into our table
    blueFloor.body = love.physics.newBody(self.world, xPos, yPos)
    blueFloor.body:setPosition(xPos, yPos)
    blueFloor.shape = love.physics.newRectangleShape(width, height)
    blueFloor.fixture = love.physics.newFixture(blueFloor.body, blueFloor.shape)
    blueFloor.fixture:setFriction(1)
    blueFloor.x = xPos
    blueFloor.y = yPos
    blueFloor.w = width
    blueFloor.h = height
    blueFloor.fixture:setUserData("solid")

    local yellowFloor = {}
    yellowFloor.body = love.physics.newBody(self.world, xPos, yPos)
    yellowFloor.body:setPosition(xPos, yPos)
    yellowFloor.shape = love.physics.newRectangleShape(width, height)
    yellowFloor.fixture = love.physics.newFixture(yellowFloor.body, yellowFloor.shape)
    yellowFloor.fixture:setFriction(1)
    yellowFloor.x = xPos
    yellowFloor.y = yPos
    yellowFloor.w = width
    yellowFloor.h = height
    yellowFloor.fixture:setUserData("solid")

    table.insert(self.arena, blueFloor)
    table.insert(self.arena, yellowFloor)
    table.sort(self.arena, yellowFloor, blueFloor)
end

function world:update(dt)
    self.world:update(dt);
    psystem2:update(dt)
    
end

function world:draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    --love.graphics.translate(-piet.x + w / 2, -piet.y + h / 2)

    -- Tiling solid blocks: 
    for i in ipairs(self.arena) do
        -- *Start calculates the top right corner of the box
        local xStart = self.arena[i].x - (self.arena[i].w / 2)
        local yStart = self.arena[i].y - (self.arena[i].h / 2)

        -- These will be used to iterate through the width and height in increments of 32
        local widthRemaining = self.arena[i].w

        -- We'll subtract 32 from widthRemaining until it's 0
        while widthRemaining > 0 do
            local xVal = xStart + self.arena[i].w - widthRemaining
            local heightRemaining = self.arena[i].h

            while heightRemaining > 0 do
                local yVal = yStart + self.arena[i].h - heightRemaining
                love.graphics.draw(yellowTile, xVal, yVal, 0, 1, 1)
                love.graphics.draw(blueTile, xVal, yVal, 0, 1, 1)
                heightRemaining = heightRemaining - 32
            end

            widthRemaining = widthRemaining - 32
        end

        love.graphics.draw(yellowTile, xStart, yStart, 0, 1, 1)
        love.graphics.draw(blueTile, xStart, yStart, 0, 1, 1)
        
    end
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
    if (aType == "solid" and bType == "piet") then
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
