local m = {}

-- require some stuff here

function m:new(...)
    local Ob = {}

	-- add members here
    Ob.prop = nil
    Ob.textbox = nil
    
    -- member functions here
    function Ob:init()
    end
    
    function Ob:SetPriority( pri )
		if Ob.prop then
			Ob.prop:setPriotiry( pri )
		end
		
		if Ob.textbox then
			Ob.textbox:setPriority( pri )
		end
    end
    
    -- init the object and return it
    Ob:init(...)
    return Ob
end

return m