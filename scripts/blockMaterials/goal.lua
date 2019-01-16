goal = {}

goal.blocks = {}

function goal:load()
    
end

function goal:clear()   
    goal.blocks = {}
end

function goal:newBlock(x, y)
    width = 2 * gridSize
    height = 4 * gridSize

    xPos = (x * gridSize) + (width / 2)
    yPos = (y * gridSize) + (height / 2)

    local goalStructure = {} -- defining a new structure, which we'll later be able to pass into our table
    goalStructure.body = love.physics.newBody(world.world, xPos, yPos)
    goalStructure.body:setPosition(xPos, yPos)
    goalStructure.shape = love.physics.newRectangleShape(width, height)
    goalStructure.fixture = love.physics.newFixture(goalStructure.body, goalStructure.shape)
    goalStructure.fixture:setFriction(1)
    goalStructure.x = xPos
    goalStructure.y = yPos
    goalStructure.w = width
    goalStructure.h = height
    goalStructure.fixture:setUserData("goal")

    table.insert(self.blocks, goalStructure)
end

function goal:update(dt) 

end

function goal:draw()
    for i in ipairs(self.blocks) do
        drawColor('solid')
        love.graphics.polygon("fill", self.blocks[i].body:getWorldPoints(self.blocks[i].shape:getPoints()))
        drawColor('bouncy')
        love.graphics.rectangle("fill", self.blocks[i].x - ((self.blocks[i].w / 2) - 5), 
                                        self.blocks[i].y - ((self.blocks[i].h / 2) - 5),
                                self.blocks[i].w - 10, 30)
        drawColor('sticky')
        love.graphics.rectangle("fill", self.blocks[i].x - ((self.blocks[i].w / 2) - 5), 
                                        self.blocks[i].y - ((self.blocks[i].h / 2) - 40),
                                self.blocks[i].w - 10, 20)

    end
end 
