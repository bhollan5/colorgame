level2 = {}

function level2:load()

    world:fadeIn()

    piet.startPos = {1 * 16, -3 * 16}

    dialogue:insert('Ben holland is a smelly boy')
    world.nextLevel = "lvl3"

    --black snakey platforms
    solid:newBlock(0, 0, 8, 2)
    death:newBlock(10, 0, 2, 2)
    solid:newBlock(10, 4, 2, 20)
    sticky:newBlock(10, 26, 2, 2)
    solid:newBlock(14, 26, 11, 2)
    death:newBlock(27, 26, 2, 2)

    solid:newBlock(31, 7, 2, 21)
    sticky:newBlock(31, 3, 2, 2)

    bouncy:newBlock(35, 26, 2, 2)
    solid:newBlock(39, 26, 11, 2)
    sticky:newBlock(52, 26, 2, 2)
    solid:newBlock(56, 26, 5, 2)

    -- big platforms surrounded by snakey platforms
    bouncy:newBlock(14, 0, 15, 24)
    solid:newBlock(35, 11, 15, 13) -- THIS SHOuLD BE DEATH, when sticky above is programmed
    bouncy:newBlock(52, 4, 9, 20)

    -- second snakey black platforms
    solid:newBlock(63, 6, 4, 14)
    death:newBlock(63, 22, 4, 4)
    solid:newBlock(63, 28, 4, 2)

    solid:newBlock(69, 6, 4, 2)
    sticky:newBlock(69, 10, 4, 4)
    solid:newBlock(69, 16, 4, 14)

    solid:newBlock(75, 26, 18, 4)
    sticky:newBlock(95, 26, 4, 4)

    solid:newBlock(101, 6, 4, 6)
    death:newBlock(101, 14, 4, 4)
    solid:newBlock(101, 20, 4, 10)

    -- big blue block
    bouncy:newBlock(75, 4, 24, 20)

    

end