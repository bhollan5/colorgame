piet = {}

piet.x = 4
piet.y = 3
piet.yVel = 0
piet.xVel = 0

piet.isGrounded = true

piet.spd = 100

function piet:load()
    self.body = love.physics.newBody(world.world, self.x * 32, self.y * 32, "dynamic")
    self.shape = love.physics.newRectangleShape(32, 32)
    self.fixture = love.physics.newFixture(self.body, self.shape, 5)
    self.fixture:setFriction(0.75)
end

function piet:update(dt)
    self.xVel, self.yVel = self.body:getLinearVelocity()
    if love.keyboard.isDown("left") then
        self.body:setLinearVelocity(-self.spd, self.yVel)
        print("hello!")
    elseif love.keyboard.isDown("right") then
        self.body:setLinearVelocity(self.spd, self.yVel)
    end

    if love.keyboard.isDown("up") and self.isGrounded then 
        self.body:applyLinearImpulse(0, -2000)
        self.isGrounded = false
    end
end

function piet:draw()
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end