-----------------------------------
-- xi.effect.MAGIC_EVASION_BOOST
-----------------------------------
local effect_object = {}

effect_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MEVA, effect:getPower())
end

effect_object.onEffectTick = function(target, effect)
end

effect_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MEVA, effect:getPower())
end

return effect_object
