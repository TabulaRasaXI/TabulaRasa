-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Duke Haborym
-----------------------------------
require("scripts/globals/mobs")

local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)

    -- Set Duke_Haborym's spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21 to 24 hours
    xi.mob.NMPersist(mob,respawn)

end

return entity
