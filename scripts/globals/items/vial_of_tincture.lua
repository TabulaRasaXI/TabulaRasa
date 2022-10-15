-----------------------------------
-- ID: 4148
-- Item: Tincture
-- Item Effect: This potion remedies disease and plague
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)

    if (target:hasStatusEffect(xi.effect.PLAGUE) == true) then
        target:delStatusEffect(xi.effect.PLAGUE)
    end

    if (target:hasStatusEffect(xi.effect.DISEASE) == true) then
        target:delStatusEffect(xi.effect.DISEASE)
    end
end

return itemObject
