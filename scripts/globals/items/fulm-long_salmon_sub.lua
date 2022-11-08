-----------------------------------
-- ID: 4266
-- Item: fulm-long_salmon_sub
-- Food Effect: 60Min, All Races
-----------------------------------
-- DEX +2
-- VIT +1
-- AGI +1
-- INT +2
-- MND -2
-- Ranged Accuracy +3
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4266)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.RACC, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.RACC, 3)
end

return itemObject
