require "scripts/particles"


piet = {}

piet.movement = {}

piet.startPos = {3 * 16, 8 * 16 }
piet.deathHeight = 60 -- in 16 px units
piet.deathHeight = piet.deathHeight * 16

piet.x = piet.startPos[1]
piet.y = piet.startPos[2]
piet.yVel = 200
piet.xVel = 200

piet.topContact = "air"
piet.rightContact = "air"
piet.bottomContact = "air"
piet.leftContact = "air"

piet.isGrounded = true
piet.hasDouble = true
piet.upKeyBuffer = true
piet.isSticky = false   
piet.isBouncy = false           -- the only purpose for this is for particle effects
piet.isNormal = false           -- ^^ same with this
piet.dead =  false
piet.won = false                -- Triggered when piet wins a level

piet.pauseBuffer = true        -- Ensures we have to unpause before we can pause again

piet.hasDied = false

piet.stuckToCeiling = false     -- indicates whether Piet is stuck to the bottom of a sticky blocks

piet.spd = 2500
piet.maxSpd = 250
piet.jumpHeight = -400
piet.halfJump = (piet.jumpHeight / 2)
piet.wallJumpHeight = -10

piet.bouncyParticles = {}
piet.stickyParticles = {}
piet.deathParticles = {}
piet.deathCoords = { piet.startPos[1], piet.startPos[2]} -- Used to keep track of where piet died, for particles

function piet:load()
    piet.isFresh = true

    self.body = love.physics.newBody(world.world, self.startPos[1], self.startPos[2], "dynamic", 0, 100)
    --self.body:setMass(5)
    self.body:setLinearDamping(.5);
    

    self.shape = love.physics.newRectangleShape(16, 16)
    self.fixture = love.physics.newFixture(self.body, self.shape, 5)
    self.fixture:setFriction(0.3)
    self.fixture:setUserData("piet")

    -- Setting up different particles
    local particleImage = love.graphics.newImage("assets/particles/white.png")

    self.bouncyParticles = love.graphics.newParticleSystem( particleImage, 16 )
    self.bouncyParticles:setParticleLifetime(1, 1.5) -- Particles live at least 2s and at most 5s.
	self.bouncyParticles:setSizeVariation(1)
    self.bouncyParticles:setLinearAcceleration(-20, -10, 20, 1000) -- Random movement in all directions.
    self.bouncyParticles:setEmissionArea('borderrectangle', 16, 16)
    self.bouncyParticles:setRadialAcceleration( 500, 1000 )

    self.stickyParticles = love.graphics.newParticleSystem( particleImage, 16 )
    self.stickyParticles:setParticleLifetime(1, 1.5) -- Particles live at least 2s and at most 5s.
	self.stickyParticles:setSizeVariation(1)
    self.stickyParticles:setLinearAcceleration(-20, -10, 20, 1000) -- Random movement in all directions.
    self.stickyParticles:setEmissionArea('borderrectangle', 16, 16)
    self.stickyParticles:setRadialAcceleration( 500, 1000 )

    self.deathParticles = love.graphics.newParticleSystem( particleImage, 16 )
    self.deathParticles:setParticleLifetime(1, 1.5) -- Particles live at least 2s and at most 5s.
	self.deathParticles:setSizeVariation(1)
    self.deathParticles:setLinearAcceleration(-20, -10, 20, 1000) -- Random movement in all directions.
    self.deathParticles:setEmissionArea('borderrectangle', 16, 16)
    self.deathParticles:setRadialAcceleration( 500, 1000 )

    -- self.body:setFixedRotation( true )

    --self.fixture:setRestitution(0.9)
end

function piet:update(dt)
    self.bouncyParticles:update(dt)
    self.stickyParticles:update(dt)
    self.deathParticles:update(dt)


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

    -- dying from falling
    if self.y > (self.deathHeight) then
        self.dead = true
    end

    -- Pausing the game
    if (love.keyboard.isDown("p") or love.keyboard.isDown("return")) and self.pauseBuffer then
        pauseState = 'main'
        pause:load()
        self.pauseBuffer = false
    elseif not love.keyboard.isDown("p") and not love.keyboard.isDown("return") then
        self.pauseBuffer = true
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
        self.body:setLinearVelocity(0,0)
        -- freezes player when world is transitioning
        return 
    end

    -- NORMAL back and forth movement
    if love.keyboard.isDown("a") and piet.xVel > -piet.maxSpd then
        self.body:applyLinearImpulse(-self.spd * dt, 0)
    elseif love.keyboard.isDown("d") and piet.xVel < piet.maxSpd then
        self.body:applyLinearImpulse(self.spd * dt, 0)
    elseif self.isGrounded == false then 
        self.body:setLinearVelocity(self.xVel * 0.99, self.yVel)
    else
        -- self.body:setLinearVelocity(self.xVel, self.yVel)
    end

    -- ALL JUMP FUNCTIONS:
    if love.keyboard.isDown("w")then 

        -- Normal walljump
        if self.leftContact == "solid" and self.yVel > -100 and love.keyboard.isDown("a") then
            self.body:applyLinearImpulse(750, self.jumpHeight * 1.6)
        elseif self.rightContact == "solid" and self.yVel > -100 and love.keyboard.isDown("d") then
            self.body:applyLinearImpulse(-750, self.jumpHeight * 1.6)

        -- Sticky wall climb
        elseif self.leftContact == "sticky" and self.yVel > -100 and love.keyboard.isDown("a") then
            self.body:setLinearVelocity(0, self.halfJump)
        elseif self.rightContact == "sticky" and self.yVel > -100 and love.keyboard.isDown("d") then
            self.body:setLinearVelocity(0, self.halfJump)

        -- Normal, solid jump
        elseif self.isGrounded and self.bottomContact ~= "sticky" then
            self.body:applyLinearImpulse(0, self.jumpHeight)
            self.isGrounded = false
            self.upKeyBuffer = false

        -- Sticky jump
        elseif self.isGrounded and self.bottomContact == "sticky" then 
            self.body:applyLinearImpulse(0, self.halfJump)
            self.isGrounded = false
            self.upKeyBuffer = false

        -- Sticking to top of thing
        elseif self.topContact == "sticky" then
            -- Moving back and forth while stuck to a sticky thing: 
            if love.keyboard.isDown("a") and self.topContact == "sticky" then
                self.body:setLinearVelocity(-self.spd / 10, -100)
            elseif love.keyboard.isDown("d") and self.topContact == "sticky"  then
                self.body:setLinearVelocity(self.spd / 10, -100)
            else 
                self.body:setLinearVelocity(self.xVel, -100)
            end

        -- double jump
        elseif (self.hasDouble and self.upKeyBuffer) then
            self.body:setLinearVelocity(self.xVel, self.jumpHeight)
            self.hasDouble = false 
        end
    end
    
    -- Keeps track of whether we let go of 'w', so we can double jump
    if not love.keyboard.isDown("w") then
        self.upKeyBuffer = true
        self.stuckToCeiling = false
    end

    
    

end

function piet:draw()

    drawColor('bouncy')
    love.graphics.draw(self.bouncyParticles, piet.x, piet.y, 0, 0.5, 0.5)
    drawColor('sticky')
    love.graphics.draw(self.stickyParticles, piet.x, piet.y, 0, 0.5, 0.5)
    drawColor('death')
    love.graphics.draw(self.deathParticles, piet.deathCoords[1], piet.deathCoords[2], 0, 0.5, 0.5)


    drawColor('solid')
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

end

function piet:death() 
    self.dead = true
end

