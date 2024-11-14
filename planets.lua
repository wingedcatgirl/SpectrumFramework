SMODS.Consumable{ -- Rainbow Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplaceholders',
    key = 'RainbowPlanet',
    name = "Rainbow Planet",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = 
    {
        ['en-us'] = {
            ['name'] = 'Rainbow Planet'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet???", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=0, y=2},
    soul_pos = {x=1, y=2},
}

SMODS.Consumable{ -- House Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplaceholders',
    key = 'HousePlanet',
    name = "House Planet",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum House', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = 
    {
        ['en-us'] = {
            ['name'] = 'House Planet'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet???", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=0, y=2},
    soul_pos = {x=2, y=2},
}

SMODS.Consumable{ -- Line Planet
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplaceholders',
    key = 'LinePlanet',
    name = "Line Planet",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Straight Spectrum', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = 
    {
        ['en-us'] = {
            ['name'] = 'Line Planet'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planet???", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=0, y=2},
    soul_pos = {x=3, y=2},
}

SMODS.Consumable{ -- Planet Cluster
    set = 'Planet',
    cost = 3,
    unlocked = true,
    discovered = true,
    atlas = 'spectrumplaceholders',
    key = 'PlanetCluster',
    name = "Planet Cluster",
    effect = 'Hand Upgrade',
    config = {hand_type = 'spectrum_Spectrum Five', softlock = true},
    process_loc_text = function(self)
        --use another planet's loc txt instead
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    loc_txt = 
    {
        ['en-us'] = {
            ['name'] = 'Planet Cluster'
        },
    },
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge("Planets???", get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
    pos = {x=0, y=2},
    soul_pos = {x=4, y=2},
}