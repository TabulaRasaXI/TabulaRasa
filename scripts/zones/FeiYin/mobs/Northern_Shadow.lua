-----------------------------------
-- Area: Fei'Yin
--   NM: Northern Shadow
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
