level1 = {}

function level1:load()

    dialogue:insert('Hi, Edward! Nice color choice! You’re not going to be that color, though. \n\nSee that little black square there? THAT’S you.')
    dialogue:insert('… I think that’s you, right? \n\n(You can move around with the arrow keys and press space to jump!)')
    gamestate = 'lvl1' 

    --the platforms below are ordered as follows: left to right, top to bottom
    --yellow:newBlock(0, 14, 8, 1)
    black:newBlock(0, 20, 7, 1)
    black:newBlock(0, 22, 7, 2)
    black:newBlock(0, 25, 7, 11)
    
    blue:newBlock(10, 28, 8, 3)
    yellow:newBlock(10, 32, 8, 2)
    red:newBlock(10, 35, 8, 1)

    black:newBlock(21, 20, 7, 1)
    black:newBlock(21, 22, 7, 2)
    black:newBlock(21, 25, 7, 11)

    --red square with black square inside
    red:newBlock(34, 15, 8, 2)
    red:newBlock(42, 17, 2, 8)
    red:newBlock(36, 23, 8, 2)
    red:newBlock(34, 17, 2, 8)
    black:newBlock(38, 19, 2, 2)

    --yellow angle platform
    yellow:newBlock(31, 28, 19, 3)
    yellow:newBlock(47, 15, 3, 16)

    -- lower black decorative blocks
    black:newBlock(31, 32, 8, 2)
    black:newBlock(31, 35, 8, 1)

    black:newBlock(51, 15, 1, 8)
    black:newBlock(53, 15, 2, 8)

    black:newBlock(51, 32, 4, 4)

    -- uppzer black zig zag
    black:newBlock(34, 10, 8, 2)
    black:newBlock(34, 2, 2, 8)
end