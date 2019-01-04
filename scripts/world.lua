world = {}

-- table for love.physics objects
world.arena = {}

world.gravity = {
    x = 0,
    y = 1000
}

function world:load()
    self.world = love.physics.newWorld(self.gravity.x, self.gravity.y)

    -- platform
    world:newArenaStructure(1, 2, 1, 1)
    world:newArenaStructure(2, 3, 2, 1)
    world:newArenaStructure(4, 15, 1, 1)
    world:newArenaStructure(4, 16, 10, 1)
end

function world:newArenaStructure(x, y, w, h)
    width = w * 32
    height = h * 32

    xPos = (x * 32) + (width / 2)
    yPos = (y * 32) - (height / 2)

    local structure = {} -- defining a new structure, which we'll later be able to pass into our table
    structure.body = love.physics.newBody(self.world, xPos, yPos)
    structure.shape = love.physics.newRectangleShape(width, height)
    structure.fixture = love.physics.newFixture(structure.body, structure.shape)

    table.insert(self.arena, structure)
end

function world:update(dt)
    self.world:update(dt)
end

-- function world:draw()
--     for i in ipairs(self.arena) do
--         love.graphics.polygon("fill", self.arena[i].body:getWorldPoints(self.arena[i].shape:getPoints()))
--         local xStart = self.blocks[i].x - (self.blocks[i].w / 2)
--         local yStart = self.blocks[i].y - (self.blocks[i].h / 2)
--         love.graphics.draw(self.spr, xStart, yStart, 0, 1, 1)
--     end
-- end

function world:draw()
    for _, body in pairs(self.world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
            love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
        end
    end
end