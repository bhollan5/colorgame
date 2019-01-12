require "scripts.world"
require "scripts.piet"

require "scripts.globalFunctions"

require "scripts/GUIs/title"

local show_message = false
gamestate = 'title' -- Keeps track of what context we're in!
                    -- Gamestate options:
                        -- 'title'
                        -- 'lvl1'

function love.load() -- Runs at the start of our program

    -- ###################################
    -- ##       GLOBAL VARIABLES:       ##
    -- ###################################

    -- Fonts:

    titleFontSize = 48
    titleFont = love.graphics.newFont("assets/fonts/Square.ttf", titleFontSize)
    dialogueFontSize = 16
    dialogueFont = love.graphics.newFont("assets/fonts/Square.ttf", dialogueFontSize)

    -- Colors:

    blueRGB = { 83 / 255, 100 / 255, 229 / 255 }
    redRGB = { 203 / 255, 52 / 255, 52 / 255 }
    yellowRGB = { 229 / 255, 222 / 255, 83 / 255 }
    blackRGB = {0, 0, 0}


    -- ###################################
    -- ##        GLOBAL SETTINGS:       ##
    -- ###################################

    love.graphics.setDefaultFilter("nearest") -- Graphic settings
    love.graphics.setBackgroundColor(240, 240, 240)


    -- ###################################
    -- ##          LOAD FUNCS:          ##
    -- ###################################
    world:load()
    piet:load()

    title:load()
end

function love.update(dt)
    -- Calling the update functions in both of these files
    -- 'dt' is the number of seconds since last update. Probably something like 0.01
    if (gamestate == 'lvl1') then
        world:update(dt)
        piet:update(dt)
    elseif(gamestate == 'title') then
        title:update(dt)
    end
end

function love.draw()

    if gamestate == 'title' then
        title:draw()
    elseif gamestate == 'lvl1' then
        -- Calling the draw functions in both of these files
        cameraFollow() 
        world:draw()
        piet:draw()
    end

  
end

function cameraFollow() 
    -- Camera logic
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local screenLock = (piet.y + (h/2));
    print(screenLock)
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
