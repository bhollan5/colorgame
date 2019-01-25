tutorial3 = {}

function tutorial3:load()

    world:fadeIn()

    world.nextLevel = "lvl2"
    piet.startPos = {1 * 16, -10 * 16}


    -- In order of the path:
    solid:newBlock(0, 0, 6, 6)

    sticky:newBlock(12, 0, 24, 6)
    solid:newBlock(54, 0, 6, 6)
    sticky:newBlock(36, -18, 6, 24)
    sticky:newBlock(36, -24, 24, 6)


    


    goal:newBlock(137, 32)




end