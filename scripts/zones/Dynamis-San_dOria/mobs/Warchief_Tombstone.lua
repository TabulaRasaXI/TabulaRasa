-----------------------------------
-- Area: Dynamis - San d'Oria
--  Mob: Warchief Tombstone
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.timeExtensionOnDeath(mob, player, optParams)
end

return entity
