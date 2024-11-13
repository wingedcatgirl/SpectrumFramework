SMODS.Consumable{ -- Quaoar
    set = 'Planet',
    atlas = 'spectrumplaceholders',
    key = 'Rainbow Planet',
    effect = 'Hand Upgrade',
    loc_txt = 
    {
        ['en-us'] = {
            ['name'] = 'Rainbow Planet',
            ['text'] = {
                [1] = "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                [2] = "{C:attention}#2#",
                [3] = "{C:mult}+#3#{} Mult and",
                [4] = "{C:chips}+#4#{} chips",
            }
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end,

    config = {hand_type = 'spectrum_Spectrum', softlock = true},
    pos = coordinate(1),
}