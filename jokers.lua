SMODS.Atlas { --Art by CupertinoEffect
    key = 'spectrumjokers',
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "pensive",
    name = "Pensive Joker",
    atlas = 'spectrumjokers',
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
            return false
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.chips, localize('spectrum_Spectrum', 'poker_hands')}
        }
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
    atlas = 'spectrumjokers',
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
            return false
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, localize('spectrum_Spectrum', 'poker_hands')}
        }
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
    atlas = 'spectrumjokers',
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
            return false
        end
        return true
    end,
    loc_vars = function(self, info_queue, card)
        local key = self.key
        SPECF.say(key)
        return {
            vars = {card.ability.extra.Xmult, localize('spectrum_Spectrum', 'poker_hands')}
        }
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