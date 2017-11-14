-- Library of animation functions


Skunk = {
    Move = function(obj,x,y)
        -- transform to window corner
        -- change position
        obj.Anchor = Anchor(1,1,0,0)
        obj.Location = Location(x,y,0,0)
        return obj;
    end,
    
    x=100,
    
    y=20,
    
    Animation = function (self,obj,state)
    -- 
     Skunk.Move(obj,state.x,state.y);
     
    end
}


