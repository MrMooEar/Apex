local m = {}

m.ACTION_TYPE_DISCARD 		= 0
m.ACTION_TYPE_DEPLOY		= 1
m.ACTION_TYPE_CAPTURE		= 2

function m:new(...)
    local Ob = {}
    
    Ob.ActionType = nil
    
    function Ob:init()
    end
    
    Ob:init(...)
    return Ob
end

return m