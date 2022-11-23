-----------------------------------
-- Stone 4
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    return xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp = pet:getTP()
    local dmgmod = 0

    if tp < 1500 then
        dmgmod = math.floor((22 / 256) * (tp / 100) + (384 / 256))
    else
        dmgmod = math.floor(((22 / 256) * (1500 / 100)) + ((9 / 256) * ((tp - 1500) / 100) + 384 / 256))
    end

    local damage = pet:getMainLvl() + 2 + (0.30 * pet:getStat(xi.mod.INT)) + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.EARTH)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, 1)

    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.EARTH)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return abilityObject
