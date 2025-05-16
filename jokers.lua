SMODS.Joker {
    key = "pensive",
    name = "Pensive Joker",
    atlas = 'jokers',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config =  { extra = {chips = 90}},
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local art = SPECF.config.joker_design.current_option
        if art == 1 then
            key = key.."_main"
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
                card.ability.extra.chips, localize('spectrum_Spectrum', 'poker_hands')
            }
        }
    end,
    update = function(self, card, dt)
        local art = SPECF.config.joker_design.current_option
        local jokerref = card.config.center
        jokerref.pos = {x = 1, y = 0}
        jokerref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            jokerref.atlas = 'spectrum_jokers'
        elseif art == 2 then --Doodles by wingedcatgirl
            jokerref.atlas = 'spectrum_jokers-doodles'
            jokerref.soul_pos = jokerref.pos
            jokerref.pos = {
                x = 3,
                y = 0
            }
        elseif art == 3 then --Art by Aure from Six Suits
            jokerref.atlas = 'spectrum_jokers-sixsuits'
        elseif art == 4 then --Art by Peas from Bunco
            jokerref.atlas = 'spectrum_jokers-bunco'
        else --Fall back on default art 
            jokerref.atlas = 'spectrum_jokers'
        end

        if SPECF.config.joker_design.last_option[self.key] ~= SPECF.config.joker_design.current_option then
            SPECF.config.joker_design.last_option[self.key] = SPECF.config.joker_design.current_option
            card:set_sprites(jokerref)
        end
    end,
    set_badges = function (self, card, badges)
        local art = SPECF.config.joker_design.current_option
        if art == 3 then
            badges[#badges+1] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[#badges+1] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[SPECF.getSpecKey("Spectrum")]) then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_chips',
                    vars = { card.ability.extra.chips }
                },
                chip_mod = card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker {
    key = "giggly",
    name = "Giggly Joker",
    atlas = 'jokers',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config =  { extra = {mult = 11}},
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local art = SPECF.config.joker_design.current_option
        if art == 1 then
            key = key.."_main"
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
                card.ability.extra.mult,
                localize('spectrum_Spectrum', 'poker_hands')
            }
        }
    end,
    update = function(self, card, dt)
        local art = SPECF.config.joker_design.current_option
        local jokerref = card.config.center
        jokerref.pos = {x = 0, y = 0}
        jokerref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            jokerref.atlas = 'spectrum_jokers'
        elseif art == 2 then --Doodles by wingedcatgirl
            jokerref.atlas = 'spectrum_jokers-doodles'
            jokerref.soul_pos = jokerref.pos
            jokerref.pos = {
                x = 3,
                y = 0
            }
        elseif art == 3 then --Art by Aure from Six Suits
            jokerref.atlas = 'spectrum_jokers-sixsuits'
        elseif art == 4 then --Art by Peas from Bunco
            jokerref.atlas = 'spectrum_jokers-bunco'
        else --Fall back on default art 
            jokerref.atlas = 'spectrum_jokers'
        end

        if SPECF.config.joker_design.last_option[self.key] ~= SPECF.config.joker_design.current_option then
            SPECF.config.joker_design.last_option[self.key] = SPECF.config.joker_design.current_option
            card:set_sprites(jokerref)
        end
    end,
    set_badges = function (self, card, badges)
        local art = SPECF.config.joker_design.current_option
        if art == 3 then
            badges[#badges+1] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[#badges+1] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[SPECF.getSpecKey("Spectrum")]) then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_mult',
                    vars = { card.ability.extra.mult }
                },
                mult_mod = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
    key = "rainbow",
    name = "The Rainbow",
    atlas = 'jokers',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config =  { extra = {Xmult = 2.5}},
    in_pool = function()
        if (SMODS.Mods["Bunco"] or {}).can_load then
            return SPECF.spectrum_played()
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        local art = SPECF.config.joker_design.current_option
        if art == 1 then
            key = key.."_main"
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
                card.ability.extra.Xmult,
                localize('spectrum_Spectrum', 'poker_hands')
            }
        }
    end,
    update = function(self, card, dt)
        local art = SPECF.config.joker_design.current_option
        local jokerref = card.config.center
        jokerref.pos = {x = 2, y = 0}
        jokerref.soul_pos = nil
        if art == 1 then --Default art by CupertinoEffect
            jokerref.atlas = 'spectrum_jokers'
        elseif art == 2 then --Doodles by wingedcatgirl
            jokerref.atlas = 'spectrum_jokers-doodles'
            jokerref.soul_pos = jokerref.pos
            jokerref.pos = {
                x = 3,
                y = 0
            }
        elseif art == 3 then --Art by Aure from Six Suits
            jokerref.atlas = 'spectrum_jokers-sixsuits'
        elseif art == 4 then --Art by Peas from Bunco
            jokerref.atlas = 'spectrum_jokers-bunco'
        else --Fall back on default art 
            jokerref.atlas = 'spectrum_jokers'
        end

        if SPECF.config.joker_design.last_option[self.key] ~= SPECF.config.joker_design.current_option then
            SPECF.config.joker_design.last_option[self.key] = SPECF.config.joker_design.current_option
            card:set_sprites(jokerref)
        end
    end,
    set_badges = function (self, card, badges)
        local art = SPECF.config.joker_design.current_option
        if art == 3 then
            badges[#badges+1] = create_badge("Six Suits", DF509F, nil, 1.2)
        elseif art == 4 then
            badges[#badges+1] = create_badge("Bunco", G.C.GREEN, nil, 1.2)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[SPECF.getSpecKey("Spectrum")]) then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_xmult',
                    vars = { card.ability.extra.Xmult }
                },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
}

if (SMODS.Mods["Bunco"] or {}).can_load then -- suppress Bunco's Spectrum jokers if present 
    SMODS.Joker:take_ownership("j_bunc_zealous", {
        in_pool = function (self, args)
            return false
        end,
        no_collection = true
    })
    SMODS.Joker:take_ownership("j_bunc_lurid", {
        in_pool = function (self, args)
            return false
        end,
        no_collection = true
    })
    SMODS.Joker:take_ownership("j_bunc_dynasty", {
        in_pool = function (self, args)
            return false
        end,
        no_collection = true
    })
end