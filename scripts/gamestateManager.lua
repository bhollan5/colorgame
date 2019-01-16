

-- This function handles all the extra stuff needed for any given gamestate change.
--
-- Note that this function will only be called ONCE per gamestate change.
-- Update and draw functions are still changed in main.lua
function changeGameState(newState) 
    -- local oldGamestate = gamestate -- Uncomment if you need to use the prev. gamestate
    gamestate = newState
    if gamestate == 'title' then
        title:load()
    elseif gamestate == 'lvl1' then 
        world:load() 
        level1:load()
        piet:load()

    elseif gamestate == 'debugLevel' then 
        world:load() 
        debugLevel:load()
        piet:load()

    elseif gamestate == 'lvl2' then
        world:load()
        level2:load()
        piet:load()

    end

    love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
end