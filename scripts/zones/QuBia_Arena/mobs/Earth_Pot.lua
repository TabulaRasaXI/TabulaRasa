-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Earth Pot
-- KSNM: E-vase-ive Action
-----------------------------------
require("scripts/globals/status")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.EARTH_ABSORB, 1000)
    mob:setMod(xi.mod.SILENCERES, 95)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobEngaged = function(mob)
    local pot = mob:getID()
    for i = 1, 3 do
        DespawnMob(pot-i)
    end
    for i = 1, 2 do
        DespawnMob(pot+i)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
