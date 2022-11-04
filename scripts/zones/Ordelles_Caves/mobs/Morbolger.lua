-----------------------------------
-- Area: Ordelles Caves (193)
--   NM: Morbolger
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- "Aggros regardless of level"
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.MORBOLBANE)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(75600, 86400) -- 21 to 24 hours
    xi.mob.NMPersist(mob,respawn)
end

return entity
