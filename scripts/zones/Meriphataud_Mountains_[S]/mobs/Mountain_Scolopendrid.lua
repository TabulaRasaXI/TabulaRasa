-----------------------------------
-- Area: Meriphataud Mountains [S]
--  Mob: Mountain Scolopendrid
-- Note: PH for Centipedal Centruroides
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains_[S]/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CENTIPEDAL_CENTRUROIDES_PH, 10, 3600) -- 1 hour
end

return entity
