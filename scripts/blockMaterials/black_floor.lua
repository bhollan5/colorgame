black = {}

black.blocks = {}

function black:load()
    
end

function black:newBlock(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) + (height / 2)

    local blackStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    blackStructure.body = love.physics.newBody(world.world, xPos, yPos)
    blackStructure.body:setPosition(xPos, yPos)
    blackStructure.shape = love.physics.newRectangleShape(width, height)
    blackStructure.fixture = love.physics.newFixture(blackStructure.body, blackStructure.shape)
    blackStructure.fixture:setFriction(1)
    blackStructure.x = xPos
    blackStructure.y = yPos
    blackStructure.w = width
    blackStructure.h = height
    blackStructure.fixture:setUserData("black")

    table.insert(self.blocks, blackStructure)
end

function black:draw()
    for i in ipairs(self.blocks) do
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end