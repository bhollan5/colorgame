require "scripts/particles"

piet = {}

piet.startPos = {0 * 16, 8 * 16 }
piet.deathHeight = 60 -- in 16 px units
piet.deathHeight = piet.deathHeight * 16

piet.x = piet.startPos[1]
piet.y = piet.startPos[2]
piet.yVel = 0
piet.xVel = 0

piet.isGrounded = true
piet.hasDouble = true
piet.upKeyBuffer = true
piet.isSticky = false
piet.isBouncy = false
piet.isNormal = false
piet.dead =  false
piet.hasDied = false

piet.spd = 200
piet.jumpHeight = -500


function piet:load()
    particles.color = {}

    particles:load()

    piet.isFresh = true


    self.body = love.physics.newBody(world.world, self.startPos[1], self.startPos[2], "dynamic", 0, 100)
    self.body:setLinearDamping(.5);
    

    self.shape = love.physics.newRectangleShape(16, 16)
    self.fixture = love.physics.newFixture(self.body, self.shape, 5)
    self.fixture:setFriction(0.75)
    self.fixture:setUserData("piet")

    -- self.body:setFixedRotation( true )

    --self.fixture:setRestitution(0.9)
end

function piet:update(dt)
    particles:update(dt)
    local halfJump = (self.jumpHeight / 2)

    self.xVel, self.yVel = self.body:getLinearVelocity()
    self.x, self.y = self.body:getPosition()

    -- Handling death
    if (self.dead) then
        self.body:setPosition(self.startPos[1] * 16, self.startPos[2] * 16)
        print(self.startPos[1])
        print(self.startPos[2])
        self.body:setLinearVelocity(0, 0)
        piet:draw()
        self.dead = false
        
        -- dialogue:
        if (not self.hasDied) then 
            self.hasDied = true
            dialogue:insert('Don’t worry about dying - you’re a sturdy square, and you’ll recover quickly.\n\n Just see how far you can get!')
        end
    end

    -- Fall damage
    if self.y > (self.deathHeight) then
        self.dead = true
    end

    -- Pausing controls for dialogue
    if love.keyboard.isDown("space") and dialogue.skipBuffer then
        dialogue:next()
        dialogue.skipBuffer = false
    elseif not love.keyboard.isDown("space") then
        dialogue.skipBuffer = true
    end
    if dialogue.showText then
        return
    end

    if love.keyboard.isDown("left") then
        self.body:setLinearVelocity(-self.spd, self.yVel)
    elseif love.keyboard.isDown("right") then
        self.body:setLinearVelocity(self.spd, self.yVel)
    elseif self.isGrounded == false then 
        self.body:setLinearVelocity(0, self.yVel)
    else
        self.body:setLinearVelocity(self.xVel, self.yVel)
    end

    if love.keyboard.isDown("up") and (self.isGrounded or (self.hasDouble and self.upKeyBuffer)) then 

        if (self.isGrounded) then
            self.body:applyLinearImpulse(0, self.jumpHeight)

            self.isGrounded = false
            self.upKeyBuffer = false
        else
            self.body:setLinearVelocity(self.xVel, self.jumpHeight)
            self.hasDouble = false 
        end
    end

    -- Handling sticky contact physics
    if love.keyboard.isDown("up") and ((self.isSticky) and (self.isGrounded)) then
        self.body:applyLinearImpulse(0, halfJump)
    elseif not (love.keyboard.isDown("up") and ((self.isSticky) and (self.isGrounded))) then
        if love.keyboard.isDown("up") and (self.isSticky) then
            self.body:setLinearVelocity(self.xVel, -self.spd)
        elseif not (love.keyboard.isDown("up") and (self.isSticky)) then
            if love.keyboard.isDown("left") and (self.isSticky) then
                self.body:setLinearVelocity(-self.spd, self.yVel)
            elseif not (love.keyboard.isDown("left") and (self.isSticky)) then
                if love.keyboard.isDown("right") and (self.isSticky) then
                    self.body:setLinearVelocity(self.spd, self.yVel)
                end
            end
        end
    end
    if not love.keyboard.isDown("up") then
        self.upKeyBuffer = true
    end
end

function piet:draw()

    
    
    if (self.isSticky) then
        redPart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        redPart:setEmissionRate(0)
        bluePart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        bluePart:setEmissionRate(0)
        yellowPart:setParticleLifetime(2, 5) --used to denote time on screen from minimum time alive to maximum
        yellowPart:setEmissionRate(10)
    elseif (self.isBouncy) then
        redPart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        redPart:setEmissionRate(0)
        bluePart:setParticleLifetime(1, 2) --used to denote time on screen from minimum time alive to maximum
        bluePart:setEmissionRate(15)
        bluePart:setSpeed(20, 25)
        yellowPart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        yellowPart:setEmissionRate(0)
    elseif (self.isNormal) then
        love.graphics.draw(blackPart, self.x, self.y, 0, 0.5, 0.5)
        redPart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        redPart:setEmissionRate(0)
        bluePart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        bluePart:setEmissionRate(0)
        yellowPart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        yellowPart:setEmissionRate(0)
    elseif (self.dead) then
        redPart:setParticleLifetime(1, 2) --used to denote time on screen from minimum time alive to maximum
        redPart:setEmissionRate(15)
        redPart:setSpeed(20, 25)
        bluePart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        bluePart:setEmissionRate(0)
        yellowPart:setParticleLifetime(0, 0) --used to denote time on screen from minimum time alive to maximum
        yellowPart:setEmissionRate(0)
    
        
    end 

    love.graphics.draw(yellowPart, self.x, self.y, 0, 0.5, 0.5)
    love.graphics.draw(redPart, self.x, self.y, 0, 0.5, 0.5)
    love.graphics.draw(bluePart, self.x, self.y, 0, 0.5, 0.5)
    

        
    

    -- if (contactType == "sticky") then

    -- elseif contactType == "normal" then

    -- elseif


    
    drawColor('solid')
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

end

function piet:death() 
    self.dead = true
end