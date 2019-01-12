require "scripts/particles"

piet = {}

piet.startPos = {5, 17}
piet.deathHeight = 30 -- in 32 px units

piet.x = 5
piet.y = 17
piet.yVel = 0
piet.xVel = 0

piet.isGrounded = true
piet.hasDouble = true
piet.upKeyBuffer = true
piet.isSticky = false

piet.spd = 150
piet.jumpHeight = -500

function piet:load(args)
    particles.color = {}

    particles:load(bluePart)


    self.body = love.physics.newBody(world.world, self.x * 16, self.y * 16, "dynamic", 0, 100)
    self.body:setLinearDamping(.5);

    self.shape = love.physics.newRectangleShape(16, 16)
    self.fixture = love.physics.newFixture(self.body, self.shape, 5)
    self.fixture:setFriction(0.75)
    self.fixture:setUserData("piet")

    self.body:setFixedRotation( true )

    --self.fixture:setRestitution(0.9)
end

function piet:update(dt)
    redPart:update(dt)
    particles:update(dt)

    self.xVel, self.yVel = self.body:getLinearVelocity()
    self.x, self.y = self.body:getPosition( )

    if love.keyboard.isDown("left") then
        self.body:setLinearVelocity(-self.spd, self.yVel)
    elseif love.keyboard.isDown("right") then
        self.body:setLinearVelocity(self.spd, self.yVel)
    elseif self.isGrounded == true then 
        self.body:setLinearVelocity(self.xVel, self.yVel)
    else
        self.body:setLinearVelocity(self.xVel, self.yVel)
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
    if love.keyboard.isDown("up") and (self.isSticky) then
        self.body:setLinearVelocity(self.xVel, -self.spd)
    elseif love.keyboard.isDown("left") and (self.isSticky) then
        self.body:setLinearVelocity(-self.spd, self.yVel)
    elseif love.keyboard.isDown("right") and (self.isSticky) then
        self.body:setLinearVelocity(self.spd, self.yVel)
    end
    if not love.keyboard.isDown("up") then
        self.upKeyBuffer = true
    end

    -- Handling death
    if self.dead then
        self.body:setPosition( self.startPos[1], self.startPos[2] )
        self.body:setLinearVelocity(0, 0)
        self.dead = false
    end

    -- Fall damage
    if self.y > (self.deathHeight * 32) then
        self.dead = true
    end
end

function piet:draw()
    
    drawColor(yellow)
    love.graphics.draw(yellowPart, self.x, self.y, 0, 0.5, 0.5)
    love.graphics.setColor(0,0,0, 1)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

end

function piet:death() 
    self.dead = true
end