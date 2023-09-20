-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Bloodsucker
-- Note: This script will be loaded for both the NM and non-NM mobs of this name.
-- !pos -21.776 16.983 -231.477 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    if mob:getID() == ID.mob.BLOODSUCKER then
        mob:setMobMod(xi.mobMod.ADD_EFFECT, 1) -- "Has an Additional Effect of Drain on normal attacks"
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 613, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    if mob:getID() == ID.mob.BLOODSUCKER then
        xi.mob.nmTODPersist(mob, 259200) -- 72 hours
    end
end

return entity
