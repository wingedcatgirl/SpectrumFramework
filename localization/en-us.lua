return {
	["misc"] = {
		["poker_hands"] = {
			["spectrum_Spectrum"] = "Spectrum",
			["spectrum_Spectrum Five"] = "Spectrum Five",
			["spectrum_Straight Spectrum_2"] = "Royal Spectrum",
			["spectrum_Spectrum House"] = "Spectrum House",
			["spectrum_Straight Spectrum"] = "Straight Spectrum",
			["spectrum_Specflush"] = "Specflush",
			["spectrum_Specflush Five"] = "Specflush Five",
			["spectrum_Straight Specflush_2"] = "Royal Specflush",
			["spectrum_Specflush House"] = "Specflush House",
			["spectrum_Straight Specflush"] = "Straight Specflush",
			--[[ Uncomment for testing
			["bunc_Spectrum"] = "Spectrum (Bunco)",
			["bunc_Spectrum Five"] = "Spectrum Five (Bunco)",
			["bunc_Straight Spectrum_2"] = "Royal Spectrum (Bunco)",
			["bunc_Spectrum House"] = "Spectrum House (Bunco)",
			["bunc_Straight Spectrum"] = "Straight Spectrum (Bunco)",
			["six_Spectrum"] = "Spectrum (Six Suits)",
			["six_Spectrum Five"] = "Spectrum Five (Six Suits)",
			["six_Straight Spectrum_2"] = "Royal Spectrum (Six Suits)",
			["six_Spectrum House"] = "Spectrum House (Six Suits)",
			["six_Straight Spectrum"] = "Straight Spectrum (Six Suits)",
			["paperback_Spectrum"] = "Spectrum (Paperback)",
			["paperback_Spectrum Five"] = "Spectrum Five (Paperback)",
			["paperback_Straight Spectrum_2"] = "Royal Spectrum (Paperback)",
			["paperback_Spectrum House"] = "Spectrum House (Paperback)",
			["paperback_Straight Spectrum"] = "Straight Spectrum (Paperback)",
			--]]
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
			["spectrum_Specflush"] = {
				"A hand containing both",
				"a Spectrum and a Flush",
			},
			["spectrum_Specflush Five"] = {
				"A hand containing a Spectrum,",
				"a Flush, and a Five of a Kind"
			},
			["spectrum_Straight Specflush"] = {
				"A hand containing a Spectrum,",
				"a Flush, and a Straight"
			},
			["spectrum_Specflush House"] = {
				"A hand containing all of a Spectrum,",
				"a Flush, a Pair, and a Three of a Kind"
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
			["j_spectrum_pensive_main"] = {
				["name"] = "Pensive Joker",
				["text"] = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_giggly_main"] = {
				["name"] = "Giggly Joker",
				["text"] = {
					"{C:mult}+#1#{} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_rainbow_main"] = {
				["name"] = "The Rainbow",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_pensive_six"] = {
				["name"] = "Manic Joker",
				["text"] = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_giggly_six"] = {
				["name"] = "Spectrum Joker",
				["text"] = {
					"{C:mult}+#1#{} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_rainbow_six"] = {
				["name"] = "The Clan",
				["text"] = {
					"{X:mult,C:white} X#1# {} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_pensive_bunc"] = {
				["name"] = "Lurid Joker",
				["text"] = {
					"{C:chips}+#1#{} Chips if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_giggly_bunc"] = {
				["name"] = "Zealous Joker",
				["text"] = {
					"{C:mult}+#1#{} Mult if played",
					"hand contains",
					"a {C:attention}#2#{}",
				},
			},
			["j_spectrum_rainbow_bunc"] = {
				["name"] = "The Dynasty",
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
			["c_spectrum_Vulcan"] = { --Spectrum
				["name"] = "Vulcan",
			},
			["c_spectrum_Vulcan_main"] = {
				["name"] = "Vulcan",
			},
			["c_spectrum_Vulcan_alt"] = {
				["name"] = "Rainbow Planet",
			},
			["c_spectrum_Vulcan_six"] = {
				["name"] = "GJ 273 c",
			},
			["c_spectrum_Vulcan_bunc"] = {
				["name"] = "Quaoar",
			},
			["c_spectrum_Nibiru"] = { --Spectrum House
				["name"] = "Nibiru",
			},
			["c_spectrum_Nibiru_main"] = {
				["name"] = "Nibiru",
			},
			["c_spectrum_Nibiru_alt"] = {
				["name"] = "House Planet",
			},
			["c_spectrum_Nibiru_six"] = {
				["name"] = "Kepler",
			},
			["c_spectrum_Nibiru_bunc"] = {
				["name"] = "Sedna",
			},
			["c_spectrum_Phaeton"] = { --Straight Spectrum
				["name"] = "Phaeton",
			},
			["c_spectrum_Phaeton_main"] = {
				["name"] = "Phaeton",
			},
			["c_spectrum_Phaeton_alt"] = {
				["name"] = "Line Planet",
			},
			["c_spectrum_Phaeton_six"] = {
				["name"] = "Trappist",
			},
			["c_spectrum_Phaeton_bunc"] = {
				["name"] = "Haumea",
			},
			["c_spectrum_Yuggoth"] = { --Spectrum Five
				["name"] = "Yuggoth",
			},
			["c_spectrum_Yuggoth_main"] = {
				["name"] = "Yuggoth",
			},
			["c_spectrum_Yuggoth_alt"] = {
				["name"] = "Planet Cluster",
			},
			["c_spectrum_Yuggoth_six"] = {
				["name"] = "Proxima",
			},
			["c_spectrum_Yuggoth_bunc"] = {
				["name"] = "Makemake",
			},
			["c_spectrum_Ambira"] = { --Three of them
				["name"] = "Ambira",
				["text"] = {
					"({V:1}lvl.#4#{})({V:2}lvl.#5#{})({V:3}lvl.#6#{})",
					"Level up",
					"{C:attention}#1#{},",
					"{C:attention}#2#{},",
					"and {C:attention}#3#{}",
				}
			},
		},
	},
}