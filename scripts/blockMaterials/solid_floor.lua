solid = {}

solid.blocks = {}

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

function solid:draw()
    for i in ipairs(self.blocks) do
        drawColor('solid')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end