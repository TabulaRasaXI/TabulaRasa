-----------------------------------
-- Thunderspark M=whatever
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
require("scripts/globals/magic")
require("scripts/globals/mobskills")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local dINT = math.floor(pet:getStat(xi.mod.INT) - target:getStat(xi.mod.INT))
    local tp = skill:getTP()
    local damage = 90
    local dmgmod = 0

    if tp < 1500 then
        dmgmod = math.floor((21/256) * (tp/10) + (640/256))
    else
        dmgmod = math.floor(((21/256) * (1500/10)) + ((5/256) * ((tp-1500)/10) + 640/256))
    end

    damage = damage + (dINT * 1.5)
    damage = xi.mobskills.mobMagicalMove(pet, target, skill, damage, xi.magic.ele.LIGHTNING, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0)
    damage = xi.mobskills.mobAddBonuses(pet, target, damage.dmg, xi.magic.ele.LIGHTNING)
    damage = xi.summon.avatarFinalAdjustments(damage, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHTNING, 1)
    target:addStatusEffect(xi.effect.PARALYSIS, 15, 0, 60)
    target:takeDamage(damage, pet, xi.attackType.MAGICAL, xi.damageType.LIGHTNING)
    target:updateEnmityFromDamage(pet, damage)

    return damage
end

return ability_object
