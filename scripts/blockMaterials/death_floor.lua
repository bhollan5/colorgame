death = {}

death.blocks = {}

function death:load()
    
end

function death:clear()
    for i in ipairs(self.blocks) do
        self.blocks[i].fixture:destroy()
    end
    self.blocks = {}
end

function death:newBlock(x, y, w, h)
    width = w * gridSize
    height = h * gridSize

    xPos = (x * gridSize) + (width / 2)
    yPos = (y * gridSize) + (height / 2)

    local deathStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    deathStructure.body = love.physics.newBody(world.world, xPos, yPos)
    deathStructure.body:setPosition(xPos, yPos)
    deathStructure.shape = love.physics.newRectangleShape(width, height)
    deathStructure.fixture = love.physics.newFixture(deathStructure.body, deathStructure.shape)
    deathStructure.fixture:setFriction(1)
    deathStructure.x = xPos
    deathStructure.y = yPos
    deathStructure.w = width
    deathStructure.h = height
    deathStructure.fixture:setUserData("death")

    table.insert(self.blocks, deathStructure)
end

function death:update(dt) 

end

function death:draw()
    for i in ipairs(self.blocks) do
        drawColor('death')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end