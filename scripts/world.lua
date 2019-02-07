require "scripts/piet"
require "scripts/blockMaterials/sticky_floor"
require "scripts/blockMaterials/bouncy_floor"
require "scripts/blockMaterials/death_floor"
require "scripts/blockMaterials/solid_floor"
require "scripts/blockMaterials/goal"
require "scripts/particles"


require "scripts/levels/level1"
require "scripts/levels/debugLevel"
require "scripts/levels/level2"
require "scripts/levels/tutorial1"
require "scripts/levels/tutorial2"
require "scripts/levels/tutorial3"


world = {}

-- table for love.physics objects
world.arena = {}
world.isInitialized = false -- keeps us from initializing world twice

world.gravity = {
    x = 0,
    y = 1000
}

world.nextLevel = "lvl2"                -- This gets loaded when you hit the goal

world.isTransitioningDown = false   -- Marks whether the game is transitioning in, a process for which the game pauses
world.isTransitioningUp = false     -- Marks whether the game is transitioning out, a process for which the game pauses
world.transitionBuffer = 0          -- keeps track of time before transition

world.transitionHeight = 0      -- Marks the height of the camera as it descends on a level,

function world:load()

    self.isInitialized = true
    
    self.world = love.physics.newWorld(self.gravity.x, self.gravity.y)
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    text = ""
    persisting = 0

    
end

function world:newArenaStructure(x, y, w, h)
    width = w * 16
    height = h * 16

    xPos = (x * 16) + (width / 2)
    yPos = (y * 16) + (height / 2)

end

function world:update(dt)    
    if (pauseState ~= 'none') then
        return 
    end
    particles:update(dt)

    solid:update(dt)
    death:update(dt)
    bouncy:update(dt)
    sticky:update(dt)

    self.world:update(dt);
    if self.isTransitioningDown then
        if (self.transitionHeight < 3) then
            self.transitionHeight = 0 
            self.isTransitioningDown = false
        end
        self.transitionHeight = ((self.transitionHeight) * (.95))
    elseif self.isTransitioningUp and not self.isTransitioningDown then
        if (self.transitionHeight < -30000) then
            self.isTransitioningUp = false
            piet.won = false
            changeGameState(world.nextLevel)
        end
        if self.transitionBuffer > 0 then 
            self.transitionBuffer = self.transitionBuffer - (1 * dt)
        else
            self.transitionHeight = -math.abs((math.abs(self.transitionHeight) + 1) * (1.1)) -- makes a kind of quadratic curve, an ease in 
        end
    end
    
end

function world:unloadLevel() 
    solid:clear()
    death:clear()
    bouncy:clear()
    sticky:clear()
    goal:clear()
end

function world:draw()
    if (pauseState ~= 'none') then
        return 
    end

    solid:draw()
    death:draw()
    bouncy:draw()
    sticky:draw()
    goal:draw()

    if (debug) then
        drawDebug()
    end

end

function world:fadeIn()
    self.transitionHeight = 500
    self.isTransitioningDown = true 
end

-- contact behavior
function beginContact(a, b, coll)

    -- X and Y give a UNIT VECTOR from the first shape to the second
    -- So if a is a platform and b is piet above the block at normal orientation,
    -- X and Y will be (0, -1)
    -- normal vectors behave as follows: (0, -1) is an object below, (0, 1) is an object above, 
    --(1, 0) is an object to the left, (-1, 0) is an object to the right.
    local x, y = coll:getNormal() 
    local char = b:getUserData() -- used to get the data from the FIRST body
    debug_lastCollisionB = char
    local platform = a:getUserData() -- used to get the data from the SECOND body
    debug_lastCollisionA = platform


    if (char == 'piet') then
        if (x == 0 and y == -1) then
            piet.bottomContact = platform
        end
        if (x == 0 and y == 1) then
            piet.topContact = platform
        end
        if (x == -1 and y == 0) then
            piet.rightContact = platform
        end
        if (x == 1 and y == 0) then
            piet.leftContact = platform
        end
    end

    if (char == "piet") then
        if (platform == "bouncy") then
            piet.bouncyParticles:emit(10)
        elseif (platform == "sticky") then 
            piet.stickyParticles:emit(10)
        elseif (platform == "death") then 
            piet.deathCoords[1] = piet.x
            piet.deathCoords[2] = piet.y
            piet.deathParticles:emit(10)
        end
    end

    if (char == "piet" and (platform == "solid" or platform == "bouncy")) then
        if (x == 0 and y == -1) then
            piet.isGrounded = true
            piet.hasDouble = true
        end
    elseif (char == "piet" and platform == "bouncy") then
        if (x == 0 and y == -1) then
            piet.isGrounded = true
            piet.hasDouble = true
        end
    elseif (char == "piet" and platform == "solid") then
        if (x == 0 and y == -1) then
            piet.isNormal = true
            piet.isGrounded = true
            piet.hasDouble = true
        elseif (x == -1 and y == 0) then
            piet.isGrounded = false
            piet.xVel = 0
        elseif (x == 1 and y == 0) then
            piet.isGrounded = false
            piet.xVel = 0
        end
    
    end

    
end





function endContact(a, b, coll)
    persisting = 0
    
    piet.isNormal = false
    piet.isBouncy = false
    piet.isSticky = false
    

    piet.rightContact = 'air'
    piet.leftContact = 'air'
        
    piet.bottomContact = 'air'
    piet.topContact = 'air'

    local x, y = coll:getNormal() 
    local char = b:getUserData() -- used to get the data from the FIRST body
    local platform = a:getUserData() -- used to get the data from the SECOND body


end
 
function preSolve(a, b, coll)
    local x, y = coll:getNormal() 
    local char = b:getUserData()
    local platform = a:getUserData()

    if persisting == 0 then
        piet.isNormal = false
        piet.isBouncy = false
        piet.isSticky = false
    elseif persisting > 0 then
        
        if (char == "piet" and platform == "sticky") then
            if (x == 0 and y == -1) then
                piet.isSticky = true
                piet.isGrounded = true
                piet.hasDouble = true
            elseif ((x == -1 and y == 0) or (x == 1 and y == 0)) then
                piet.isGrounded = false
                piet.isSticky = true
            end
        elseif (char == "piet" and platform == "solid") then
            if (x == -1 and y == 0) then
                piet.isGrounded = false
                piet.xVel = 0
            elseif (x == 1 and y == 0) then
                piet.isGrounded = false
                piet.xVel = 0
            elseif (x == 0 and y == -1) then
                piet.isGrounded = true
                piet.hasDouble = true
                piet.isNormal = true
            end
        end
    end

    if (char == "piet" and platform == "death") then
            piet.dead = true
    end
    
    if (char == "piet" and platform == "goal") and not piet.won then
        piet.won = true
        world.isTransitioningUp = true
        world.transitionBuffer = .5 -- In seconds
        changeColorScheme(world.nextLevel) -- Found in gamestateManager
    end
    

    persisting = persisting + 0.1

    
    
end




 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
 
end


-- DEBUG AND DEBUG VARIABLES

debug_lastCollisionA = ''
debug_lastCollisionB = ''

function drawDebug() -- Used to output some debug values on screen
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.graphics.setFont(smallFont) 
    love.graphics.setColor(0,0,0, 1)

    local isGroundedString = 'false'
    if piet.isGrounded then
        isGroundedString = 'true'
    end
    local hasDoubleString = 'false'
    if piet.hasDouble then
        hasDoubleString = 'true'
    end
    local hasWonString = "false"
    if piet.won then 
        hasWonString = "true"
    end
    local hasWallJump = "false"
    if piet.wallJump then
        hasWallJump = "true"
    end
    local isStickyString = "false"
    if piet.isSticky then
        isStickyString = "true"
    end


    local debugPrintouts = { -- This should hold a series of strings, to be printed out
        "Total time: " .. time,
        "piet.isGrounded:  " .. isGroundedString,
        "piet.isSticky: " .. isStickyString,
        "piet.hasDouble:  " .. hasDoubleString,
        "Collision A type: " .. debug_lastCollisionA,
        "Collision B type: " .. debug_lastCollisionB,
        "piet.won: " .. hasWonString,
        "gamestate:  " .. gamestate,
        "xVel: " .. piet.xVel,
        "yVel: " .. piet.yVel,
    }
    
    local printoutColors = { 'death', 'bouncy', 'sticky', 'solid'}
    for i in ipairs(debugPrintouts) do
        drawColor(printoutColors[(i % 4) + 1]) -- just for prettiness!!
        love.graphics.print(debugPrintouts[i], piet.x - (w / 2) + 10, (piet.y - (h / 2) + (i * 20)) - world.transitionHeight)
    end

    -- Contact stuff:
    drawColor('solid')
    love.graphics.rectangle( 'fill', piet.x + (w / 2) - 96, piet.y - (h / 2) + 64, 32, 32 )
    drawColor(piet.topContact)
    love.graphics.print(piet.topContact, piet.x + (w / 2) - 96, piet.y - (h / 2) + 32)
    drawColor(piet.rightContact)
    love.graphics.print(piet.rightContact, piet.x + (w / 2) - 48, piet.y - (h / 2) + 64)
    drawColor(piet.bottomContact)
    love.graphics.print(piet.bottomContact, piet.x + (w / 2) - 94, piet.y - (h / 2) + 100)
    drawColor(piet.leftContact)
    love.graphics.print(piet.leftContact, piet.x + (w / 2) - 128, piet.y - (h / 2) + 64)

end 