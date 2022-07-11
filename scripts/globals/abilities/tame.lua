-----------------------------------
-- Ability: Tame
-- Makes target docile and more susceptible to charm.
-- Obtained: Beastmaster Level 30
-- Recast Time: 10:00
-- Duration: Instant
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onUseAbility = function(player, target, ability)
    if player:getPet() ~= nil then
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
        target:addEnmity(player, 1, 0)
        return 0
    end
    if target:getMobMod(xi.mobMod.CHARMABLE) == 0 then
        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
        target:addEnmity(player, 1, 0)
        return 0
    end

    local params = {diff = (player:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)), skillType = nil, bonus = 0, effect = xi.effect.NONE, element = xi.magic.element.NONE}
    local resist = applyResistanceAbility(player, target, ability:getID(), params)

    if resist <= 0.25 then
        ability:setMsg(xi.msg.basic.JA_MISS_2)
        target:addEnmity(player, 1, 0)
        return 0
    else
        if target:isEngaged() then
            local enmitylist = target:getEnmityList()
            for _, enmity in ipairs(enmitylist) do
                if enmity.active and enmity.entity:getID() ~= player:getID() then
                    ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
                    target:addEnmity(player, 1, 0)
                    return 0
                elseif enmity.entity:getID() == player:getID() then
                    if not enmity.tameable then
                        ability:setMsg(xi.msg.basic.JA_NO_EFFECT)
                        target:addEnmity(player, 1, 0)
                        return 0
                    end
                end
            end
            ability:setMsg(138) -- The x seems friendlier
            target:disengage()
        else
            player:setLocalVar("Tamed_Mob", target:getID())
            ability:setMsg(138) -- The x seems friendlier
        end
    end
end

return ability_object
