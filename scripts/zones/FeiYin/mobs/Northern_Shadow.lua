-----------------------------------
-- Area: Fei'Yin
--   NM: Northern Shadow
-----------------------------------
require("scripts/globals/mobs")

local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.lotteryPersist(mob,57600)
end

return entity
