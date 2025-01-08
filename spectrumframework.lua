SMODS.Atlas {
    key = 'spectrumplaceholders',
    path = "placeholders.png",
    px = 71,
    py = 95
}

local spectrum_config = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {minw=1, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15}, nodes = {
        create_toggle({
            label = "Spectra are standard",
            ref_table = spectrum_config,
            ref_value = 'spectra_are_standard',
        }),
        {n = G.UIT.T, config = {colour = G.C.WHITE, padding = 0, text = "Check this if you have\n*many* custom suit mods\nand expect Spectra to be\neasy to score regardless\nof starting deck.\n\nSpectrum hands will be visible\nin Run Info from the start\nand have lower score values.", scale = 0.3}},
        }}
    }}
end


easy_spectra = function()
    if spectrum_config.spectra_are_standard then 
        --sendDebugMessage('[Spectrum Framework] Easy Spectra config option checked')
        return true
    end
    if G.GAME.starting_params.easy_spectra then 
        --sendDebugMessage('[Spectrum Framework] Deck defines Spectra as easy')
        return true 
    end
    if G.GAME.starting_params.diverse_deck == nil then
        suit_diversity()
    end
    if G.GAME.starting_params.diverse_deck then
        --sendDebugMessage('[Spectrum Framework] Deck detected as diverse.')
    end
    --sendDebugMessage('[Spectrum Framework] Nothing detected')
    return false
end

function suit_diversity()
    if G.GAME.starting_params.diverse_deck ~= nil then
        --sendDebugMessage('Deck diversity already determined')
        return G.GAME.starting_params.diverse_deck
    end
    local suit_counts = {}
    local wild_count = 0
    local stone_count = 0
    local total_count = #G.playing_cards

    for k, card in pairs(G.playing_cards) do
        if card.ability.name == 'Wild Card' then 
            wild_count = wild_count + 1
            if wild_count == 1 then
                --sendDebugMessage('[Spectrum Framework] Deck contains at least 1 Wild Card')
            end
        elseif card.ability.name == 'Stone Card' then
            stone_count = stone_count +1
            if stone_count == 1 then
                --sendDebugMessage('[Spectrum Framework] Deck contains at least 1 Stone Card')
            end
        else
            local suit = card.base.suit
            suit_counts[suit] = (suit_counts[suit] or 0) + 1
        end
    end

    local suit_diversity_met = true
    local available_suits = 0
    local available_factor = 1/8
    local domination_factor = 1/3
    for suit, count in pairs(suit_counts) do
        local thispercentage = (count+wild_count) / total_count
        local notthispercentage = (total_count - (count+stone_count)) / total_count
        if thispercentage > available_factor then
            available_suits = available_suits + 1
            --sendDebugMessage('[Spectrum Framework] '..suit..' contains '..count..' cards, counts as available')
        end
        if notthispercentage < domination_factor then
            suit_diversity_met = false
            --sendDebugMessage('[Spectrum Framework] '..suit..' contains '..count..' cards, deck is '..suit..'-dominated')
        end        
    end
    --sendDebugMessage('[Spectrum Framework] Deck contains '..available_suits..' available suits.')
    if available_suits < 5 then
        suit_diversity_met = false
        --sendDebugMessage('[Spectrum Framework] Deck is not suit diverse.')
    else
        --sendDebugMessage('[Spectrum Framework] Deck is suit diverse.')
    end
    G.GAME.starting_params.diverse_deck = suit_diversity_met
    return G.GAME.starting_params.diverse_deck
end


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
            if hand[i].ability.name == 'Wild Card' or hand[i].base.suit == "spectrum_fakewild" then
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
    evaluate = function(parts)
        if not next(parts._5) or not next(parts.spectrum_spectrum) then return {} end
        return {SMODS.merge_lists (parts._5, parts.spectrum_spectrum)}
    end
}

local GameStartRef = Game.start_run
function Game:start_run(args)
    GameStartRef(self, args)

    if easy_spectra() and not args.savetext then
        --sendDebugMessage('[Spectrum Framework] Lowering hand values')
        G.GAME.hands["spectrum_Spectrum"].visible = true
        G.GAME.hands["spectrum_Spectrum"].mult = 3
        G.GAME.hands["spectrum_Spectrum"].chips = 20
        G.GAME.hands["spectrum_Spectrum"].l_mult = 3
        G.GAME.hands["spectrum_Spectrum"].l_chips = 15

        G.GAME.hands["spectrum_Straight Spectrum"].visible = true
        G.GAME.hands["spectrum_Straight Spectrum"].mult = 6
        G.GAME.hands["spectrum_Straight Spectrum"].chips = 60
        G.GAME.hands["spectrum_Straight Spectrum"].l_mult = 2
        G.GAME.hands["spectrum_Straight Spectrum"].l_chips = 35

        G.GAME.hands["spectrum_Spectrum House"].visible = true
        G.GAME.hands["spectrum_Spectrum House"].mult = 7
        G.GAME.hands["spectrum_Spectrum House"].chips = 80
        G.GAME.hands["spectrum_Spectrum House"].l_mult = 4
        G.GAME.hands["spectrum_Spectrum House"].l_chips = 35

        G.GAME.hands["spectrum_Spectrum Five"].visible = true
        G.GAME.hands["spectrum_Spectrum Five"].mult = 14
        G.GAME.hands["spectrum_Spectrum Five"].chips = 120
        G.GAME.hands["spectrum_Spectrum Five"].l_mult = 3
        G.GAME.hands["spectrum_Spectrum Five"].l_chips = 40
    else
        if args.savetext then
            --sendDebugMessage('[Spectrum Framework] Restoring saved run, hand values not modified')
        else
            --sendDebugMessage('[Spectrum Framework] Hand values have not been modified for new run')
        end
    end
end


NFS.load(SMODS.current_mod.path .. 'planets.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers.lua')()

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


    in_pool = function(self, args)
        return false
    end
}


SMODS.Joker:take_ownership('smeared',
    { name = "Smeared Joker Fixed" }, --use modded smearing logic
    true 
)

local issuitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if next(find_joker('Smeared Joker Fixed')) then
        if (self.base.suit == 'Hearts' or self.base.suit == 'Diamonds') and (suit == 'Hearts' or suit == 'Diamonds') then
        return true
        end
        if (self.base.suit == 'Spades' or self.base.suit == 'Clubs') and (suit == 'Spades' or suit == 'Clubs') then
        return true
        end
    end
    if suit == "spectrum_fakewild" and self.base.suit ~= "spectrum_fakewild" then
        return false
    elseif self.base.suit == "spectrum_fakewild" then
        return true
    end
    return issuitref(self, suit, bypass_debuff, flush_calc)
end