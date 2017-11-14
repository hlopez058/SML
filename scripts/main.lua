-- Includes
require("scripts\\lib\\vector")
require("scripts\\lib\\colors")

-- Resources
Load("fighter","scripts\\img\\topdownfighter.png")

-- Main 
Win.Title = "Smelly Star Fighter"
Win.Background.Color = Colors.white;

Win.Header = Object(
    Anchor(1,1,1,0),
    Location(0,0,0,0),
    Size(128,128),
    Background(""),
    Border(1,1,1,1,Colors.black),
    Rounding(0,0,0,0)
    )


-- Animation Frame
Win.Tick = function()
end
