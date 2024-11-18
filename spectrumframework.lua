SMODS.Atlas {
    key = 'spectrumplaceholders',
    path = "placeholders.png",
    px = 71,
    py = 95
}


--Code copied from Bunco, which referenced it from SixSuits.

SMODS.PokerHandPart{ -- Spectrum base
    key = 'spectrum',
    func = function(hand)
        local suits = {}
        for _, v in ipairs(SMODS.Suit.obj_buffer) do
            suits[v] = 0
        end
        if #hand < 5 then return {} end
        for i = 1, #hand do
            if hand[i].ability.name ~= 'Wild Card' then
                for k, v in pairs(suits) do
                    if hand[i]:is_suit(k, nil, true) and v == 0 then
                        suits[k] = v + 1; break
                    end
                end
            end
        end
        for i = 1, #hand do
            if hand[i].ability.name == 'Wild Card' then
                for k, v in pairs(suits) do
                    if hand[i]:is_suit(k, nil, true) and v == 0 then
                        suits[k] = v + 1; break
                    end
                end
            end
        end
        local num_suits = 0
        for _, v in pairs(suits) do
            if v > 0 then num_suits = num_suits + 1 end
        end
        return (num_suits >= 5) and {hand} or {}
    end
}

SMODS.PokerHand{ -- Spectrum
    key = 'Spectrum',
    visible = false,
    chips = 50,
    mult = 6,
    l_chips = 25,
    l_mult = 3,
    example = {
        { 'S_2',    true },
        { 'D_7',    true },
        { 'C_3', true },
        { 'spectrum_fakewild_5', true },
        { 'H_K',    true },
    },
    loc_txt =  	{
        name = 'Spectrum',
        description = { '5 cards with different suits' },
    },
    evaluate = function(parts)
        return parts.spectrum_spectrum
    end
}

SMODS.PokerHand{ -- Straight Spectrum
    key = 'Straight Spectrum',
    visible = false,
    chips = 120,
    mult = 10,
    l_chips = 35,
    l_mult = 5,
    example = {
        { 'S_Q',    true },
        { 'spectrum_fakewild_J', true },
        { 'C_T',    true },
        { 'D_9', true },
        { 'H_8',    true }
    },
    loc_txt =  	{
        name = 'Straight Spectrum',
        extra = 'Royal Spectrum',
        description = { '5 cards in a row (consecutive ranks),',
                        'each with a different suit' },
    },
    process_loc_text = function(self)
        SMODS.PokerHand.process_loc_text(self)
        SMODS.process_loc_text(G.localization.misc.poker_hands, self.key..'_2', self.loc_txt, 'extra')
    end,
    evaluate = function(parts)
        if not next(parts.spectrum_spectrum) or not next(parts._straight) then return {} end
        return { SMODS.merge_lists (parts.spectrum_spectrum, parts._straight) }
    end,
    modify_display_text = function(self, _cards, scoring_hand)
        local royal = true
		for j = 1, #scoring_hand do
			local rank = SMODS.Ranks[scoring_hand[j].base.value]
			royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
		end
		if royal then
			return self.key..'_2'
		end
    end
}

SMODS.PokerHand{ -- Spectrum House
    key = 'Spectrum House',
    above_hand = 'Flush House',
    visible = false,
    chips = 150,
    mult = 15,
    l_chips = 50,
    l_mult = 5,
    example = {
        { 'S_Q',    true },
        { 'spectrum_fakewild_Q', true },
        { 'C_Q',    true },
        { 'D_8',    true },
        { 'H_8',    true }
    },
    loc_txt =  	{
        name = 'Spectrum House',
        description = { 'A Three of a Kind and a Pair with',
                        'each card having a different suit' },
    },
    evaluate = function(parts)
        if #parts._3 < 1 or #parts._2 < 2 or not next(parts.spectrum_spectrum) then return {} end
        return {SMODS.merge_lists (parts._all_pairs, parts.spectrum_spectrum)}
    end
}

SMODS.PokerHand{ -- Spectrum Five
    key = 'Spectrum Five',
    above_hand = 'Flush Five',
    visible = false,
    chips = 180,
    mult = 18,
    l_chips = 60,
    l_mult = 5,
    example = {
        { 'S_7',    true },
        { 'D_7', true },
        { 'spectrum_fakewild_7',    true },
        { 'H_7',    true },
        { 'C_7',    true }
    },
    loc_txt =  	{
        name = 'Spectrum Five',
        description = { '5 cards with the same rank,',
                        'each with a different suit' },
        }, 
    evaluate = function(parts)
        if not next(parts._5) or not next(parts.spectrum_spectrum) then return {} end
        return {SMODS.merge_lists (parts._5, parts.spectrum_spectrum)}
    end
}


NFS.load(SMODS.current_mod.path .. 'planets.lua')()
--NFS.load(SMODS.current_mod.path .. 'jokers.lua')()

SMODS.Atlas {
    key = 'fakewild_lc',
    path = "fakewild_lc.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = 'fakewild_hc',
    path = "fakewild_hc.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'fakewild_icon',
    path = "fakewild_icon.png",
    px = 18,
    py = 18
}

SMODS.Suit{ -- Fake wild card for the demonstration
    key = 'fakewild',
    card_key = 'fakewild',
    hidden = true,

    lc_atlas = 'fakewild_lc',
    hc_atlas = 'fakewild_hc',

    lc_ui_atlas = 'fakewild_icon',
    hc_ui_atlas = 'fakewild_icon',

    pos = { x = 0, y = 0 },
    ui_pos = { x = 0, y = 0 },

    lc_colour = HEX('86B723'),
    hc_colour = HEX('86B723'),

    loc_txt = 
         {
            ['en-us'] = {
                singular = 'fake wild',
                plural = 'fake wilds',
         }
    },

    in_pool = function(self, args)
        return false
    end
}