-----------------------------------
-- Disables Interaction with NPCs to enter CoP Areas
-----------------------------------

local npcEntrances = Module:new("disable_npcs_into_cop_zones")

-- Carpenters Landing
npcEntrances:addOverride("xi.zones.Northern_San_dOria.npcs.Wooden_Shutter.onTrigger", function(player)
    RejectEntrance(player)
end)

-- Pso'Xja (6 entrances are all one NPC onTrigger)
npcEntrances:addOverride("xi.zones.Beaucedine_Glacier.npcs.Iron_Grate.onTrigger", function(player)
    RejectEntrance(player)
end)

function RejectEntrance(player)
    player:PrintToPlayer("This area is not currently accessible.", 3, "TR Staff")
end

return npcEntrances