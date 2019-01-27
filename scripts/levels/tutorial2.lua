tutorial2 = {}

function tutorial2:load()

    world:fadeIn()

    world.nextLevel = "tutorial3"
    piet.startPos = {1 * 16, -10 * 16}


    -- First column:
    solid:newBlock(0, 0, 24, 6)
    solid:newBlock(0, 12, 24, 6)
    bouncy:newBlock(0, 24, 24, 6)
    solid:newBlock(0, 36, 24, 6)

    -- Second column:
    bouncy:newBlock(30, 0, 24, 6)
    solid:newBlock(60, 0, 6, 6)

    solid:newBlock(30, 12, 6, 6)
    solid:newBlock(42, 12, 24, 6)

    solid:newBlock(30, 24, 24, 6)
    solid:newBlock(60, 24, 6, 6)
    
    solid:newBlock(30, 36, 6, 6)
    solid:newBlock(42, 36, 24, 6)

    -- Downward stairs, from top to bottom:
    bouncy:newBlock(72, 12, 6, 6)

    solid:newBlock(72, 24, 6, 6)
    bouncy:newBlock(84, 24, 6, 6)

    solid:newBlock(72, 36, 6, 6)
    bouncy:newBlock(84, 36, 30, 6)
    solid:newBlock(120, 36, 24, 6)

    


    goal:newBlock(137, 32)




end