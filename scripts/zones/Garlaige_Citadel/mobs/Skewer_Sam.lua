-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Skewer Sam
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEAKBENDER)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21 to 24 hours
    xi.mob.NMPersist(mob,respawn)
end

return entity
