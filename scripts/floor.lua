floor = {}

function floor:load()
    floor.body = love.physics.newBody("world", xPos, yPos)
    floor.body:setPosition(xPos, yPos)
    floor.shape = love.physics.newRectangleShape(width, height)
    floor.fixture = love.physics.newFixture(floor.body, floor.shape)
    floor.fixture:setFriction(1)
    floor.x = xPos
    floor.y = yPos
    floor.w = width
    floor.h = height
    floor.fixture:setUserData("solid")
end

function floor:update()
    self.floor:update()
end

