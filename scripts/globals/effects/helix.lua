-----------------------------------
-- xi.effect.HELIX
-----------------------------------
require("scripts/globals/utils")
-----------------------------------
local effectObject = {}

effectObject.onEffectGain = function(target, effect)
end

effectObject.onEffectTick = function(target, effect)
    local dmg = utils.rampart(target, effect:getPower())
    dmg = utils.stoneskin(target, dmg)

    if dmg > 0 then
        target:takeDamage(dmg)
    end

    if effect:getTick() == 3000 then
        effect:setTick(9000)
    end
end

effectObject.onEffectLose = function(target, effect)
end

return effectObject
