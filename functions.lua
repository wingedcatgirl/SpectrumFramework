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
    if G.GAME.spectrum_status then
        return (G.GAME.spectrum_status == 1)
    end
    if SPECF.config.spectrum_status.current_option == 1 then
        if G and G.GAME then
            G.GAME.spectrum_status = 1
        end
        SPECF.say('Spectrum Score Status: Standard', "TRACE")
        return true
    elseif SPECF.config.spectrum_status.current_option == 3 then
        if G and G.GAME then
            G.GAME.spectrum_status = 3
        end
        SPECF.say('Spectrum Score Status: Special', "TRACE")
        return false
    end
    if G.GAME and G.GAME.starting_params.easy_spectra then
        if G and G.GAME then
            G.GAME.spectrum_status = 1
        end
        SPECF.say('Deck defines Spectra as easy', "TRACE")
        return true
    end
    if SMODS.Mods.SixSuits and SMODS.Mods.SixSuits.can_load and SMODS.Mods.SixSuits.config.allow_all_suits then
        if G and G.GAME then
            G.GAME.spectrum_status = 1
        end
        SPECF.say('SixSuits\'s all-suits config option checked', "TRACE")
        return true
    end
    if SMODS.Mods.draft and SMODS.Mods.draft.can_load then
        SPECF.say("Drafting", "TRACE")
        local count = 0
        for _ in pairs(SPECF.in_pool_suits()) do count = count + 1 end
        SPECF.say("Count == "..count, "TRACE")
        if count > 5 then
            if G and G.GAME then
               G.GAME.spectrum_status = 1
            end
            SPECF.say("Lots of suits", "TRACE")
            return true
        end
    end
    local deckkey = G.GAME.selected_back.effect.center.key or "deck not found oopsie"
    local forceenhance = G.GAME.modifiers.cry_force_enhancement or "not found"
    SPECF.say("Deck key: "..deckkey, "TRACE")
    SPECF.say("Forced enhancement: "..forceenhance, "TRACE")
    if deckkey == "b_cry_et_deck" and forceenhance == "m_wild" then --Force lower values for this deck because it counts out of order
        if G and G.GAME then
            G.GAME.spectrum_status = 1
        end
        SPECF.say("Cryptid all-wild deck detected", "TRACE")
        return true
    end
    if G.GAME.starting_params.diverse_deck == nil then
        local diversity = SPECF.suit_diversity()
        G.GAME.spectrum_status = diversity and 1 or 3
        return diversity
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
        if value.in_pool == nil or value:in_pool({}) then
            ret[key] = value
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

---Levels Specflush hands to average of equivalent Spectrum and Flush hands
---Called after calculating context.before and context.after (TODO maybe: add context.using_consumeable?)
SPECF.specflush_sync = function ()
    if not SPECF.config.specflush then return end
    local hands = {
        "Specflush", "Straight Specflush", "Specflush House", "Specflush Five"
    }
    for _,specflush in ipairs(hands) do
        local flush = string.gsub(specflush,"Specflush", "Flush")
        local spec = string.gsub(specflush,"Specflush", "Spectrum")
        local sflev = 0
        local flev = 0
        local slev = 0
        for key, hand in pairs(G.GAME.hands) do
            local level = to_number(hand.level)
            --SPECF.say("Hand key is "..key, "TRACE")
            if key == SPECF.prefix.."_"..specflush then
                --SPECF.say(key.." is level "..level, "TRACE")
                sflev = math.max(sflev,level)
            end
            if key == flush --[[All Flush hands are vanilla iirc and so won't have a prefix]] then
                --SPECF.say(key.." is level "..level, "TRACE")
                flev = math.max(flev,level)
            end
            if key:match("_"..spec.."$") then
                --SPECF.say(key.." is level "..level, "TRACE")
                slev = math.max(slev,level)
            end
        end
        --SPECF.say("Levels calculated:", "TRACE")
        --SPECF.say(flush.." is level "..flev, "TRACE")
        --SPECF.say(spec.." is level "..slev, "TRACE")
        --SPECF.say(specflush.." is level "..sflev, "TRACE")
        local diff = math.ceil((slev+flev)/2 - sflev)
        if diff > 0 then
                SMODS.smart_level_up_hand(nil, SPECF.prefix.."_"..specflush, true, diff)
        else
            --SPECF.say("No imbalance found with "..flush.."+"..spec.." against "..specflush, "TRACE")
        end
    end

    --G.GAME.hands[hand].level 
end

---Gets the planet associated with a hand.
---Hands with a defined planet get that planet.
---Specflush hands get the corresponding Spectrum or Flush planet at random.
---Anything else gets a totally random planet.
---@param hand string Key of the hand to check
---@return string key Key of the selected planet card
SPECF.getPlanet = function(hand)
    hand = hand or G.GAME.last_hand_played
    if not hand then return "c_mercury" end
    local planet
    if SMODS.PokerHand.obj_table[hand] and SMODS.PokerHand.obj_table[hand].planet then
        if type(SMODS.PokerHand.obj_table[hand].planet) == "string" then
            return SMODS.PokerHand.obj_table[hand].planet
        elseif type(SMODS.PokerHand.obj_table[hand].planet) == "table" then
            planet = pseudorandom_element(SMODS.PokerHand.obj_table[hand].planet, pseudoseed("handplanet"))
            if type(planet) == "string" then
                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.key == planet then
                        return planet
                    end
                end
            end
        end
    end
    planet = nil

    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
        if v.config.hand_type == hand then
            return v.key
        end
    end

    local flush = hand:gsub("spectrum_", ""):gsub("Specflush", "Flush")
    local spectrum = hand:gsub("Specflush", "Spectrum")
    local flushplanet
    local specplanet
    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
        if v.config.hand_type == flush then
            flushplanet = v.key
        elseif v.config.hand_type == spectrum then
            specplanet = v.key
        end
    end

    if flushplanet and specplanet then
        planet = pseudorandom_element({flushplanet, specplanet}, pseudoseed("get_specflush_planet"))
    else
        planet = pseudorandom_element(G.P_CENTER_POOLS.Planet, pseudoseed("get_random_planet")).key
        local hand2 = G.P_CENTERS[planet] and G.P_CENTERS[planet].config and G.P_CENTERS[planet].config.hand_type
        while not (G.GAME.hands[hand2] and G.GAME.hands[hand2].visible) do
            local i = (i or 0)+1
            planet = pseudorandom_element(G.P_CENTER_POOLS.Planet, pseudoseed("get_random_planet")).key
            hand2 = G.P_CENTERS[planet] and G.P_CENTERS[planet].config.hand_type
            if i > 100 then SPECF.say("getPlanet got stuck in a loop!", "ERROR") break end
        end
    end

    return planet
end

--[[ This happens before the rest of the run-start stuff
function SMODS.current_mod.reset_game_globals(start)
    
end
]]