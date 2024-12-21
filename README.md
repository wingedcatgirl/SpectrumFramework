# SpectrumFramework
A mod for Balatro that adds Spectrum hands (five cards, each of a different suit), for use alongside mods that add suits.

Does _not_ add any additional suits of its own.[^1] If you install this mod by itself, playing Spectrum hands will require the use of Wild cards. But hey, maybe that's something you want to do.



Probably don't use this with mods that already add Spectrum hands! I don't know what will happen if you do that! I'd put them in the .json as conflicts but that stops them from even being installed, including if you turn them off, which seems weird and inconvenient.

## Things done:
- The hands
- Planets for the hands
- Alternate lower score values for decks that make Spectra very easy to build (e.g. Cryptid's The Lovers deck, or a deck that starts with five or more suits)
  - If your mod has a deck that should use these lower score values, have it set `G.GAME.starting_params.easy_spectra` to true. [TODO: link an example]

## Things planned to probably do
- Jokers for the hands
- Actually _detecting_ if a deck makes Spectra very easy to build, instead of relying on it setting a flag explicitly

## Things planned to possibly maybe do
- Art for the planets which isn't a hilariously blatant placeholder
- Figure out what to do about the conflicts thing

A lot of this code came from [Bunco](https://github.com/Firch/Bunco), which in turn got it from [Six Suits](https://github.com/lshtech/SixSuits).

[^1]: Okay technically it adds a fake wild suit to demonstrate the Spectrum hands. But you shouldn't actually see that in gameplay.