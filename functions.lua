---Debug messages
---@param message string Message to send
---@param level? string Log level, DEBUG by default, TRACE won't send unless dev mode is active since DebugPlus doesn't have that filter fsr
SPECF.say = function(message, level)
    if level == "TRACE" and not SPECF.config.dev_messages then
        return
    end
    message = message or "???"
    level = level or "DEBUG"
    while #level < 5 do
        level = level.." "
    end
    sendMessageToConsole(level, "Spectrum Framework", message)
end

---Checks if any Spectrum hand has been played; this includes spectra from other suits. Logic copied from Paperback.
---Also enables Bunco exotics if a spectrum has been played and they're somehow not already enabled.
---@return boolean
SPECF.spectrum_played = function()
    local spectrum_played = false
    if G and G.GAME and G.GAME.hands then
        for k, v in pairs(G.GAME.hands) do
            if string.find(k, "Spectrum", nil, true) or string.find(k, "Specflush", nil, true) then
                if G.GAME.hands[k].played > 0 then
                    spectrum_played = true
                    break
                end
            end
        end
    end

    if spectrum_played and (SMODS.Mods["Bunco"] or {}).can_load then
        if (exotic_in_pool and not exotic_in_pool())
        or (BUNCOMOD and BUNCOMOD.funcs and not BUNCOMOD.funcs.exotic_in_pool())
        then enable_exotics() end
    end

    return spectrum_played
end

---Gets the key with mod prefix for the spectrum hand that will score
---@param HandName string Name of the hand to check
---@return string lowest_key Key of the hand that will score
SPECF.getSpecKey = function(HandName)
    if not G.GAME then return SPECF.prefix.."_"..HandName end
    HandName = HandName or "Spectrum"
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

---Checks if Spectrum hands are easy to score for any reason
---@return boolean
SPECF.easy_spectra = function()
    if SPECF.config.spectra_are_standard then
        SPECF.say('Easy Spectra config option checked', "TRACE")
        return true
    end
    if G.GAME and G.GAME.starting_params.easy_spectra then
        SPECF.say('Deck defines Spectra as easy', "TRACE")
        return true
    end
    if SMODS.Mods.SixSuits and SMODS.Mods.SixSuits.can_load and SMODS.Mods.SixSuits.config.allow_all_suits then
        SPECF.say('SixSuits\'s all-suits config option checked', "TRACE")
        return true
    end
    if SMODS.Mods.draft and SMODS.Mods.draft.can_load then
        SPECF.say("Drafting", "TRACE")
        local count = 0
        for _ in pairs(G.FUNCS.not_hidden_suits()) do count = count + 1 end
        SPECF.say("Count == "..count, "TRACE")
        if count > 5 then
            SPECF.say("Lots of suits", "TRACE")
            return true
        end
    end
    local deckkey = G.GAME.selected_back.effect.center.key or "deck not found oopsie"
    local forceenhance = G.GAME.modifiers.cry_force_enhancement or "not found"
    SPECF.say("Deck key: "..deckkey, "TRACE")
    SPECF.say("Forced enhancement: "..forceenhance, "TRACE")
    if deckkey == "b_cry_et_deck" and forceenhance == "m_wild" then --Force lower values for this deck because it counts out of order
        SPECF.say("Cryptid all-wild deck detected", "TRACE")
        return true
    end
    if G.GAME.starting_params.diverse_deck == nil then
        SPECF.suit_diversity()
    end
    --[[if G.GAME.starting_params.diverse_deck then
        SPECF.say('Deck detected as diverse.', "TRACE")
    end]]
    SPECF.say('Nothing detected', "TRACE")
    return false
end

---Checks if a deck has easy access to five or more suits 
---@return boolean
SPECF.suit_diversity = function ()
    if G.GAME.starting_params.diverse_deck ~= nil then
        SPECF.say('Deck diversity already determined', "TRACE")
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
                SPECF.say('Deck contains at least 1 Wild Card', "TRACE")
            end]]
        elseif SMODS.has_no_suit(card) then
            stone_count = stone_count +1
            --[[if stone_count == 1 then
                SPECF.say('Deck contains at least 1 Stone Card', "TRACE")
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
            SPECF.say(suit..' contains '..count..' cards, counts as available', "TRACE")
        end
        if notthispercentage < domination_factor then
            suit_diversity_met = false
            SPECF.say(suit..' contains '..count..' cards, deck is '..suit..'-dominated', "TRACE")
        end
    end
    SPECF.say('Deck contains '..available_suits..' available suits.', "TRACE")
    if available_suits < 5 then
        suit_diversity_met = false
        SPECF.say('Deck is not suit diverse.', "TRACE")
    else
        SPECF.say('Deck is suit diverse.', "TRACE")
    end
    G.GAME.starting_params.diverse_deck = suit_diversity_met
    return G.GAME.starting_params.diverse_deck
end

---Moves hands in hand list
---@param handlist table G.handlist
---@param modded_positions table Table of the hands to move; details TBA because I don't know how to do this part
SPECF.reposition_modded_hands = function(handlist, modded_positions)
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

---Returns a table of suits currently in pool
---@return table
SPECF.in_pool_suits = function ()
    local ret = {}
    for key, value in pairs(SMODS.Suits) do
        if value.in_pool == nil or value:in_pool() then
            if allow_exotic or not value.exotic then
                ret[key] = value
            end
        end
    end
    return ret
end

---Reveals all hands; call this from DebugPlus if you want to 
---@param reverse boolean Set this to `true` to hide normally-hidden hands instead.
---@return boolean
SPECF.reveal_hands = function (reverse)
    for hand_name, hand_data in pairs(G.GAME.hands) do
        if reverse and SMODS.PokerHand.obj_table[hand_name] and (SMODS.PokerHand.obj_table[hand_name].visible == false) then
            hand_data.visible = false
        else
            hand_data.visible = true
        end
    end
    if reverse then 
        SPECF.say("Hidden hands unrevealed", "INFO ")
    else
        SPECF.say("All hands revealed", "INFO ")
    end
    return true
end

---Activates Bunco's exotic system, if you want to do this for some reason
SPECF.enable_exotics = function()
    if not G.GAME then return end
    G.GAME.Exotic = true
    SPECF.say('Attempted to enable Exotic System.', "TRACE")
end

---Deactivates Bunco's exotic system, if you want to do this for some reason
SPECF.disable_exotics = function()
    if not G.GAME then return end
    G.GAME.Exotic = false
    SPECF.say('Attempted to disable Exotic System.', "TRACE")
end

--[[ This happens before the rest of the run-start stuff
function SMODS.current_mod.reset_game_globals(start)
    
end
]]