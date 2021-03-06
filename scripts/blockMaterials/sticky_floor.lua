sticky = {}

sticky.blocks = {}

function sticky:load()
    
end

function sticky:clear() 
    for i in ipairs(self.blocks) do
        self.blocks[i].fixture:destroy()
    end
    self.blocks = {}
end

function sticky:newBlock(x, y, w, h)
    width = w * gridSize
    height = h * gridSize

    xPos = (x * gridSize) + (width / 2)
    yPos = (y * gridSize) + (height / 2)

    local stickyStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    stickyStructure.body = love.physics.newBody(world.world, xPos, yPos)
    stickyStructure.body:setPosition(xPos, yPos)
    stickyStructure.shape = love.physics.newRectangleShape(width, height)
    stickyStructure.fixture = love.physics.newFixture(stickyStructure.body, stickyStructure.shape)
    stickyStructure.fixture:setFriction(1)
    stickyStructure.x = xPos
    stickyStructure.y = yPos
    stickyStructure.w = width
    stickyStructure.h = height
    stickyStructure.fixture:setUserData("sticky")

    table.insert(self.blocks, stickyStructure)
end

function sticky:update(dt) 

end

function sticky:draw()
    for i in ipairs(self.blocks) do
        drawColor('sticky')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))

    end
end 
