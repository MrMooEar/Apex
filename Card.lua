local m = {}

m.CARD_AREA_PLAYER_DECK = 0
m.CARD_AREA_GLOBAL_DECK = 1
m.CARD_AREA_HAND = 2
m.CARD_AREA_DISCARD = 3
m.CARD_AREA_DEPLOY = 4
m.CARD_AREA_CAPTURE = 5
m.CARD_AREA_CAPTURE_PRIZE = 6

m.CARD_TEXTBOX_WIDTH					= 45
m.CARD_TEXTBOX_HEIGHT					= 45
m.CARD_TEXTBOX_RECT_RATIO_X_1			= 0.1
m.CARD_TEXTBOX_RECT_RATIO_Y_1			= 0.65
m.CARD_TEXTBOX_RECT_RATIO_X_2			= 0.9
m.CARD_TEXTBOX_RECT_RATIO_Y_2			= 0.9

-- require here
local CardDatabase = require('CardDatabase')

function m:new(...)
    local Ob = {}

	-- add members here
    Ob.prop = nil
    Ob.textbox = nil
    Ob.cardArea = nil
	Ob.deployedThisTurn = nil
	
	-- from the card DB
	Ob.artName = nil
	Ob.resourceAmount = nil
	Ob.resourceCost = nil
	Ob.power = nil
	Ob.toughness = nil
	Ob.drawCards = nil
	Ob.cardText = nil

    -- member functions here
    function Ob:init( cardName )
		self.deployedThisTurn = false    	
		
		local cardDBentry = g_cardDatabase:GetCardDBentry( cardName )
    	
		-- copy each of the table entries into the self
		self.artName = cardDBentry.artName
		self.resourceAmount = cardDBentry.resourceAmount
		self.resourceCost = cardDBentry.resourceCost
		self.power = cardDBentry.power
		self.toughness = cardDBentry.toughness
		self.drawCards = cardDBentry.drawCards
		self.cardText = cardDBentry.cardText
    end
    
    function Ob:getProp()
    	return self.prop
    end
    
    function Ob:getCardArea()
    	return self.cardArea
    end
    
    function Ob:setCardArea( cardArea )
    	self.cardArea = cardArea
    end
    
    function Ob:getLoc()
    	return self.prop:getLoc()
    end
    
    function Ob:setLoc( x, y )
    	self.prop:setLoc( x, y )
    end
    
    function Ob:setRenderPriority( pri )
		if self.prop then
			self.prop:setPriority( pri )
		end
		
		if self.textbox then
			self.textbox:setPriority( pri )
		end
    end
    
    -- create the card visuals and put them into the specified layer
    function Ob:CreateCardVisuals( layer )
		self.prop = MOAIProp2D.new()
		if ( self.artName == nil ) then
			print( "IVALID art name for card in CreateCardVisuals!" )
		else
			print( "Going to get the art for : " .. self.artName )
		end
		local cardGfx = g_cardDatabase:GetCardArt( self.artName )
		self.prop:setDeck( cardGfx )
		
		-- put a text box on the card
		local font =  MOAIFont.new ()
		font:loadFromTTF ( "arialbd.ttf", "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.?! ", 12, 163 )
		
		local textbox = MOAITextBox.new ()
		textbox:setFont ( font )
		textbox:setColor( 0, 0, 0 )
		textbox:setGlyphScale( 0.25 )
		textbox:setAlignment ( MOAITextBox.LEFT_JUSTIFY, MOAITextBox.LEFT_JUSTIFY )
		--textbox:setAlignment ( MOAITextBox.LEFT_JUSTIFY, MOAITextBox.TOP_JUSTIFY )
		--textbox:setAlignment ( MOAITextBox.CENTER_JUSTIFY )
		textbox:setYFlip ( true )
		local x1 = g_cardDatabase.CARD_WIDTH*m.CARD_TEXTBOX_RECT_RATIO_X_1 - (g_cardDatabase.CARD_WIDTH/2)
		local y1 = -(g_cardDatabase.CARD_HEIGHT*m.CARD_TEXTBOX_RECT_RATIO_Y_1 - (g_cardDatabase.CARD_HEIGHT/2))
		local x2 = g_cardDatabase.CARD_WIDTH*m.CARD_TEXTBOX_RECT_RATIO_X_2 - (g_cardDatabase.CARD_WIDTH/2)
		local y2 = -(g_cardDatabase.CARD_HEIGHT*m.CARD_TEXTBOX_RECT_RATIO_Y_2 - (g_cardDatabase.CARD_HEIGHT/2))
		
		-- HACK
		y1 = 0
		y2 = -30
		
		--print( x1 )
		--print( y1 )
		--print( x2 )
		--print( y2 )
		textbox:setRect ( x1, y1, x2, y2 )
		
		textbox:setLoc ( 0, 10 )	-- HACK
		textbox:setString ( self.cardText )
	
		-- attach the text box to the card prop so that they will move together
		textbox:setParent( self.prop )
			
		self.textbox = textbox
	
		-- set priorities for both the card prop and the text box	
		self.prop:setPriority( 0 )
		self.textbox:setPriority( 0 )	
		
		layer:insertProp( self.prop )
		layer:insertProp( self.textbox )
	end
    
    -- init the object and return it
    Ob:init(...)
    return Ob
end

return m