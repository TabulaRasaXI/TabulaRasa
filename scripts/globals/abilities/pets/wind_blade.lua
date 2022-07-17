-----------------------------------
-- Geocrush
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)

    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp = skill:getTP() / 10
    local master = pet:getMaster()
    local merits = 0
    local dmgmod = (((45/256) * tp) + (1370/256))

    if master ~= nil and master:isPC() then
        merits = master:getMerit(xi.merit.WIND_BLADE)
    end

    tp = tp + (merits - 40)
    if tp > 300 then
        tp = 300
    end

    local damage = 96 + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.WIND)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.WIND)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
