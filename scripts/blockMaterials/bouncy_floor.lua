bouncy = {}

bouncy.blocks = {}
bouncy.movingBlocks = {}

function bouncy:load()

end

function bouncy:newBlock(x, y, w, h)
    width = w * gridSize
    height = h * gridSize

    xPos = (x * gridSize) + (width / 2)
    yPos = (y * gridSize) + (height / 2)

    local bouncyStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    bouncyStructure.body = love.physics.newBody(world.world, xPos, yPos)
    bouncyStructure.body:setPosition(xPos, yPos)
    bouncyStructure.shape = love.physics.newRectangleShape(width, height)
    bouncyStructure.fixture = love.physics.newFixture(bouncyStructure.body, bouncyStructure.shape)
    bouncyStructure.fixture:setFriction(1)
    bouncyStructure.x = xPos
    bouncyStructure.y = yPos
    bouncyStructure.w = width
    bouncyStructure.h = height
    bouncyStructure.fixture:setUserData("bouncy")
    bouncyStructure.fixture:setRestitution(0.6)

    table.insert(self.blocks, bouncyStructure)
end

function bouncy:newMovingBlock(xStart, yStart, w, h, xEnd, yEnd, oneWayTripTime)
    -- NOTE: oneWayTripTime is just how many seconds it will take to move the distance once!
    width = w * gridSize
    height = h * gridSize

    xPos = (xStart * gridSize) + (width / 2)
    yPos = (yStart * gridSize) + (height / 2)
    xEndPos = (xEnd * gridSize) + (width / 2)
    yEndPos = (yEnd * gridSize) + (height / 2)

    local bouncyStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    
    -- https://love2d.org/wiki/BodyType
    bouncyStructure.body = love.physics.newBody(world.world, xPos, yPos, "kinematic") 
    bouncyStructure.body:setPosition(xPos, yPos)
    bouncyStructure.shape = love.physics.newRectangleShape(width, height)
    bouncyStructure.fixture = love.physics.newFixture(bouncyStructure.body, bouncyStructure.shape)
    bouncyStructure.fixture:setFriction(1)

    bouncyStructure.xStart = xPos
    bouncyStructure.yStart = yPos
    bouncyStructure.xEnd = xEndPos
    bouncyStructure.yEnd = yEndPos
    bouncyStructure.w = width
    bouncyStructure.h = height
    bouncyStructure.oneWayTripTime = oneWayTripTime
    bouncyStructure.placeTracker = 0 -- This will keep track of how far we are on our trip

    bouncyStructure.fixture:setUserData("bouncy")

    table.insert(self.movingBlocks, bouncyStructure)
end

function bouncy:update(dt) 
    
    -- Iterating through our moving blocks, to move each one: 
    for i in ipairs(bouncy.movingBlocks) do

        -- Getting current position:
        local x, y = bouncy.movingBlocks[i].body:getPosition( )

        -- Setting some variables to shorter, more managable names:
        local oneWayTripTime = bouncy.movingBlocks[i].oneWayTripTime
        local placeTracker = bouncy.movingBlocks[i].placeTracker

        -- Getting the TOTAL distance needed to travel 
        local xDistance = bouncy.movingBlocks[i].xEnd - bouncy.movingBlocks[i].xStart 
        local yDistance = bouncy.movingBlocks[i].yEnd - bouncy.movingBlocks[i].yStart


        -- Now we need our speed - the distance divided by the time
        local xVel = xDistance / oneWayTripTime 
        local yVel = yDistance / oneWayTripTime

        -- Place tracker keeps track of how many clicks we've moved.
        -- Let's use the modulo operator to see where we are in our trip.
        --
        -- This will give us a number between 0 and the time for a TWO way trip:
        local place = placeTracker % (oneWayTripTime * 2)

        -- Checking if we've made the first trip yet:
        if (place < oneWayTripTime) then
            -- If we're on the first part of the trip, go forward:
            bouncy.movingBlocks[i].body:setLinearVelocity( xVel, yVel ) 
        else
            -- If we're coming back..... come back!
            bouncy.movingBlocks[i].body:setLinearVelocity( -xVel, -yVel ) 
        end

        -- Moving the place forward, for next time.
        -- Note that we add 'dt' to account for different speeds on different computers!
        -- https://love2d.org/wiki/dt
        bouncy.movingBlocks[i].placeTracker = bouncy.movingBlocks[i].placeTracker + dt
    end
end

function bouncy:draw()
    for i in ipairs(self.blocks) do
        drawColor('bouncy')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
    for i in ipairs(self.movingBlocks) do
        drawColor('bouncy')
        love.graphics.polygon("fill", self.movingBlocks[i].body:getWorldPoints(self.movingBlocks[i].shape:getPoints()))

    end
end