SMODS.Consumable{ -- Vulcan/Rainbow Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'planets',
    pos = {x=0, y=0},
    key = 'Vulcan',
    name = "Vulcan",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        local suffixes = {"", "_main", "_alt", "_six", "_bunc"}

        for _, suffix in ipairs(suffixes) do
            local full_key = self.key .. suffix
            G.localization.descriptions[self.set][full_key] = {}
            G.localization.descriptions[self.set][full_key].text = target_text
        end
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
	loc_vars = function(self, info_queue, card)
        local key = self.key
        local hand = card.ability.hand_type
        local art = SPECF.config.planet_design.current_option
        if art == 1 then
            key = key.."_main"
        elseif art == 2 then
            key = key.."_alt"
        elseif art == 3 then
            key = key.."_six"
        elseif art == 4 then
            key = key.."_bunc"
        else
            key = self.key
        end

		return {
            key = key,
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						to_big(G.GAME.hands[hand].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands[hand].level)))]
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
            planetref.atlas = 'spectrum_planets'
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_planets-doodles'
            planetref.soul_pos = {
                x = planetref.pos.x,
                y = 1
            }
        elseif art == 3 then --Art by Shinku+Reiji from Six Suits
            planetref.atlas = 'spectrum_planets-sixsuits'
        elseif art == 4 then --Art by Firch from Bunco
            planetref.atlas = 'spectrum_planets-bunco'
        else --Fall back on default art 
            planetref.atlas = 'spectrum_planets'
        end

        if SPECF.config.planet_design.last_option[self.key] ~= SPECF.config.planet_design.current_option then
            SPECF.config.planet_design.last_option[self.key] = SPECF.config.planet_design.current_option
            card:set_sprites(planetref)
        end
    end,
}

SMODS.Consumable{ -- Nibiru/House Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'planets',
    pos = {x=2, y=0},
    key = 'Nibiru',
    name = "Nibiru",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum House', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        local suffixes = {"", "_main", "_alt", "_six", "_bunc"}

        for _, suffix in ipairs(suffixes) do
            local full_key = self.key .. suffix
            G.localization.descriptions[self.set][full_key] = {}
            G.localization.descriptions[self.set][full_key].text = target_text
        end
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
	loc_vars = function(self, info_queue, card)
        local key = self.key
        local hand = card.ability.hand_type
        local art = SPECF.config.planet_design.current_option
        if art == 1 then
            key = key.."_main"
        elseif art == 2 then
            key = key.."_alt"
        elseif art == 3 then
            key = key.."_six"
        elseif art == 4 then
            key = key.."_bunc"
        else
            key = self.key
        end

		return {
            key = key,
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						to_big(G.GAME.hands[hand].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands[hand].level)))]
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
            planetref.atlas = 'spectrum_planets'
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_planets-doodles'
            planetref.soul_pos = {
                x = planetref.pos.x,
                y = 1
            }
        elseif art == 3 then --Art by Shinku+Reiji from Six Suits
            planetref.atlas = 'spectrum_planets-sixsuits'
        elseif art == 4 then --Art by Firch from Bunco
            planetref.atlas = 'spectrum_planets-bunco'
        else --Fall back on default art 
            planetref.atlas = 'spectrum_planets'
        end

        if SPECF.config.planet_design.last_option[self.key] ~= SPECF.config.planet_design.current_option then
            SPECF.config.planet_design.last_option[self.key] = SPECF.config.planet_design.current_option
            card:set_sprites(planetref)
        end
    end,
}

SMODS.Consumable{ -- Phaeton/Line Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'planets',
    pos = {x=1, y=0},
    key = 'Phaeton',
    name = "Phaeton",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Straight Spectrum', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        local suffixes = {"", "_main", "_alt", "_six", "_bunc"}

        for _, suffix in ipairs(suffixes) do
            local full_key = self.key .. suffix
            G.localization.descriptions[self.set][full_key] = {}
            G.localization.descriptions[self.set][full_key].text = target_text
        end
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
	loc_vars = function(self, info_queue, card)
        local key = self.key
        local hand = card.ability.hand_type
        local art = SPECF.config.planet_design.current_option
        if art == 1 then
            key = key.."_main"
        elseif art == 2 then
            key = key.."_alt"
        elseif art == 3 then
            key = key.."_six"
        elseif art == 4 then
            key = key.."_bunc"
        else
            key = self.key
        end

		return {
            key = key,
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						to_big(G.GAME.hands[hand].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands[hand].level)))]
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
            planetref.atlas = 'spectrum_planets'
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_planets-doodles'
            planetref.soul_pos = {
                x = planetref.pos.x,
                y = 1
            }
        elseif art == 3 then --Art by Shinku+Reiji from Six Suits
            planetref.atlas = 'spectrum_planets-sixsuits'
        elseif art == 4 then --Art by Firch from Bunco
            planetref.atlas = 'spectrum_planets-bunco'
        else --Fall back on default art 
            planetref.atlas = 'spectrum_planets'
        end

        if SPECF.config.planet_design.last_option[self.key] ~= SPECF.config.planet_design.current_option then
            SPECF.config.planet_design.last_option[self.key] = SPECF.config.planet_design.current_option
            card:set_sprites(planetref)
        end
    end,
}

SMODS.Consumable{ -- Yuggoth/Planet Cluster
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'planets',
    pos = {x=3, y=0},
    key = 'Yuggoth',
    name = "Yuggoth",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum Five', softlock = true},
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        local suffixes = {"", "_main", "_alt", "_six", "_bunc"}

        for _, suffix in ipairs(suffixes) do
            local full_key = self.key .. suffix
            G.localization.descriptions[self.set][full_key] = {}
            G.localization.descriptions[self.set][full_key].text = target_text
        end
    end,
    set_card_type_badge = function(self, card, badges)
        local art = SPECF.config.planet_design.current_option
        local planettype = (art == 2) and "Planets??" or "Planet?"
        badges[1] = create_badge(planettype, get_type_colour(self or card.config, card), nil, 1.2)
        if art == 3 then
            badges[2] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[2] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
	loc_vars = function(self, info_queue, card)
        local key = self.key
        local hand = card.ability.hand_type
        local art = SPECF.config.planet_design.current_option
        if art == 1 then
            key = key.."_main"
        elseif art == 2 then
            key = key.."_alt"
        elseif art == 3 then
            key = key.."_six"
        elseif art == 4 then
            key = key.."_bunc"
        else
            key = self.key
        end

		return {
            key = key,
			vars = {
				G.GAME.hands[hand].level,
				localize(hand, "poker_hands"),
				G.GAME.hands[hand].l_mult,
				G.GAME.hands[hand].l_chips,
				colours = {
					(
						to_big(G.GAME.hands[hand].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands[hand].level)))]
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
            planetref.atlas = 'spectrum_planets'
        elseif art == 2 then --Doodles by wingedcatgirl
            planetref.atlas = 'spectrum_planets-doodles'
            planetref.soul_pos = {
                x = planetref.pos.x,
                y = 1
            }
        elseif art == 3 then --Art by Shinku+Reiji from Six Suits
            planetref.atlas = 'spectrum_planets-sixsuits'
        elseif art == 4 then --Art by Firch from Bunco
            planetref.atlas = 'spectrum_planets-bunco'
        else --Fall back on default art 
            planetref.atlas = 'spectrum_planets'
        end

        if SPECF.config.planet_design.last_option[self.key] ~= SPECF.config.planet_design.current_option then
            SPECF.config.planet_design.last_option[self.key] = SPECF.config.planet_design.current_option
            card:set_sprites(planetref)
        end
    end,
}


if (SMODS.Mods["Cryptid"] or {}).can_load then
    SMODS.Consumable{ -- Cryptid triple-planet
        set = 'Planet',
        cost = 4,
        unlocked = true,
        discovered = false,
        atlas = 'planets',
        pos = {x=4, y=0},
        key = 'Ambira',
        name = "Ambira",
        effect = 'Hand Upgrade',
        config = {
            hand_types = {
                'spectrum_Straight Spectrum',
                'spectrum_Spectrum House',
                'spectrum_Spectrum Five',
            },
            softlock = true},
        set_card_type_badge = function(self, card, badges)
            badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
        end,
        in_pool = function()
            local advanced_spectrum_played = false
            if G and G.GAME and G.GAME.hands then
                for k, v in pairs(G.GAME.hands) do
                    if (
                    string.find(k, "Straight Spectrum", nil, true)
                    or string.find(k, "Spectrum House", nil, true)
                    or string.find(k, "Spectrum Five", nil, true)
                    ) then
                        if G.GAME.hands[k].played > 0 then
                            advanced_spectrum_played = true
                            break
                        end
                    end
                end
            end
            return advanced_spectrum_played
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    localize("spectrum_Straight Spectrum", "poker_hands"),
                    localize("spectrum_Spectrum House", "poker_hands"),
                    localize("spectrum_Spectrum Five", "poker_hands"),
                    number_format(G.GAME.hands["spectrum_Straight Spectrum"].level),
                    number_format(G.GAME.hands["spectrum_Spectrum House"].level),
                    number_format(G.GAME.hands["spectrum_Spectrum Five"].level),
                    colours = {
                        (
                            to_big(G.GAME.hands["spectrum_Straight Spectrum"].level) == to_big(1) and G.C.UI.TEXT_DARK
                            or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands["spectrum_Straight Spectrum"].level)))]
                        ),
                        (
                            to_big(G.GAME.hands["spectrum_Spectrum House"].level) == to_big(1) and G.C.UI.TEXT_DARK
                            or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands["spectrum_Spectrum House"].level)))]
                        ),
                        (
                            to_big(G.GAME.hands["spectrum_Spectrum Five"].level) == to_big(1) and G.C.UI.TEXT_DARK
                            or G.C.HAND_LEVELS[to_number(to_big(math.min(7, G.GAME.hands["spectrum_Spectrum Five"].level)))]
                        ),
                    },
                },
            }
        end,
        can_use = function(self, card)
            return true
        end,
        use = function(self, card, area, copier)
            Cryptid.suit_level_up(card, copier, 1, card.config.center.config.hand_types)
        end,
        bulk_use = function(self, card, area, copier, number)
            Cryptid.suit_level_up(card, copier, number, card.config.center.config.hand_types)
        end,
        calculate = function(self, card, context)
            if
                G.GAME.used_vouchers.v_observatory
                and context.joker_main
                and (
                    context.scoring_name == "Straight Spectrum"
                    or context.scoring_name == "Spectrum House"
                    or context.scoring_name == "Spectrum Five"
                )
            then
                local value = G.P_CENTERS.v_observatory.config.extra
                return {
                    message = localize({ type = "variable", key = "a_xmult", vars = { value } }),
                    Xmult_mod = value,
                }
            end
        end,
    }
end