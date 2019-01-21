tutorial1 = {}

function tutorial1:load()

    world:fadeIn()

    dialogue:insert('Hi!')
    dialogue:insert('Piet Mondrian made pictures out of colors, and then said they didn’t represent anything - they were meant to be purely abstract! ')
    dialogue:insert('What a wacky guy!!')
    dialogue:insert('Anyway, that lil black square there is you!! \n You can move around with the arrow keys, and jump with space!')

    world.nextLevel = "lvl2"

    --the platforms below are ordered as follows: left to right, top to bottom
    --sticky:newBlock(0, 14, 8, 1)
    solid:newBlock(0, 20, 24, 6)
    death:newBlock(27, 20, 6, 6)

    solid:newBlock(36, 20, 24, 6)
    solid:newBlock(54, -10, 6, 30) -- Big walking wall structure
    solid:newBlock(54, -10, 24, 6)

    solid:newBlock(42, -10, 6, 24) -- Left walljump wall 
    solid:newBlock(66, 0, 6, 24) -- Decorative opposite to walljump wall

    death:newBlock(81, -10, 6, 6)
    solid:newBlock(90, -10, 24, 6)




end