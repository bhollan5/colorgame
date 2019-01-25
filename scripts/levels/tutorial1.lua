tutorial1 = {}

function tutorial1:load()

    world:fadeIn()

    dialogue:insert('Before embarking on any new journey, it\'s important to establish a background. You gotta make sure you\'re prepared. \n\nYou gotta do your homework, you know?')

    world.nextLevel = "tutorial2"

    --the platforms below are ordered as follows: left to right, top to bottom
    --sticky:newBlock(0, 14, 8, 1)
    solid:newBlock(-6, 20, 24, 6)
    death:newBlock(24, 20, 6, 6)

    solid:newBlock(36, 20, 24, 6)
    solid:newBlock(54, -10, 6, 30) -- Big walking wall structure
    solid:newBlock(54, -10, 24, 6)

    solid:newBlock(42, -10, 6, 24) -- Left walljump wall 
    solid:newBlock(66, 0, 6, 24) -- Decorative opposite to walljump wall

    death:newBlock(84, -10, 6, 6)
    solid:newBlock(96, -10, 24, 6)

    goal:newBlock(101, -14)




end