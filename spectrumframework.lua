SMODS.Atlas {
    key = 'spectrumplaceholders',
    path = "placeholders.png",
    px = 71,
    py = 95
}

SPECF = {
    prefix = SMODS.current_mod.prefix,
    getSpecKey = function(HandName)
        if not G.GAME then return SPECF.prefix.."_"..HandName end
        local HandName = HandName or "Spectrum"
        local lowest_key = nil
        local lowest_order = math.huge
        local escaped_name = HandName:gsub("([^%w])", "%%%1")  -- escape magic chars

        local suffix_pattern = "_" .. escaped_name .. "$"

        for key, hand in pairs(G.GAME.hands) do
            if key:match(suffix_pattern) and type(hand.order) == "number" then
                if hand.order < lowest_order then
                    lowest_order = hand.order
                    lowest_key = key
                end
            end
        end
        return lowest_key
    end
}

local spectrum_config = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK},
        nodes = {
                    {n = G.UIT.C, config = {minw=0.5, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15},
                    nodes = {
                        create_toggle({
                            label = "Spectra are standard",
                            ref_table = spectrum_config,
                            ref_value = 'spectra_are_standard',
                                    }),
                        create_toggle({
                            label = "Smear modded suits",
                            ref_table = spectrum_config,
                            ref_value = 'smear_modded_suits',
                                    }),
                            }
                    },
                }
            }
end

easy_spectra = function()
    if spectrum_config.spectra_are_standard then
        --specSay('Easy Spectra config option checked')
        return true
    end
    if G.GAME.starting_params.easy_spectra then
        --specSay('Deck defines Spectra as easy')
        return true
    end
    if SMODS.Mods.SixSuits and SMODS.Mods.SixSuits.can_load and SMODS.Mods.SixSuits.config.allow_all_suits then
        --specSay('SixSuits\'s all-suits config option checked')
        return true
    end
    if SMODS.Mods.draft and SMODS.Mods.draft.can_load then
        --specSay("Drafting")
        local count = 0
        for _ in pairs(G.FUNCS.not_hidden_suits()) do count = count + 1 end
        --specSay("Count == "..count)
        if count > 5 then
            --specSay("Lots of suits")
            return true
        end
    end
    local deckkey = G.GAME.selected_back.effect.center.key or "deck not found oopsie"
    local forceenhance = G.GAME.modifiers.cry_force_enhancement or "not found"
    --specSay("Deck key: "..deckkey, "Spectrum")
    --specSay("Forced enhancement: "..forceenhance, "Spectrum")
    if deckkey == "b_cry_et_deck" and forceenhance == "m_wild" then --Force lower values for this deck because it counts out of order
        --specSay("Cryptid all-wild deck detected", "Spectrum")
        return true
    end
    if G.GAME.starting_params.diverse_deck == nil then
        suit_diversity()
    end
    --[[if G.GAME.starting_params.diverse_deck then
        specSay('Deck detected as diverse.')
    end]]
    --specSay('Nothing detected')
    return false
end

SPECF.in_pool_suits = function ()
    local ret = {}
    for key, value in pairs(SMODS.Suits) do
        if value.in_pool == nil or value.in_pool() then
            if allow_exotic or not value.exotic then
                ret[key] = value
            end
        end
    end
    return ret
end

function suit_diversity()
    if G.GAME.starting_params.diverse_deck ~= nil then
        --specSay('Deck diversity already determined')
        return G.GAME.starting_params.diverse_deck
    end
    local suit_counts = {}
    local wild_count = 0
    local stone_count = 0
    local total_count = #G.playing_cards

    for k, card in pairs(G.playing_cards) do
        if SMODS.has_any_suit(card) then
            wild_count = wild_count + 1
            --[[if wild_count == 1 then
                specSay('Deck contains at least 1 Wild Card')
            end]]
        elseif SMODS.has_no_suit(card) then
            stone_count = stone_count +1
            --[[if stone_count == 1 then
                specSay('Deck contains at least 1 Stone Card')
            end]]
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
            --specSay(suit..' contains '..count..' cards, counts as available')
        end
        if notthispercentage < domination_factor then
            suit_diversity_met = false
            --specSay(suit..' contains '..count..' cards, deck is '..suit..'-dominated')
        end
    end
    --specSay('Deck contains '..available_suits..' available suits.')
    if available_suits < 5 then
        suit_diversity_met = false
        --specSay('Deck is not suit diverse.')
    else
        --specSay('Deck is suit diverse.')
    end
    G.GAME.starting_params.diverse_deck = suit_diversity_met
    return G.GAME.starting_params.diverse_deck
end

--Talisman compatibility compatibility
to_big = to_big or function(x)
    return x
end

function reposition_modded_hands(handlist, modded_positions)
    -- Step 1: Extract modded hands from the list
    local extracted_hands = {}

    for i = #handlist, 1, -1 do
        for mod_hand, _ in pairs(modded_positions) do
            if handlist[i] == mod_hand then
                extracted_hands[mod_hand] = handlist[i]
                table.remove(handlist, i)
                break
            end
        end
    end

    -- Step 2: Reinsert modded hands at their target positions
    for mod_hand, target in pairs(modded_positions) do
        for i, hand in ipairs(handlist) do
            if hand == target.name then
                local insert_position = i + (target.position == "below" and 1 or 0)
                table.insert(handlist, insert_position, mod_hand)
                break
            end
        end
    end
end

function specSay(message, level)
    message = message or "???"
    level = level or "DEBUG"
    sendMessageToConsole(level, "Spectrum Framework", message)
end

function reveal_hands() -- debug function; call this from DebugPlus if you want to
    for _hand_name, hand_data in pairs(G.GAME.hands) do
        hand_data.visible = true
    end
    return true
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
            if not SMODS.has_any_suit(hand[i]) then
                for k, v in pairs(suits) do
                    if hand[i]:is_suit(k, nil, true) and v == 0 then
                        suits[k] = v + 1; break
                    end
                end
            end
        end
        local num_suits = 0
        for i = 1, #hand do
            if SMODS.has_any_suit(hand[i]) or hand[i].base.suit == "spectrum_fakewild" then
                num_suits = num_suits + 1
            end
        end
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
        --specSay('Lowering hand values')
        G.GAME.hands["spectrum_Spectrum"].visible = true
        local hand_adjustments = {
            ["spectrum_Spectrum"] = { mult = 3,  chips = 20,  l_mult = 3,  l_chips = 15 },
            ["spectrum_Straight Spectrum"] = { mult = 6,  chips = 60,  l_mult = 2,  l_chips = 35 },
            ["spectrum_Spectrum House"] = { mult = 7,  chips = 80,  l_mult = 4,  l_chips = 35 },
            ["spectrum_Spectrum Five"] =  { mult = 14, chips = 120, l_mult = 3,  l_chips = 40 },
        }

        for hand_name, values in pairs(hand_adjustments) do
            local hand = G.GAME.hands[hand_name]
            if hand then
                hand.mult = to_big(values.mult)
                hand.chips = to_big(values.chips)
                hand.l_mult = to_big(values.l_mult)
                hand.l_chips = to_big(values.l_chips)
            end
        end

        reposition_modded_hands(G.handlist, {
            ["spectrum_Spectrum Five"] = {name = "Five of a Kind", position = "above"},
            ["spectrum_Spectrum House"] = {name = "Four of a Kind", position = "above"},
            ["spectrum_Straight Spectrum"] = {name = "Four of a Kind", position = "below"},
            ["spectrum_Spectrum"] = {name = "Three of a Kind", position = "below"}
        })

        if (SMODS.Mods["Bunco"] or {}).can_load then
            G.GAME.hands["bunc_Spectrum"].visible = true
            G.GAME.hands["spectrum_Spectrum"].visible = false
            local bunco_hand_adjustments = {
                ["bunc_Spectrum"] = { mult = 3,  chips = 20,  l_mult = 3,  l_chips = 15 },
                ["bunc_Straight Spectrum"] = { mult = 6,  chips = 60,  l_mult = 2,  l_chips = 35 },
                ["bunc_Spectrum House"] = { mult = 7,  chips = 80,  l_mult = 4,  l_chips = 35 },
                ["bunc_Spectrum Five"] =  { mult = 14, chips = 120, l_mult = 3,  l_chips = 40 },
            }

            for hand_name, values in pairs(bunco_hand_adjustments) do
                local hand = G.GAME.hands[hand_name]
                if hand then
                    hand.mult = to_big(values.mult)
                    hand.chips = to_big(values.chips)
                    hand.l_mult = to_big(values.l_mult)
                    hand.l_chips = to_big(values.l_chips)
                end
            end

            reposition_modded_hands(G.handlist, {
                ["bunc_Spectrum Five"] = {name = "spectrum_Spectrum Five", position = "above"},
                ["bunc_Spectrum House"] = {name = "spectrum_Spectrum House", position = "above"},
                ["bunc_Straight Spectrum"] = {name = "spectrum_Straight Spectrum", position = "above"},
                ["bunc_Spectrum"] = {name = "spectrum_Spectrum", position = "above"},
            })
            reposition_modded_hands(G.handlist, {
                ["spectrum_Spectrum Five"] = {name = "High Card", position = "below"},
                ["spectrum_Spectrum House"] = {name = "High Card", position = "below"},
                ["spectrum_Straight Spectrum"] = {name = "High Card", position = "below"},
                ["spectrum_Spectrum"] = {name = "High Card", position = "below"},
            })
        end

    else
        if args.savetext then
            --specSay('Restoring saved run, hand values not modified')
        else
            reposition_modded_hands(G.handlist, { --Move back to default locations in case they've been lowered
                ["spectrum_Spectrum Five"] = {name = "Flush Five", position = "above"},
                ["spectrum_Spectrum House"] = {name = "Flush House", position = "above"},
                ["spectrum_Straight Spectrum"] = {name = "Straight Flush", position = "above"},
                ["spectrum_Spectrum"] = {name = "Full House", position = "above"}
            })
            if (SMODS.Mods["Bunco"] or {}).can_load then
                reposition_modded_hands(G.handlist, {
                    ["bunc_Spectrum Five"] = {name = "spectrum_Spectrum Five", position = "above"},
                    ["bunc_Spectrum House"] = {name = "spectrum_Spectrum House", position = "above"},
                    ["bunc_Straight Spectrum"] = {name = "spectrum_Straight Spectrum", position = "above"},
                    ["bunc_Spectrum"] = {name = "spectrum_Spectrum", position = "above"},
                })
            end
            --specSay('Hand values have not been modified for new run'. 'Spectrum')
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
    fake = true, --Other mods can reference this if they wanna

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


SMODS.Joker:take_ownership('smeared',{
    loc_vars = function(self)
        local key, vars

        if not spectrum_config.smear_modded_suits then
            key = self.key
        else
            key = self.key.."_alt"
        end

        return { key = key, vars = vars }
    end,
    locked_loc_vars = function(self, info_queue, card) --Make it not say 'nil nil'
        return {
            key = "j_smeared",
            vars = {
                G.P_CENTERS.j_smeared.unlock_condition.extra.count,
                localize{
                    type = 'name_text',
                    key = G.P_CENTERS.j_smeared.unlock_condition.extra.e_key,
                    set = 'Enhanced'
                    },
                },
            }
    end
}, true)

local issuitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if next(find_joker('Smeared Joker')) and spectrum_config.smear_modded_suits and not SMODS.has_no_suit(self) then
        if (self.base.suit ~= 'Spades' and self.base.suit ~= 'Clubs' and self.base.suit ~= 'Hearts' and self.base.suit ~= 'Diamonds') and (suit ~= 'Spades' and suit ~= 'Clubs' and suit ~= 'Hearts' and suit ~= 'Diamonds')  then
            return true
        end
    end
    if suit == "spectrum_fakewild" and self.base.suit ~= "spectrum_fakewild" and not SMODS.has_any_suit(self) then
        return false
    end
    return issuitref(self, suit, bypass_debuff, flush_calc)
end