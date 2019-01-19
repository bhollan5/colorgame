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
    elseif self.isTransitioningUp then
        if (self.transitionHeight < -50000) then
            self.isTransitioningUp = false
            self.transitionHeight = 0
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
    self.isTransitioningDown = true 
    self.transitionHeight = 500
end

-- contact behavior
function beginContact(a, b, coll)

    -- X and Y give a UNIT VECTOR from the first shape to the second
    -- So if a is piet and b is a block below him at normal orientation,
    -- X and Y will be (0, -1)
    local x, y = coll:getNormal() 
    local aType = a:getUserData()
    debug_lastCollisionA = aType
    local bType = b:getUserData()
    debug_lastCollisionB = bType

    beginContactCollisionCheck(aType, bType, x, y) 
    beginContactCollisionCheck(bType, aType, x, -y) 
end

function beginContactCollisionCheck(aType, bType, x, y) 

    if ((aType == "solid" or aType == "bouncy" or aType == "sticky") and bType == "piet") then
        if (x == 0 and y == -1) then
            piet.isGrounded = true
            piet.hasDouble = true
        end
    end
end



function endContact(a, b, coll)
    persisting = 0
    
    piet.isNormal = false
    piet.isBouncy = false
    piet.isSticky = false
    --piet.fixture:setRestitution(0)

end
 
function preSolve(a, b, coll)
    local x, y = coll:getNormal() 
    local aType = a:getUserData()
    local bType = b:getUserData()
    preSolveCollisionCheck(aType, bType, x, y)
    preSolveCollisionCheck(bType, aType, x, -y)
    
end

function preSolveCollisionCheck(aType, bType, x, y)
    if persisting == 0 then
        piet.isNormal = false
        piet.isBouncy = false
        piet.isSticky = false
    elseif persisting > 0.5 then
        if (aType == "sticky" and bType == "piet") then
            if ((x == -1 and y == 0) or (x == 1 and y == 0) or (x == 0 and y == 1)) then
                piet.isGrounded = false
                piet.isSticky = true
            elseif not ((x == -1 and y == 0) or (x == 1 and y == 0) or (x == 0 and y == 1)) then
                if (x == 0 and y == -1) then
                    piet.isGrounded = true
                    piet.isSticky = true
                end
            end
        elseif not (aType == "sticky" and bType == "piet") then
            if (aType == "solid" and bType == "piet") then
                if (x == 0 and y == -1) then
                    piet.isGrounded = true
                    piet.isNormal = true
                end
            end
        
        end
        
    end
    if (aType == "death" and bType == "piet") then
        piet.dead = true
    end

    if (aType == "goal" and bType == "piet") and not piet.won then
        piet.won = true
        
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
    local hasWallJumpLeft = "false"
    if piet.wallJumpLeft then
        hasWallJumpLeft = "true"
    end


    local debugPrintouts = { -- This should hold a series of strings, to be printed out
        "Total time: " .. time,
        "piet.isGrounded:  " .. isGroundedString,
        "piet.hasDouble:  " .. hasDoubleString,
        "Collision A type: " .. debug_lastCollisionA,
        "Collision B type: " .. debug_lastCollisionB,
        "piet.wallJumpLeft: " .. hasWallJumpLeft,
        "piet.won: " .. hasWonString,
        "gamestate:  " .. gamestate,
        "transitionBuffer" .. world.transitionBuffer
    }
    
    local printoutColors = { 'death', 'bouncy', 'sticky', 'solid'}
    for i in ipairs(debugPrintouts) do
        drawColor(printoutColors[(i % 4) + 1]) -- just for prettiness!!
        love.graphics.print(debugPrintouts[i], piet.x - (w / 2) + 10, piet.y - (h / 2) + (i * 20))
    end
end 