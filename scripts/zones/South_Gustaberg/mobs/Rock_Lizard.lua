-----------------------------------
-- Area: South Gustaberg
--  Mob: Rock Lizard
-- Note: Place holder Leaping Lizzy
-----------------------------------
local ID = require("scripts/zones/South_Gustaberg/IDs")
require("scripts/globals/regimes")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 80, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.LEAPING_LIZZY_PH, 9, 1) -- Pure Lottery
end

return entity
