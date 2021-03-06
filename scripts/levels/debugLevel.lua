debugLevel = {}

function debugLevel:load()

    piet.startPos = {10, 10}

    backgroundColor = chillyGrayRGB
    solidColor = whiteRGB
    bouncyColor = chillyBlueRGB
    stickyColor = chillyPurpleRGB
    deathColor = chillyGreenRGB

    world.nextLevel = "lvl1"

    dialogue:insert('Welcome to the debug level lol')
    --the platforms below are ordered as follows: left to right, top to bottom
    --sticky:newBlock(0, 14, 8, 1)
    sticky:newBlock(-40, 20, 30, 1)
    solid:newBlock(-10, 20, 30, 1)
    sticky:newBlock(0, -10, 3, 20)
    sticky:newBlock(0, -10, 10, 2)
    bouncy:newBlock(20, 20, 30, 1)

    death:newBlock(5, 15, 2, 2)

    solid:newMovingBlock(7, 15, 4, 1, 10, 10, 3)

    bouncy:newMovingBlock(25, 15, 4, 1, 25, 10, .2)
    bouncy:newMovingBlock(30, 15, 4, 1, 30, 10, .1)

    goal:newBlock(-19, 16)

end