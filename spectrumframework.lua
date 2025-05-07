SMODS.Atlas {
    key = 'spectrumplaceholders',
    path = "placeholders.png",
    px = 71,
    py = 95
}

SPECF = {
    prefix = SMODS.current_mod.prefix,
    config = SMODS.current_mod.config
}

SMODS.load_file("configui.lua")()

SMODS.load_file("functions.lua")()
SMODS.load_file("hands.lua")()
SMODS.load_file("planets.lua")()
SMODS.load_file("jokers.lua")()

--Talisman compatibility compatibility
to_big = to_big or function(x)
    return x
end

local GameStartRef = Game.start_run
function Game:start_run(args)
    GameStartRef(self, args)

    if SPECF.easy_spectra() and not args.savetext then
        SPECF.say('Lowering hand values', "TRACE")
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

        SPECF.reposition_modded_hands(G.handlist, {
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

            SPECF.reposition_modded_hands(G.handlist, {
                ["bunc_Spectrum Five"] = {name = "spectrum_Spectrum Five", position = "above"},
                ["bunc_Spectrum House"] = {name = "spectrum_Spectrum House", position = "above"},
                ["bunc_Straight Spectrum"] = {name = "spectrum_Straight Spectrum", position = "above"},
                ["bunc_Spectrum"] = {name = "spectrum_Spectrum", position = "above"},
            })
        end

    else
        if args.savetext then
            SPECF.say('Restoring saved run, hand values not modified', "TRACE")
        else
            SPECF.reposition_modded_hands(G.handlist, { --Move back to default locations in case they've been lowered
                ["spectrum_Spectrum Five"] = {name = "Flush Five", position = "above"},
                ["spectrum_Spectrum House"] = {name = "Flush House", position = "above"},
                ["spectrum_Straight Spectrum"] = {name = "Straight Flush", position = "above"},
                ["spectrum_Spectrum"] = {name = "Full House", position = "above"}
            })
            if (SMODS.Mods["Bunco"] or {}).can_load then
                SPECF.reposition_modded_hands(G.handlist, {
                    ["bunc_Spectrum Five"] = {name = "spectrum_Spectrum Five", position = "above"},
                    ["bunc_Spectrum House"] = {name = "spectrum_Spectrum House", position = "above"},
                    ["bunc_Straight Spectrum"] = {name = "spectrum_Straight Spectrum", position = "above"},
                    ["bunc_Spectrum"] = {name = "spectrum_Spectrum", position = "above"},
                })
            end
            SPECF.say('Hand values have not been modified for new run', "TRACE")
        end
    end
end

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
    fake = true, --Other mods can reference this if they want to exclude fake suits for any reason. Which they probably should.

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

        if not SPECF.config.smear_modded_suits then
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
    if next(find_joker('Smeared Joker')) and SPECF.config.smear_modded_suits and not SMODS.has_no_suit(self) then
        if (self.base.suit ~= 'Spades' and self.base.suit ~= 'Clubs' and self.base.suit ~= 'Hearts' and self.base.suit ~= 'Diamonds') and (suit ~= 'Spades' and suit ~= 'Clubs' and suit ~= 'Hearts' and suit ~= 'Diamonds')  then
            return true
        end
    end
    if suit == "spectrum_fakewild" and self.base.suit ~= "spectrum_fakewild" and not SMODS.has_any_suit(self) then
        return false
    end
    return issuitref(self, suit, bypass_debuff, flush_calc)
end