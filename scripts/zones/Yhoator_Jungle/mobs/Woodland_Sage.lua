-----------------------------------
-- Area: Yhoator Jungle (124)
--   NM: Woodland Sage
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
<<<<<<< HEAD
    -- Set Woodland_Sage's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600,86400) -- 21 to 24 hours
    xi.mob.NMPersist(mob,respawn)
=======
    xi.mob.nmTODPersist(mob, math.random(75600, 86400)) -- 21 to 24 hours
>>>>>>> ASB/staging
end

return entity
