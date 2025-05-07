return {
	["misc"] = {
		["suits_plural"] = {
			["spectrum_fakewild"] = "fake wilds",
		},
		["poker_hands"] = {
			["spectrum_Spectrum"] = "Spectrum",
			["spectrum_Spectrum Five"] = "Spectrum Five",
			["spectrum_Straight Spectrum_2"] = "Royal Spectrum",
			["spectrum_Spectrum House"] = "Spectrum House",
			["spectrum_Straight Spectrum"] = "Straight Spectrum",
			--[[ Uncomment for testing
			["bunc_Spectrum"] = "Spectrum (Bunco)",
			["bunc_Spectrum Five"] = "Spectrum Five (Bunco)",
			["bunc_Straight Spectrum_2"] = "Royal Spectrum (Bunco)",
			["bunc_Spectrum House"] = "Spectrum House (Bunco)",
			["bunc_Straight Spectrum"] = "Straight Spectrum (Bunco)",
			--]]
		},
		["suits_singular"] = {
			["spectrum_fakewild"] = "fake wild",
		},
		["poker_hand_descriptions"] = {
			["spectrum_Spectrum"] = {
				"5 cards with different suits",
			},
			["spectrum_Spectrum Five"] = {
				"5 cards with the same rank,",
				"each with a different suit",
			},
			["spectrum_Straight Spectrum"] = {
				"5 cards in a row (consecutive ranks),",
				"each with a different suit",
			},
			["spectrum_Spectrum House"] = {
				"A Three of a Kind and a Pair with",
				"each card having a different suit",
			},
		},
	},
	["descriptions"] = {
		["Joker"] = {
			["j_spectrum_pensive"] = {
				["name"] = "Pensive Joker",
				["text"] = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_giggly"] = {
				["name"] = "Giggly Joker",
				["text"] = {
					"{C:mult}+#1#{} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_rainbow"] = {
				["name"] = "The Rainbow",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_smeared_alt"] = {
				["name"] = "Smeared Joker",
				["text"] = {
					"{C:hearts}Hearts{} and {C:diamonds}Diamonds",
					"count as the same suit,",
					"{C:spades}Spades{} and {C:clubs}Clubs",
					"count as the same suit",
					"All {C:attention}modded{} suits",
					"count as the same suit"
				},
				["unlock"] = {
					"Have at least {C:attention}#1#",
                    "{E:1,C:attention}#2#{} in",
                    "your deck",
				},
			},
		},
		["Planet"] = {
			["c_spectrum_Vulcan"] = {
				["name"] = "Vulcan",
			},
			["c_spectrum_Nibiru"] = {
				["name"] = "Nibiru",
			},
			["c_spectrum_Phaeton"] = {
				["name"] = "Phaeton",
			},
			["c_spectrum_Yuggoth"] = {
				["name"] = "Yuggoth",
			},
			["c_spectrum_Vulcan_main"] = {
				["name"] = "Vulcan",
			},
			["c_spectrum_Nibiru_main"] = {
				["name"] = "Nibiru",
			},
			["c_spectrum_Phaeton_main"] = {
				["name"] = "Phaeton",
			},
			["c_spectrum_Yuggoth_main"] = {
				["name"] = "Yuggoth",
			},
			["c_spectrum_Vulcan_alt"] = {
				["name"] = "Rainbow Planet",
			},
			["c_spectrum_Nibiru_alt"] = {
				["name"] = "House Planet",
			},
			["c_spectrum_Phaeton_alt"] = {
				["name"] = "Line Planet",
			},
			["c_spectrum_Yuggoth_alt"] = {
				["name"] = "Planet Cluster",
			},
		},
	},
}