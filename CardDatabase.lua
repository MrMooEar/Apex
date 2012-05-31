-- the Card Database is a global singleton class that stores two major things:
-- 1) information for all cards in the game
-- 2) art resources for all cards in the game

local m = {}

function m.new(...)
	local Ob = {}
	
		Ob.CARD_WIDTH							= 90
		Ob.CARD_HEIGHT							= 128
		
		Ob.database = {}
		
		Ob.database["Minion"] =
		{
			artName = "CardImages/Memnite.jpg",
			resourceAmount = 1,
			resourceCost = 1,
			power = 2,
			toughness = 3,
			drawCards = 0,
			cardText = "Discard: Gain 1"
		}

		Ob.database["Bear"] =
		{
			artName = "CardImages/GrizzlyBears.jpg",
			resourceAmount = -1,
			resourceCost = 2,
			power = 2,
			toughness = 2,
			drawCards = 0,
			cardText = ""
		}

		Ob.database["Giant"] =
		{
			artName = "CardImages/HillGiant.jpg",
			resourceAmount = 1,
			resourceCost = 3,
			power = 3,
			toughness = 3,
			drawCards = 0,
			cardText = "Discard: Gain 1"
		}

		Ob.database["Fighter"] =
		{
			artName = "CardImages/SadisticAugermage.jpg",
			resourceAmount = 1,
			resourceCost = 2,
			power = 3,
			toughness = 1,
			drawCards = 1,
			cardText = "Discard: Gain 1 and Draw a Card"
		}

		Ob.database["Turtle"] =
		{
			artName = "CardImages/HornedTurtle.jpg",
			resourceAmount = 2,
			resourceCost = 3,
			power = 1,
			toughness = 4,
			drawCards = 0,
			cardText = "Discard: Gain 2"
		}

		Ob.database["Warhorse"] =
		{
			artName = "CardImages/ArmoredWarhorse.jpg",
			resourceAmount = 3,
			resourceCost = 2,
			power = 2,
			toughness = 2,
			drawCards = 0,
			cardText = "Discard: Gain 3"
		}		
		
		Ob.cardArtDatabase = {}
		
		
		function Ob:GetCard( cardName )
			return self.database[ cardName ]
		end

		function Ob:CreateCard( cardName )
			
			cardDBentry = self.database[cardName]
			if (cardDBentry == nil ) then
				print( "INVALID database entry for cardName: " .. cardName )
				return nil
			end
			
			local card = {}
			card.artName = cardDBentry.artName
			card.resourceAmount = cardDBentry.resourceAmount
			card.resourceCost = cardDBentry.resourceCost
			card.power = cardDBentry.power
			card.toughness = cardDBentry.toughness
			card.drawCards = cardDBentry.drawCards
			card.cardText = cardDBentry.cardText
			
			card.deployedThisTurn = false
				
			return card
		end
	
		-- get the MOAIGfxQuad2D for a particular card
		-- if we haven't loaded it yet, it will be loaded
		function Ob:GetCardArt( artName )
			
			cardArtDBentry = self.cardArtDatabase[ artName ]
			if ( cardArtDBentry == nil ) then
				print("Art for card: " .. artName .. " is not loaded!  Loading now!")
				
				local cardArt = MOAIGfxQuad2D.new()
				cardArt:setTexture ( artName )
				cardArt:setRect( -(self.CARD_WIDTH/2), -(self.CARD_HEIGHT/2), self.CARD_WIDTH/2, self.CARD_HEIGHT/2 )
				
				self.cardArtDatabase[ artName ] = cardArt
				return self.cardArtDatabase[ artName ]
			end
			
			return cardArtDBentry	
		end

	return Ob
end

return m