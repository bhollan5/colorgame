level2 = {}

function level2:load()

    world:fadeIn()

    piet.startPos = {0 * 16, -3 * 16}

    dialogue:insert('Ben holland is a smelly boy')
    world.nextLevel = "lvl3"

    --starting platform beginning
    solid:newBlock(-1, 0, 3, 1)
    bouncy:newBlock(2, 0, 5, 1)
    solid:newBlock(7, 0, 1, 1)
    bouncy:newBlock(8, 0, 12, 1)
    death:newBlock(20, 0, 1, 1)
    sticky:newBlock(21, 0, 1, 1)
    bouncy:newBlock(22, 0, 3, 1)
    solid:newBlock(25, 0, 1, 1)

    --this is the vertical piece directly below the second white block
    bouncy:newBlock(25, 1, 1, 3)
    sticky:newBlock(25, 4, 1, 1)
    bouncy:newBlock(25, 5, 1, 2)
    death:newBlock(25, 7, 1, 1)
    --end

    bouncy:newBlock(26, 0, 2, 1)
    death:newBlock(28, 0, 1, 1)
    --end starting platform

    --large sticky angle shape
    sticky:newBlock(31, -3, 9, 4)
    solid:newBlock(31, -8, 4, 4)
    sticky:newBlock(36, -8, 4, 5)
    --end angle shape

    --first platform directly above the starting platform
    death:newBlock(4, -8, 1, 1)
    bouncy:newBlock(5, -8, 4, 1)
    solid:newBlock(9, -8, 1, 1)
    bouncy:newBlock(10, -8, 1, 1)
    death:newBlock(11, -8, 1, 1)
    --end platform

    --small right angle piece on very left of the map
    bouncy:newBlock(-3, -16, 1, 1)
    sticky:newBlock(-2, -16, 2, 1)
    sticky:newBlock(0, -16, 1, 4)
    --end angle

    --sideways "T" piece
    sticky:newBlock(5, -15, 2, 1)
    death:newBlock(7, -15, 1, 1)
    sticky:newBlock(8, -15, 12, 1)
    solid:newBlock(20, -15, 1, 1)

    --upwards piece in the "T", listed bottom to top
    sticky:newBlock(20, -18, 1, 3)
    bouncy:newBlock(20, -19, 1, 1)
    death:newBlock(20, -20, 1, 1)
    --end

    --downwards piece in the "T", listed top to bottom
    sticky:newBlock(20, -14, 1, 5)
    bouncy:newBlock(20, -9, 1, 1)
    --end

    --the "backwards 1" piece. i have no clue what to call this. 
    --this is the base of the piece
    bouncy:newBlock(37, -19, 3, 1)
    solid:newBlock(36, -19, 1, 1)
    sticky:newBlock(35, -19, 1, 1)
    bouncy:newBlock(28, -19, 7, 1)
    death:newBlock(27, -19, 1, 1)

    --vertical branch
    bouncy:newBlock(35, -22, 1, 3)
    death:newBlock(35, -23, 1, 1)
    bouncy:newBlock(35, -25, 1, 2)
    solid:newBlock(35, -26, 1, 1)
    bouncy:newBlock(35, -28, 1, 2)
    sticky:newBlock(35, -29, 1, 1)

    --horizontal branch
    bouncy:newBlock(36, -26, 5, 1)
    death:newBlock(41, -26, 1, 1)
    bouncy:newBlock(42, -26, 3, 1)
    --end "T" piece

    --2nd large sticky angle shape
    sticky:newBlock(0, -34, 4, 9)
    solid:newBlock(5, -29, 4, 4)
    sticky:newBlock(4, -34, 5, 4)
    --end 

    --moving platform
    solid:newMovingBlock(24, -25, 3, 1, 24, -37, 2)
    --end platform

    --top platform 
    bouncy:newBlock(0, -36, 14, 1)
    --end

    --exit
    solid:newBlock(6, -41, 3, 3)
    --end

end