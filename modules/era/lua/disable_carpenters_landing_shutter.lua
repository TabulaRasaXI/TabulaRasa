-----------------------------------
-- Disables Wooden Shutter Interaction to zone from N.sandy to Carpenters Landing
-----------------------------------

local clEntrance = Module:new("disable_carpenters_landing_shutter")

clEntrance:addOverride("xi.zones.Northern_San_dOria.npcs.Wooden_Shutter.onTrigger", function(player)
    player:PrintToPlayer("This area is not currently accessible.", 3, "TR Staff")
end)

return clEntrance