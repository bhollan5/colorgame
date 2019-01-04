require "scripts/world"
require "scripts/piet"

function love.load()
    world:load()
    piet:load()
end

function love.update(dt)
    world:update(dt)
    piet:update(dt)
end

function love.draw()
    world:draw()
    piet:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end