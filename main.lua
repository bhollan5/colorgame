require "scripts.world"
require "scripts.piet"

require "scripts/GUIs/dialogue"

require "scripts.globalFunctions"
require "scripts/gamestateManager"

require "scripts/GUIs/title"

local show_message = false
gamestate = 'debugLevel' -- Keeps track of what context we're in!
                    -- Gamestate options:
                        -- 'title'
                        -- 'lvl1'

time = 0

debug = true

function love.load() -- Runs at the start of our program

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

    blueRGB = { 83 / 255, 100 / 255, 229 / 255 }
    redRGB = { 203 / 255, 52 / 255, 52 / 255 }
    yellowRGB = { 229 / 255, 222 / 255, 83 / 255 }
    blackRGB = {0, 0, 0}
    whiteRGB = {250/256,250/256,250/256}


    -- ###################################
    -- ##        GLOBAL SETTINGS:       ##
    -- ###################################

    love.graphics.setDefaultFilter("nearest") -- Graphic settings
    love.graphics.setBackgroundColor(whiteRGB[1], whiteRGB[2], whiteRGB[3])

    -- ###################################
    -- ##          LOAD FUNCS:          ##
    -- ###################################

    changeGameState(gamestate) -- Looking for this function? Check scripts/gamestateManager.lua
end

function love.update(dt)
    -- Calling the update functions in both of these files
    -- 'dt' is the number of seconds since last update. Probably something like 0.01
    if (gamestate == 'lvl1') or (gamestate == 'debugLevel') then
        world:update(dt)
        piet:update(dt)
    elseif(gamestate == 'title') then
        title:update(dt)
    end
    time = time + 1
end

function love.draw()

    if gamestate == 'title' then
        title:draw()
    elseif gamestate == 'lvl1' or gamestate == 'debugLevel' then
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
        love.graphics.translate(-piet.x + w / 2, -piet.y + h / 2)
    else
        love.graphics.translate(-piet.x + w / 2, -(piet.deathHeight - h))
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