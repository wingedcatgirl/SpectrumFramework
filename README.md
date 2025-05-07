# SpectrumFramework
A mod for Balatro that adds Spectrum hands (five cards, each of a different suit), for use alongside mods that add suits.

Does _not_ add any additional suits of its own.[^1] If you install this mod by itself, playing Spectrum hands will require the use of Wild cards. But hey, maybe that's something you want to do.

Also allows Smeared Joker to make all modded suits count as the same suit, if you want to do that.

<details>
  <summary>Config Options</summary>
<ul>
<li>Spectra are Standard: Default false. Forces lower-scoring values for Spectrum hands, and shows base Spectrum hand in Run Info immediately. Recommended if you are using many mods which add custom suits.</li>
<li>Smear modded suits: Default false. Modifies Smeared Joker to also make all modded suits count as each other. Recommended if you think this sounds like a fun idea.</li>
<li>Dev messages: Sends trace-level dev messages to the console. If you don't know what this means, it's not relevant to you.</li>
<li>Joker and Planet designs: WIP</li>
</ul>
</details> 

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
Disabling Spectrum Framework mid-run will probably crash your game when you continue. Generally speaking, you should start a new run when your mod loadout changes in any way.

## Attribution
- A lot of this code came from [Bunco](https://github.com/Firch/Bunco), which in turn got it from [Six Suits](https://github.com/lshtech/SixSuits).
- Joker and planet art [by CupertinoEffect](https://github.com/wingedcatgirl/SpectrumFramework/issues/1)

## Compatibility
The following mods implement Spectrum themself but ensure non-redundancy on their end, so there's no problem loading them together:
- Paperback
- Six Suits

The following mod~~s~~ have not been tested for bugs or anything but will load alongside Spectrum Framework anyway, so [tell us](https://github.com/wingedcatgirl/SpectrumFramework/issues) and/or them if something weird happens:
- Bunco

[^1]: Okay technically it adds a fake wild suit to demonstrate the Spectrum hands. But you shouldn't actually see that in gameplay.