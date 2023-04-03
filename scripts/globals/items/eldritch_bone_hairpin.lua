-----------------------------------
-- ID: 15268
-- Item: eldritch_bone_hairpin
-- Item Effect: INT+2 MND+2
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ELDRITCH_BONE_HAIRPIN) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ELDRITCH_BONE_HAIRPIN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.ELDRITCH_BONE_HAIRPIN) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.ELDRITCH_BONE_HAIRPIN)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.MND, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.MND, 2)
end

return itemObject
