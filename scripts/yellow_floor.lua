yellow = {}

yellow.blocks = {}

function yellow:load()
    
end

function yellow:newBlock(x, y, w, h)
    width = w * 32
    height = h * 32

    xPos = (x * 32) + (width / 2)
    yPos = (y * 32) - (height / 2)

    local yellowStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    yellowStructure.body = love.physics.newBody(world.world, xPos, yPos)
    yellowStructure.body:setPosition(xPos, yPos)
    yellowStructure.shape = love.physics.newRectangleShape(width, height)
    yellowStructure.fixture = love.physics.newFixture(yellowStructure.body, yellowStructure.shape)
    yellowStructure.fixture:setFriction(1)
    yellowStructure.x = xPos
    yellowStructure.y = yPos
    yellowStructure.w = width
    yellowStructure.h = height
    yellowStructure.fixture:setUserData("yellow")

    table.insert(self.blocks, yellowStructure)
end

function yellow:draw()
    for i in ipairs(self.blocks) do
        local r = 229 / 255
        local g = 222 / 255
        local b = 83 / 255
        love.graphics.setColor(r, g, b, 1)
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end 
