-----------------------------------
-- ID: 14788
-- Item: Gamushara Earring
-- Item Effect: Attack +22
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getItemSourceID() == xi.items.GAMUSHARA_EARRING then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.GAMUSHARA_EARRING)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 22)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 22)
end

return itemObject
