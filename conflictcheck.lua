--[[
   Checking specifically for _partial_ conflicts. 
   Any mod which implements _all_ of these should be added as a conflict to the .json file.
  ]]

if !( --Mods that implement the Spectrum hand
    
) then NFS.load(SMODS.current_mod.path .. 'spectrumframework.lua')() end

if !( --Mods that implement their own planets
    
) then NFS.load(SMODS.current_mod.path .. 'planets.lua')() end

if !( --Mods that implement their own jokers
    
) then NFS.load(SMODS.current_mod.path .. 'jokers.lua')() end