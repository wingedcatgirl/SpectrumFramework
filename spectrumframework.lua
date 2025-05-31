SPECF = {
    prefix = SMODS.current_mod.prefix,
    config = SMODS.current_mod.config,
}

SPECF.config.planet_design.last_option = {} --
SPECF.config.joker_design.last_option = {}  --Clear these on boot to ensure everything works

SMODS.load_file("configui.lua")()

SMODS.load_file("atli.lua")()
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
    SPECF.say("Starting run", "TRACE")

    if SPECF.easy_spectra() and not args.savetext then
        SPECF.say('Lowering hand values', "TRACE")
        G.GAME.spectra_are_easy = true
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
                hand.s_mult = to_big(values.mult)
                hand.s_chips = to_big(values.chips)
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

    else
        if args.savetext then
            SPECF.say('Restoring saved run', "TRACE")
            if G.GAME.spectra_are_easy then
                SPECF.reposition_modded_hands(G.handlist, {
                    ["spectrum_Spectrum Five"] = {name = "Five of a Kind", position = "above"},
                    ["spectrum_Spectrum House"] = {name = "Four of a Kind", position = "above"},
                    ["spectrum_Straight Spectrum"] = {name = "Four of a Kind", position = "below"},
                    ["spectrum_Spectrum"] = {name = "Three of a Kind", position = "below"}
                })
                SPECF.say("Hands moved to lower positions", "TRACE")
            end
        else
            SPECF.reposition_modded_hands(G.handlist, { --Move back to default locations in case they've been lowered
                ["spectrum_Spectrum Five"] = {name = "Flush Five", position = "above"},
                ["spectrum_Spectrum House"] = {name = "Flush House", position = "above"},
                ["spectrum_Straight Spectrum"] = {name = "Straight Flush", position = "above"},
                ["spectrum_Spectrum"] = {name = "Full House", position = "above"}
            })
            SPECF.say('Hand values have not been modified for new run', "TRACE")
        end
    end
end

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
    return issuitref(self, suit, bypass_debuff, flush_calc)
end