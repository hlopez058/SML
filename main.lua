-- Includes
require("model\\vector")

require("resources\\colors")

-- Resources
Load("fighter","resources\\topdownfighter.png")

-- Main 
Win.Title = "Smelly Star Fighter"
Win.Background.Color = Colors.black;

-- Need to know how to get window size
-- as it changes to create window boundaries
-- for animations
x = 0;



-- Animation Frame
Win.Tick = function()
    x = x+1;
    --Win.fighter.Location = {x,x,0,0}

Win.fighter = Object(
    Anchor(1,1,0,0),
    Location(x,0,0,0),
    Size(128,128),
    Background("fighter"),
    Border(0,0,0,0,Colors.white),
    Rounding(0,0,0,0)
    )
end