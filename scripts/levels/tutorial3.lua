tutorial3 = {}

function tutorial3:load()

    world:fadeIn()

    world.nextLevel = "lvl2"
    piet.startPos = {1 * 16, -10 * 16}


    -- In order of the path:
    solid:newBlock(0, 0, 6, 6)

    sticky:newBlock(12, 0, 24, 6)
    solid:newBlock(42, -6, 6, 6)

    solid:newBlock(30, -12, 6, 6)

    solid:newBlock(30, -12, 6, 6)

    


    goal:newBlock(137, 32)




end