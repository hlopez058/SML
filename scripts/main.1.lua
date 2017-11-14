-- Includes
require("model\\vector")
require("resources\\colors")
require("packages\\skunk")

-- Resources
Load("fighter","resources\\topdownfighter.png")

-- Main 
Win.Title = "Smelly Star Fighter"
Win.Background.Color = Colors.black;

-- Need to know how to get window size
-- as it changes to create window boundaries
-- for animations
x = 0;

Win.fighter = Object(
    Anchor(1,1,0,0),
    Location(0,0,0,0),
    Size(128,128),
    Background("fighter"),
    Border(0,0,0,0,Colors.white),
    Rounding(0,0,0,0)
    )

-- Animation Frame
Win.Tick = function()
    -- get the 
    -- get the system setup so that
    -- you could animate objects?
    -- i want to be able to 
    -- move an image across the screen
    -- by
    x = x+1;
    -- use an array of objectS?
    -- move in an array of ways
    -- store start and end position in
    -- skunk table
   Skunk.Move(Win.fighter,x,10);
end
