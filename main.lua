require "scripts.world"
require "scripts.piet"

require "scripts/GUIs/dialogue"

require "scripts.globalFunctions"
require "scripts/gamestateManager"

require "scripts/GUIs/title"
require "scripts/GUIs/pause"

local show_message = false
gamestate = 'tutorial1' -- Keeps track of what context we're in!
                    -- Gamestate options:
                        -- 'title'
                        -- 'tutorial1'
                        -- 'tutorial2'
                        -- 'tutorial3'
                        -- 'lvl1'
                        -- 'lvl2'
                        -- 'debugLevel'

pauseState = 'none'     -- keeps track of wether the game is paused
                        -- note, this is NOT a separate gamestate, but rather a thing that
                        -- can happen any time Piet is being updated.
                        -- When pauseState isn't 'none', world will not be drawn or updated

time = 0

debug = true

function love.load() -- Runs at the start of our program

    love.window.setFullscreen(true)

    -- ###################################
    -- ##       GLOBAL VARIABLES:       ##
    -- ###################################

    -- Fonts:

    titleFontSize = 48
    titleFont = love.graphics.newFont("assets/fonts/Square.ttf", titleFontSize)
    dialogueFontSize = 20
    dialogueFont = love.graphics.newFont("assets/fonts/Square.ttf", dialogueFontSize)
    smallFontSize = 14
    smallFont = love.graphics.newFont("assets/fonts/Square.ttf", smallFontSize)

    -- Colors:

    -- MONDRIAN COLOR SCHEME:
    blueRGB = { 83 / 255, 100 / 255, 229 / 255 }
    redRGB = { 203 / 255, 52 / 255, 52 / 255 }
    yellowRGB = { 229 / 255, 222 / 255, 83 / 255 }
    blackRGB = {0, 0, 0}
    whiteRGB = {250/256,250/256,250/256}

    -- POPPY, CANDY SCHEME:

    candyBackground = { 111 / 255, 111 / 255, 111 / 255 }
    candyRedRGB = { 220 / 255, 121 / 255, 154 / 255 }
    candyYellowRGB = { 239 / 255, 215 / 255, 59 / 255 }
    candyBlueRGB = { 129 / 255, 127 / 255, 236 / 255 }
    candyBlackRGB = { 0,0,0 }

    -- DARK, CHILLY COLOR SCHEME:
    chillyGrayRGB = {63/255,63/255,63/255}
    chillyBlueRGB = { 129 / 255, 127 / 255, 236 / 255 }
    chillyPurpleRGB = { 207 / 255, 125 / 255, 221 / 255 }
    chillyGreenRGB = { 167 / 255, 228 / 255, 188 / 255 }

    chillyRedRGB = { 160 / 255, 41 /255, 63 / 255}
    chillyPinkRGB = { 228 / 255, 167/255, 222/255}
    chillyYellowRGB = { 228 / 255, 222 /255, 167 / 255 }

    -- Initializing these colors with the Mondrian scheme:
    backgroundColor = whiteRGB
    solidColor = blackRGB
    bouncyColor = blueRGB
    stickyColor = yellowRGB
    deathColor = redRGB

    -- General:

    gridSize = 16 -- referring to pixels


    -- ###################################
    -- ##        GLOBAL SETTINGS:       ##
    -- ###################################

    love.graphics.setDefaultFilter("nearest") -- Graphic settings

    -- ###################################
    -- ##          LOAD FUNCS:          ##
    -- ###################################

    changeColorScheme(gamestate)
    changeGameState(gamestate) -- Looking for this function? Check scripts/gamestateManager.lua
end

function love.update(dt)
    time = time + 1

    if (piet.yVel < -1000) then
        return 

    end
    -- Calling the update functions in both of these files
    -- 'dt' is the number of seconds since last update. Probably something like 0.01
    if pauseState == 'main' then 
        pause:update(dt)
    elseif(gamestate == 'title') then
        title:update(dt)
    else
        world:update(dt)
        piet:update(dt)
    end
end

function love.draw()


    if pauseState == 'main' then 
        pause:draw()
    elseif gamestate == 'title' then
        title:draw()
    else
        -- Calling the draw functions in both of these files
        cameraFollow() 
        world:draw()
        piet:draw()
    end
    dialogue:draw()
  
end

function cameraFollow() 


    -- Camera logic
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local screenLock = (piet.y + (h/2));
    

    if screenLock < (piet.deathHeight) then
        love.graphics.translate(-piet.x + w / 2, (-piet.y + h / 2) + (world.transitionHeight))
    else
        love.graphics.translate(-piet.x + w / 2, -(piet.deathHeight - h) + (world.transitionHeight))
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key == "f" then
        love.window.setFullscreen(true)
    end
end