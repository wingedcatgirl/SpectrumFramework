SMODS.Atlas {
    key = 'spectrumplanets',
    path = "planets.png",
    px = 71,
    py = 95
}

local sixsuits = (SMODS.Mods["SixSuits"] or {}).can_load
local bunco = (SMODS.Mods["Bunco"] or {}).can_load


SMODS.Consumable{ -- Vulcan/Rainbow Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    pos = {x=0, y=0},
    key = 'Vulcan',
    name = "Vulcan",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = {}
        G.localization.descriptions[self.set][self.key.."_main"] = {}
        G.localization.descriptions[self.set][self.key.."_alt"] = {}
        G.localization.descriptions[self.set][self.key].text = target_text
        G.localization.descriptions[self.set][self.key.."_main"].text = target_text
        G.localization.descriptions[self.set][self.key.."_alt"].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 and sixsuits then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 and bunco then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return false
        end
        return true
    end,
	loc_vars = function(self, info_queue, center)
        local key = "c_spectrum_Vulcan_main"
        local art = SPECF.config.planet_design.current_option
        if art == 1 then
            key = "c_spectrum_Vulcan_main"
        elseif art == 2 then
            key = "c_spectrum_Vulcan_alt"
        elseif art == 3 and sixsuits then
            key = "c_six_gj_273_c"
        elseif art == 4 and bunco then
            key = "c_bunc_quaoar"
        else
            key = "c_spectrum_Vulcan_main"
        end

		return {
            key = key,
			vars = {
				G.GAME.hands["spectrum_Spectrum"].level,
				localize("spectrum_Spectrum", "poker_hands"),
				G.GAME.hands["spectrum_Spectrum"].l_mult,
				G.GAME.hands["spectrum_Spectrum"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["spectrum_Spectrum"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands["spectrum_Spectrum"].level)))]
					),
				},
			},
		}
	end,
    update = function(self, card, dt)
        local art = SPECF.config.planet_design.current_option
        local planetref = card.config.center
        planetref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=0, y=0}
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_spectrumplaceholders'
            planetref.pos = { x=0, y=2 }
            planetref.soul_pos = { x=1, y=2 }
        elseif art == 3 and sixsuits then
            planetref.atlas = 'six_Tarot'
            planetref.pos = { x=0, y=0 }
        elseif art == 4 and bunco then
            planetref.atlas = 'bunc_bunco_planets'
            planetref.pos = { x=0, y=0 }
        else --Fall back on default art 
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=0, y=0}
        end

        card:set_sprites(planetref)
    end,
    --generate_ui = 0,
}

SMODS.Consumable{ -- Nibiru/House Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    pos = {x=2, y=0},
    key = 'Nibiru',
    name = "Nibiru",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum House', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = {}
        G.localization.descriptions[self.set][self.key.."_main"] = {}
        G.localization.descriptions[self.set][self.key.."_alt"] = {}
        G.localization.descriptions[self.set][self.key].text = target_text
        G.localization.descriptions[self.set][self.key.."_main"].text = target_text
        G.localization.descriptions[self.set][self.key.."_alt"].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 and sixsuits then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 and bunco then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return false
        end
        return true
    end,
    update = function(self, card, dt)
        local planetref = card.config.center
        local art = SPECF.config.planet_design.current_option
        planetref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=2, y=0}
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_spectrumplaceholders'
            planetref.pos = { x=0, y=2 }
            planetref.soul_pos = { x=2, y=2 }
        elseif art == 3 and sixsuits then
            planetref.atlas = 'six_Tarot'
            planetref.pos = { x=2, y=0 }
        elseif art == 4 and bunco then
            planetref.atlas = 'bunc_bunco_planets'
            planetref.pos = { x=2, y=0 }
        else --Fall back on default art 
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=2, y=0}
        end

        card:set_sprites(planetref)
    end,
    generate_ui = 0,
}

SMODS.Consumable{ -- Phaeton/Line Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    pos = {x=1, y=0},
    key = 'Phaeton',
    name = "Phaeton",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Straight Spectrum', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = {}
        G.localization.descriptions[self.set][self.key.."_main"] = {}
        G.localization.descriptions[self.set][self.key.."_alt"] = {}
        G.localization.descriptions[self.set][self.key].text = target_text
        G.localization.descriptions[self.set][self.key.."_main"].text = target_text
        G.localization.descriptions[self.set][self.key.."_alt"].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 and sixsuits then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 and bunco then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return false
        end
        return true
    end,
    update = function(self, card, dt)
        local planetref = card.config.center
        local art = SPECF.config.planet_design.current_option
        planetref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=1, y=0}
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_spectrumplaceholders'
            planetref.pos = { x=0, y=2 }
            planetref.soul_pos = { x=3, y=2 }
        elseif art == 3 and sixsuits then
            planetref.atlas = 'six_Tarot'
            planetref.pos = { x=1, y=0 }
        elseif art == 4 and bunco then
            planetref.atlas = 'bunc_bunco_planets'
            planetref.pos = { x=1, y=0 }
        else --Fall back on default art 
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=1, y=0}
        end

        card:set_sprites(planetref)
    end,
    generate_ui = 0,
}

SMODS.Consumable{ -- Yuggoth/Planet Cluster
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    pos = {x=3, y=0},
    key = 'Yuggoth',
    name = "Yuggoth",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum Five', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key] = {}
        G.localization.descriptions[self.set][self.key.."_main"] = {}
        G.localization.descriptions[self.set][self.key.."_alt"] = {}
        G.localization.descriptions[self.set][self.key].text = target_text
        G.localization.descriptions[self.set][self.key.."_main"].text = target_text
        G.localization.descriptions[self.set][self.key.."_alt"].text = target_text
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        local planettype = (art == 2) and "Planets??" or "Planet?"
        badges[1] = create_badge(planettype, get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 and sixsuits then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 and bunco then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return false
        end
        return true
    end,
    update = function(self, card, dt)
        local planetref = card.config.center
        local art = SPECF.config.planet_design.current_option
        planetref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=3, y=0}
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_spectrumplaceholders'
            planetref.pos = { x=0, y=2 }
            planetref.soul_pos = { x=4, y=2 }
        elseif art == 3 and sixsuits then
            planetref.atlas = 'six_Tarot'
            planetref.pos = { x=3, y=0 }
        elseif art == 4 and bunco then
            planetref.atlas = 'bunc_bunco_planets'
            planetref.pos = { x=3, y=0 }
        else --Fall back on default art 
            planetref.atlas = 'spectrum_spectrumplanets'
            planetref.pos = {x=3, y=0}
        end

        card:set_sprites(planetref)
    end,
    generate_ui = 0,
}