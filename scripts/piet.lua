require "scripts/particles"


piet = {}

piet.movement = {}

piet.startPos = {3 * 16, 8 * 16 }
piet.deathHeight = 60 -- in 16 px units
piet.deathHeight = piet.deathHeight * 16

piet.x = piet.startPos[1]
piet.y = piet.startPos[2]
piet.yVel = 0
piet.xVel = 0

piet.topContact = "air"
piet.rightContact = "air"
piet.bottomContact = "air"
piet.leftContact = "air"

piet.isGrounded = true
piet.hasDouble = true
piet.upKeyBuffer = true
piet.isSticky = false   
piet.isBouncy = false -- the only purpose for this is for particle effects
piet.isNormal = false   -- ^^ same with this
piet.dead =  false
piet.won = false                -- Triggered when piet wins a level
piet.wallJump = false
piet.wallJumpR = false
piet.wallJumpL = false
piet.hasDied = false

piet.stuckToCeiling = false     -- indicates whether Piet is stuck to the bottom of a sticky blocks

piet.spd = 250
piet.jumpHeight = -400
piet.wallJumpHeight = -10

piet.particles = {}

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

    local particleImage = love.graphics.newImage("assets/particles/white.png")

    self.particles = love.graphics.newParticleSystem( particleImage, 10 )
    self.particles:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	self.particles:setEmissionRate(5)
	self.particles:setSizeVariation(1)
    self.particles:setLinearAcceleration(20, -20, 20, 20) -- Random movement in all directions.
	self.particles:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.

    -- self.body:setFixedRotation( true )

    --self.fixture:setRestitution(0.9)
end

function piet:update(dt)
    particles:update(dt)
    local halfJump = (self.jumpHeight / 2)

    self.particles:update(dt)

    self.xVel, self.yVel = self.body:getLinearVelocity()
    self.x, self.y = self.body:getPosition()

    -- Handling death
    if (self.dead) then
        self.body:setPosition(self.startPos[1], self.startPos[2])
        self.body:setLinearVelocity(0, 0)
        self.xVel, self.yVel = self.body:getLinearVelocity()
        piet:draw()
        solid:reset()
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

    if self.won then 
        world.isTransitioningUp = true
        world.transitionBuffer = .5 -- In seconds
        changeColorScheme(world.nextLevel) -- Found in gamestateManager
        
        self.won = false
        return 
    end

    if love.keyboard.isDown("a") then
        self.body:setLinearVelocity(-self.spd, self.yVel)
    elseif love.keyboard.isDown("d") then
        self.body:setLinearVelocity(self.spd, self.yVel)
    elseif self.isGrounded == false then 
        self.body:setLinearVelocity(0, self.yVel)
    else
        self.body:setLinearVelocity(self.xVel, self.yVel)
    end

    -- normal jump
    if love.keyboard.isDown("w") and not self.isSticky then 

        if (self.isGrounded) then
            self.body:applyLinearImpulse(0, self.jumpHeight)

            self.isGrounded = false
            self.upKeyBuffer = false
        elseif (self.hasDouble and self.upKeyBuffer) then
            self.body:setLinearVelocity(self.xVel, self.jumpHeight)
            self.hasDouble = false 
        end
    end

    -- Handling sticky contact physics
    if love.keyboard.isDown("w") and ((self.isSticky) and (self.isGrounded)) then
        self.body:applyLinearImpulse(0, halfJump)
        -- Handles going up walls
    elseif love.keyboard.isDown("w") and (self.isSticky) then
        self.body:setLinearVelocity(self.xVel, -self.spd)
    end

    -- Sticks us to the ceiling 
    if self.stuckToCeiling and love.keyboard.isDown("d") then
        self.body:setLinearVelocity(self.spd, -self.spd)
    elseif self.stuckToCeiling and love.keyboard.isDown("a") then
        self.body:setLinearVelocity(-self.spd, -self.spd)
    elseif self.stuckToCeiling then
        self.body:setLinearVelocity(0, -self.spd)
    end
    
    -- Keeps track of whether we let go of 'w', so we can double jump
    if not love.keyboard.isDown("w") then
        self.upKeyBuffer = true
        self.stuckToCeiling = false
    end

    if (self.wallJump) then
        if (love.keyboard.isDown("space") and (self.wallJumpR)) then
            self.body:applyLinearImpulse(250, self.jumpHeight)
        elseif (love.keyboard.isDown("space") and (self.wallJumpL)) then
            self.body:applyLinearImpulse(-250, self.jumpHeight)
        end
    end
    

end

function piet:draw()
    drawColor('sticky')
    love.graphics.draw(self.particles, self.x, self.y)
    drawColor('solid')
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

end

function piet:death() 
    self.dead = true
end

