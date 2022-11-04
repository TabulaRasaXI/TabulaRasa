-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Spriggan
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 672, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 673, 1, xi.regime.type.GROUNDS)
end

return entity
