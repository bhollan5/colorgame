piet = {}

piet.x = 5
piet.y = 3
piet.yVel = 0
piet.xVel = 0

piet.isGrounded = true
piet.hasDouble = true
piet.upKeyBuffer = true

piet.spd = 300
piet.jumpHeight = -3000

function piet:load()
    self.body = love.physics.newBody(world.world, self.x * 32, self.y * 32, "dynamic", 0, 100)
    self.body:setLinearDamping(.5);

    self.shape = love.physics.newRectangleShape(32, 32)
    self.fixture = love.physics.newFixture(self.body, self.shape, 5)
    self.fixture:setFriction(0.75)
    self.fixture:setUserData("piet")
end

function piet:update(dt)
    self.xVel, self.yVel = self.body:getLinearVelocity()
    self.x, self.y = self.body:getPosition( )
    if love.keyboard.isDown("left") then
        self.body:setLinearVelocity(-self.spd, self.yVel)
    elseif love.keyboard.isDown("right") then
        self.body:setLinearVelocity(self.spd, self.yVel)
    else 
        self.body:setLinearVelocity(0, self.yVel)
    end

    if love.keyboard.isDown("up") and (self.isGrounded or (self.hasDouble and self.upKeyBuffer)) then 

        self.body:applyLinearImpulse(0, self.jumpHeight) -- Normal jump

        -- self.body:applyLinearImpulse(0, -200, 32, 0) -- Weird rotating jomp

        if (self.isGrounded) then
            self.isGrounded = false
            self.upKeyBuffer = false

        else
            self.hasDouble = false 
        end
    end
    if not love.keyboard.isDown("up") then
        self.upKeyBuffer = true
    end
end

function piet:draw()
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end