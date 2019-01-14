bouncy = {}

bouncy.blocks = {}

function bouncy:load()

end

function bouncy:newBlock(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) + (height / 2)

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
    bouncyStructure.fixture:setRestitution(0.9)

    table.insert(self.blocks, bouncyStructure)
end

function bouncy:draw()
    for i in ipairs(self.blocks) do
        drawColor('bouncy')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end