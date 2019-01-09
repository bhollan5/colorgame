require "scripts/world"
require "scripts/piet"

function love.load() -- Runs at the start of our program

    love.graphics.setDefaultFilter("nearest") -- Graphic settings

    -- Calling the loading functions in each of these files
    world:load()
    piet:load()
end

function love.update(dt)
    -- Calling the update functions in both of these files
    -- 'dt' is the number of seconds since last update. Probably something like 0.01
    world:update(dt)
    piet:update(dt)
end

function love.draw()
    -- Calling the draw functions in both of these files
    world:draw()
    piet:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end