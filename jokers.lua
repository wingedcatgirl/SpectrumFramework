SMODS.Joker {
    key = "rainbow",
    name = "The Rainbow",
    atlas = 'spectrumplaceholders',
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 5,
        y = 0
    },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config =  { extra = {Xmult = 2.5, type = 'spectrum_Spectrum'}},
    loc_txt = {
        name = "",
        text = {"{X:mult,C:white} X#1# {} Mult if played",
                "hand contains",
                "a {C:attention}#2#"}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult, card.ability.extra.type}
        }
    end,
        calculate = function(self, card, context)
            if context.joker_main and next(context.poker_hands['spectrum_Spectrum']) then
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
}