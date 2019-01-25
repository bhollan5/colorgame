tutorial3 = {}

function tutorial3:load()

    world:fadeIn()

    world.nextLevel = "lvl2"
    piet.startPos = {1 * 16, -10 * 16}


    -- In order of the path:
    solid:newBlock(0, 0, 6, 6)

    sticky:newBlock(12, 0, 24, 6)

    solid:newBlock(51, 0, 6, 6)     -- Decorative black box

    sticky:newBlock(36, -24, 6, 30)
    sticky:newBlock(42, -24, 9, 6)
    sticky:newBlock(57, -24, 15, 6)

    sticky:newBlock(66, -18, 6, 24)

    sticky:newBlock(66, 0, 24, 6)
    solid:newBlock(96, 0, 6, 6)
    sticky:newBlock(96, -12, 60, 6)
    solid:newBlock(126, 0, 6, 6)

    goal:newBlock(128, -4)


end