-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Mysticmaker Profblix
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.SILENCERES, 80)
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    local respawn = math.random(24, 30)*300 -- 2 to 2.5 hours in 5 minute windows
    xi.mob.NMPersist(mob,respawn)
end

return entity
