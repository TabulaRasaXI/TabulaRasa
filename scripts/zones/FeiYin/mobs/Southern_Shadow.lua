-----------------------------------
-- Area: Fei'Yin
--   NM: Southern Shadow
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVA_DOWN)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
