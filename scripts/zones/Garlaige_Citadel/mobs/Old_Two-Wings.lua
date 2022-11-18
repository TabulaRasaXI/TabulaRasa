-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Old Two-Wings
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)

    -- Set Old_Two_Wings's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21 to 24 hours
    xi.mob.NMPersist(mob,respawn)

end

return entity
