# SpectrumFramework
A mod for Balatro that adds Spectrum hands (five cards, each of a different suit), for use alongside mods that add suits.

Does _not_ add any additional suits of its own.[^1] If you install this mod by itself, playing Spectrum hands will require the use of Wild cards. But hey, maybe that's something you want to do.

If your mod does anything with Smeared Joker, be aware that [we've changed its internal name](https://github.com/wingedcatgirl/SpectrumFramework/blob/b309a9c6f4ca43ef449c9d687a06043c0b5e1f06/spectrumframework.lua#L315) and slightly changed its logic.

## Things done:
- The hands
- Planets for the hands
- Jokers for the hands
- Alternate lower score values for decks that make Spectra very easy to build (e.g. Cryptid's The Lovers deck, or a deck that starts with five or more suits)
  - If your mod has a deck that should use these lower score values, have it set `G.GAME.starting_params.easy_spectra` to true. (Example: [Deck with a Treat](https://github.com/wingedcatgirl/MintysSillyMod/blob/b2c926aef8fca1a08b2a29ac98c0e433363681c4/backs/backs.lua#L11) from Minty's Silly Little Mod)
  - The mod will also try to count suits at the beginning of the run, but it's known to have some issues currently (e.g. with Cryptid's The Lovers deck)

## Things planned to probably do
- Fix the suit-counting thing

## Things planned to possibly do
- Config option to switch between joker and planet versions (in case anyone really prefers a specific one)

## Warning
Disabling Spectrum Framework mid-run will probably crash your game. Generally speaking, you should start a new run when your mod loadout changes in any way.

## Attribution
- A lot of this code came from [Bunco](https://github.com/Firch/Bunco), which in turn got it from [Six Suits](https://github.com/lshtech/SixSuits).
- Joker and planet art [by CupertinoEffect](https://github.com/wingedcatgirl/SpectrumFramework/issues/1)

## Compatibility
Will not load alongside the following mods, as they implement Spectrum themself so it would be redundant:
- Bunco

The following mods implement Spectrum themself but ensure non-redundancy on their end:
- Six Suits

[^1]: Okay technically it adds a fake wild suit to demonstrate the Spectrum hands. But you shouldn't actually see that in gameplay.