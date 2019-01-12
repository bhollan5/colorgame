particles = {}

particles.color = {}

function particles:load(args)
    
    local redParticles = {}
    local img = love.graphics.newImage("/assets/red.png")
    redPart = love.graphics.newParticleSystem(img, 10)
    redPart:setParticleLifetime(2, 5) --used to denote time on screen from minimum time alive to maximum
    redPart:setEmissionRate(5) --speed at which particles get produced
    redPart:setSizeVariation(1)
    redPart:setLinearAcceleration(-20, -20, 20, 0) --used to set boundaries for particle movement. (x min, x max, y min, y max)
    redPart:setSpeed(5, 10) --sets speed at which particles travel per unit of time. ranges from slowest to fastest
    redPart:setColors(255, 255, 255, 255, 255, 255, 255, 0)

    local blueParticles = {}
    local img = love.graphics.newImage("/assets/blue.png")
    bluePart = love.graphics.newParticleSystem(img, 10)
    bluePart:setParticleLifetime(2, 5) --used to denote time on screen from minimum time alive to maximum
    bluePart:setEmissionRate(5) --speed at which particles get produced
    bluePart:setSizeVariation(1)
    bluePart:setLinearAcceleration(-20, -20, 20, 0) --used to set boundaries for particle movement. (x min, x max, y min, y max)
    bluePart:setSpeed(5, 10) --sets speed at which particles travel per unit of time. ranges from slowest to fastest
    bluePart:setColors(255, 255, 255, 255, 255, 255, 255, 0)

    local yellowParticles = {}
    local img = love.graphics.newImage("/assets/yellow.png")
    yellowPart = love.graphics.newParticleSystem(img, 10)
    yellowPart:setParticleLifetime(2, 5) --used to denote time on screen from minimum time alive to maximum
    yellowPart:setEmissionRate(5) --speed at which particles get produced
    yellowPart:setSizeVariation(1)
    yellowPart:setLinearAcceleration(-20, -20, 20, 0) --used to set boundaries for particle movement. (x min, x max, y min, y max)
    yellowPart:setSpeed(5, 10) --sets speed at which particles travel per unit of time. ranges from slowest to fastest
    yellowPart:setColors(255, 255, 255, 255, 255, 255, 255, 0)

    table.insert(self.color, redParticles)
    table.insert(self.color, blueParticles)
    table.insert(self.color, yellowParticles)
end

function particles:update(dt)
    redPart:update(dt)
    bluePart:update(dt)
    yellowPart:update(dt)
end

function particles:draw()
    
end
         


