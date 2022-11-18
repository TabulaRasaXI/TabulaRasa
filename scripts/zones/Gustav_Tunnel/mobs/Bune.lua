-----------------------------------
-- Area: Gustav Tunnel
--   NM: Bune
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    -- Set Bune's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21 to 24 hours
    xi.mob.NMPersist(mob,respawn)
end

return entity
