G.FUNCS.specf_artcycle = function(args)
    local refval = args.cycle_config.ref_value
    SPECF.config[refval].current_option=args.cycle_config.current_option
    SPECF.config[refval].option_value = args.to_val
end

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tl", padding = 0.2, colour = G.C.BLACK},
        nodes = {
                    {n = G.UIT.C, config = {minw=0.5, minh=1, align = "tl", colour = G.C.CLEAR, padding = 0.15},
                    nodes = {
                        create_toggle({
                            label = "Spectra are standard",
                            ref_table = SPECF.config,
                            ref_value = 'spectra_are_standard',
                                    }),
                        create_toggle({
                            label = "Specflush hand",
                            ref_table = SPECF.config,
                            ref_value = 'specflush',
                                    }),
                        create_toggle({
                            label = "Smear modded suits",
                            ref_table = SPECF.config,
                            ref_value = 'smear_modded_suits',
                                    }),
                        create_toggle({
                            label = "Dev messages",
                            ref_table = SPECF.config,
                            ref_value = 'dev_messages',
                                    }),
                        create_option_cycle {
                            label = "Joker Design",
                            options = {'CupertinoEffect (Default)', 'wingedcatgirl (Doodles)', 'Aure (Six Suits)', 'Peas (Bunco)'},
                            current_option = SPECF.config.joker_design.current_option,
                            ref_table = SPECF.config,
                            ref_value = "joker_design",
                            opt_callback = 'specf_artcycle',
                            w = 5.5
                            },
                        create_option_cycle {
                            label = "Planet Design",
                            options = {'CupertinoEffect (Default)', 'wingedcatgirl (Doodles)', 'Shinku+Reiji (Six Suits)', 'Firch (Bunco)'},
                            current_option = SPECF.config.planet_design.current_option,
                            ref_table = SPECF.config,
                            ref_value = "planet_design",
                            opt_callback = 'specf_artcycle',
                            w = 5.5
                            },
                        },
                    },
                }
            }
end