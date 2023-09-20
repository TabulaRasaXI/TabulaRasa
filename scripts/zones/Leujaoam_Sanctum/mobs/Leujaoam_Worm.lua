-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-----------------------------------
require("scripts/globals/assault")
require("scripts/globals/status")
-----------------------------------

local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
    mob:setMod(xi.mod.UDMGMAGIC, -50)
    mob:addMod(xi.mod.DEF, 100)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.assault.progressInstance(mob)
end

return entity
