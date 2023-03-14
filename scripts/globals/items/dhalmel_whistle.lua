-----------------------------------
-- ID: 15505
-- Item: dhalmel_whistle
-- Item Effect: AGI +6
-- Duration: 3 minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.DHALMEL_WHISTLE then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.DHALMEL_WHISTLE)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 6)
end

return itemObject
