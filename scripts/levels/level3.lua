level3 = {}

function level3:load()

    world:fadeIn()

    piet.startPos = {1 * 16, -3 * 16}

    dialogue:insert('Mondrian tried to use pure red, yellow and blue colors! \n\n But what fun is that?')
    world.nextLevel = "lvl4"

    -- Some functions to make plotting these easier.
    -- The underscore isn't anything special, just a naming convention for local functions.
    local scale = 8 -- scale of everything
    local _solid = function (x, y) 
        solid:newBlock(x * scale, y * scale, scale, scale)
    end
    local _bouncy = function (x, y) 
        bouncy:newBlock(x * scale, y * scale, scale, scale)
    end
    local _sticky = function (x, y) 
        sticky:newBlock(x * scale, y * scale, scale, scale)
    end
    local _death = function (x, y) 
        death:newBlock(x * scale, y * scale, scale, scale)
    end
    local _smallDeathBlock = function (x, y)
        death:newBlock(x * scale + 3, y * scale + 3, (scale / 4), (scale / 4))
    end
    local _smallSolidBlock = function (x, y)
        solid:newBlock(x * scale + 3, y * scale + 3, (scale / 4), (scale / 4))
    end
    local _smallBouncyBlock = function (x, y)
        bouncy:newBlock(x * scale + 3, y * scale + 3, (scale / 4), (scale / 4))
    end


    -- Rightest column: (odd)
    _smallSolidBlock(2, 3)
    _smallSolidBlock(2, 1)
    _solid(2, -1)
    _sticky(2, -3)
    _solid(2, -5)
    _solid(2, -7)
    _smallSolidBlock(2, -9)
    _smallSolidBlock(2, -11)
    --
    _solid(2, -25)
    _solid(2, -27)
    

    -- First, rightish col: (even)
    _smallSolidBlock(0, 2)
    _solid(0, 0)
    _bouncy(0, -2)
    _solid(0, -4)
    _smallDeathBlock(0, -5)
    _solid(0, -6)
    _solid(0, -8)
    _solid(0, -10)
    _smallSolidBlock(0, -12)
    _smallSolidBlock(0, -14)
    --
    _smallSolidBlock(0, -22)
    _smallSolidBlock(0, -20)
    _solid(0, -24)
    _solid(0, -26)
    _smallDeathBlock(0, -27)
    _solid(0, -28)



    -- Center column: (odd)
    _smallSolidBlock(-2, -1)
    _smallBouncyBlock(-2, 1)
    _smallSolidBlock(-2, 3)
    _smallSolidBlock(-2, 5)
    _smallSolidBlock(-2, 7)
    _solid(-2, -3)
    _solid(-2, -5)
    _sticky(-2, -7)
    _smallDeathBlock(-1, -7)
    _solid(-2, -9)
    _solid(-2, -11)
    _smallSolidBlock(-2, -13)
    _solid(-2, -15)
    _bouncy(-2, -17)
    _sticky(-2, -19)
    _solid(-2, -21)
    _solid(-2, -23)
    _death(-2, -25)
    _solid(-2, -27)
    _solid(-2, -29)
    goal:newBlock(-13, -236)


    -- Leftish column (even)
    _smallSolidBlock(-4, -6)
    _smallDeathBlock(-4, -8)
    _smallSolidBlock(-3, -9)
    _solid(-4, -10)
    _solid(-4, -12)
    _death(-4, -14)
    _solid(-4, -16)
    _solid(-4, -18)
    _solid(-4, -20)
    _bouncy(-4, -22)
    _smallSolidBlock(-4, -24)
    _solid(-4, -26)
    _solid(-4, -28)

    -- 🌹 Leftist column (odd) 
    _smallSolidBlock(-6, -9)
    _smallSolidBlock(-6, -11)
    _solid(-6, -13)
    _sticky(-6, -15)
    _smallSolidBlock(-6, -17)
    _smallSolidBlock(-6, -19)
    _smallBouncyBlock(-6, -21)
    _smallSolidBlock(-6, -23)


    

    


    

end