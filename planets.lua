-- LOCALIZATION NOTE: idk how it works (the relevant code is pulled from Cryptid) but all of these just modify Mercury instead of having their own text.

SMODS.Atlas {
    key = 'spectrumplanets',
    path = "planets.png",
    px = 71,
    py = 95
}

SMODS.Consumable{ -- Vulcan/Rainbow Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    key = 'Vulcan',
    name = "Vulcan",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = {
        ['en-us'] = {
            ['name'] = 'Vulcan'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=0, y=0},
}

SMODS.Consumable{ -- Nibiru/House Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    key = 'Nibiru',
    name = "Nibiru",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum House', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = {
        ['en-us'] = {
            ['name'] = 'Nibiru'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=2, y=0},
}

SMODS.Consumable{ -- Phaeton/Line Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    key = 'Phaeton',
    name = "Phaeton",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Straight Spectrum', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = {
        ['en-us'] = {
            ['name'] = 'Phaeton'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=1, y=0},
}

SMODS.Consumable{ -- Yuggoth/Planet Cluster
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplanets',
    key = 'Yuggoth',
    name = "Yuggoth",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum Five', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = {
        ['en-us'] = {
            ['name'] = 'Yuggoth'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=3, y=0},
}