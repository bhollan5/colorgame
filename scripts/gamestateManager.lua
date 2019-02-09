

-- This function handles all the extra stuff needed for any given gamestate change.
--
-- Note that this function will only be called ONCE per gamestate change.
-- Update and draw functions are still changed in main.lua
function changeGameState(newState) 
    -- local oldGamestate = gamestate -- Uncomment if you need to use the prev. gamestate

    gamestate = newState
    world:unloadLevel()
    if gamestate == 'title' then
        title:load()
    elseif gamestate == 'debugLevel' then 
        world:load() 
        debugLevel:load()
        piet:load()
    elseif gamestate == 'tutorial1' then 
        world:load() 
        tutorial1:load()
        piet:load()
    elseif gamestate == 'tutorial2' then 
        world:load() 
        tutorial2:load()
        piet:load()
    elseif gamestate == 'tutorial3' then 
        world:load() 
        tutorial3:load()
        piet:load()
    elseif gamestate == 'lvl1' then 
        world:load() 
        level1:load()
        piet:load()
    elseif gamestate == 'lvl2' then
        world:load()
        level2:load()
        piet:load()
    end
    love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
end

function changeColorScheme(newState) 
    if newState == 'lvl1' then 
        backgroundColor = whiteRGB
        solidColor = blackRGB
        bouncyColor = blueRGB
        stickyColor = yellowRGB
        deathColor = redRGB
    elseif newState == 'lvl2' or newState == 'debugLevel' then 
        backgroundColor = whiteRGB
        solidColor = candyBlackRGB
        bouncyColor = candyBlueRGB
        stickyColor = candyYellowRGB
        deathColor = candyRedRGB
    end
    love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])

end