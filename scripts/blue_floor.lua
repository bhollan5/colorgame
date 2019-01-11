blue = {}

blue.blocks = {}

function blue:load()

end

function blue:newBlock(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) - (height / 2)

    local blueStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    blueStructure.body = love.physics.newBody(world.world, xPos, yPos)
    blueStructure.body:setPosition(xPos, yPos)
    blueStructure.shape = love.physics.newRectangleShape(width, height)
    blueStructure.fixture = love.physics.newFixture(blueStructure.body, blueStructure.shape)
    blueStructure.fixture:setFriction(1)
    blueStructure.x = xPos
    blueStructure.y = yPos
    blueStructure.w = width
    blueStructure.h = height
    blueStructure.fixture:setUserData("blue")
    blueStructure.fixture:setRestitution(0.9)

    table.insert(self.blocks, blueStructure)
end

function blue:draw()
    for i in ipairs(self.blocks) do
        local r = 83 / 255
        local g = 100 / 255
        local b = 229 / 255
        love.graphics.setColor(r, g, b, 1)
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end