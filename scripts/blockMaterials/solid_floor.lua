solid = {}

solid.blocks = {}
solid.movingBlocks = {}

function solid:load()
    
end

function solid:newBlock(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) + (height / 2)

    local solidStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    solidStructure.body = love.physics.newBody(world.world, xPos, yPos)
    solidStructure.body:setPosition(xPos, yPos)
    solidStructure.shape = love.physics.newRectangleShape(width, height)
    solidStructure.fixture = love.physics.newFixture(solidStructure.body, solidStructure.shape)
    solidStructure.fixture:setFriction(1)
    solidStructure.x = xPos
    solidStructure.y = yPos
    solidStructure.w = width
    solidStructure.h = height
    solidStructure.fixture:setUserData("solid")

    table.insert(self.blocks, solidStructure)
end

function solid:newMovingBlock(xStart, yStart, w, h, xEnd, yEnd, oneWayTripTime)
    -- NOTE: oneWayTripTime is just how many seconds it will take to move the distance once!
    width = w * 16
    height = h * 16

    xPos = (xStart * 16) + (width / 2)
    yPos = (yStart * 16) + (height / 2)
    xEndPos = (xEnd * 16) + (width / 2)
    yEndPos = (yEnd * 16) + (height / 2)

    local solidStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    
    -- https://love2d.org/wiki/BodyType
    solidStructure.body = love.physics.newBody(world.world, xPos, yPos, "kinematic") 
    solidStructure.body:setPosition(xPos, yPos)
    solidStructure.shape = love.physics.newRectangleShape(width, height)
    solidStructure.fixture = love.physics.newFixture(solidStructure.body, solidStructure.shape)
    solidStructure.fixture:setFriction(1)

    solidStructure.xStart = xPos
    solidStructure.yStart = yPos
    solidStructure.xEnd = xEndPos
    solidStructure.yEnd = yEndPos
    solidStructure.w = width
    solidStructure.h = height
    solidStructure.oneWayTripTime = oneWayTripTime
    solidStructure.placeTracker = 0 -- This will keep track of how far we are on our trip

    solidStructure.fixture:setUserData("solid")

    table.insert(self.movingBlocks, solidStructure)
end

function solid:update(dt) 
    
    -- Iterating through our moving blocks, to move each one: 
    for i in ipairs(solid.movingBlocks) do

        -- Getting current position:
        local x, y = solid.movingBlocks[i].body:getPosition( )

        -- Setting some variables to shorter, more managable names:
        local oneWayTripTime = solid.movingBlocks[i].oneWayTripTime
        local placeTracker = solid.movingBlocks[i].placeTracker

        -- Getting the TOTAL distance needed to travel 
        local xDistance = solid.movingBlocks[i].xEnd - solid.movingBlocks[i].xStart 
        local yDistance = solid.movingBlocks[i].yEnd - solid.movingBlocks[i].yStart


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
            solid.movingBlocks[i].body:setLinearVelocity( xVel, yVel ) 
        else
            -- If we're coming back..... come back!
            solid.movingBlocks[i].body:setLinearVelocity( -xVel, -yVel ) 
        end

        -- Moving the place forward, for next time.
        -- Note that we add 'dt' to account for different speeds on different computers!
        -- https://love2d.org/wiki/dt
        solid.movingBlocks[i].placeTracker = solid.movingBlocks[i].placeTracker + dt
    end
end

function solid:draw()
    for i in ipairs(self.blocks) do
        drawColor('solid')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))
    end
    for i in ipairs(self.movingBlocks) do
        drawColor('solid')
        love.graphics.polygon("fill", self.movingBlocks[i].body:getWorldPoints(self.movingBlocks[i].shape:getPoints()))
    end
end