red = {}

red.blocks = {}

function red:load()
    
end

function red:newBlock(x, y, w, h)
    width = w * 32
    height = h * 32

    xPos = (x * 32) + (width / 2)
    yPos = (y * 32) - (height / 2)

    local redStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    redStructure.body = love.physics.newBody(world.world, xPos, yPos)
    redStructure.body:setPosition(xPos, yPos)
    redStructure.shape = love.physics.newRectangleShape(width, height)
    redStructure.fixture = love.physics.newFixture(redStructure.body, redStructure.shape)
    redStructure.fixture:setFriction(1)
    redStructure.x = xPos
    redStructure.y = yPos
    redStructure.w = width
    redStructure.h = height
    redStructure.fixture:setUserData("red")

    table.insert(self.blocks, redStructure)
end

function red:draw()
    for i in ipairs(self.blocks) do
        local r = 203 / 255
        local g = 52 / 255
        local b = 52 / 255
        love.graphics.setColor(r, g, b, 1)
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end