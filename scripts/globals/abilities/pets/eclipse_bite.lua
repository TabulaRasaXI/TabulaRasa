-----------------------------------
-- Eclipse Bite M=8 subsequent hits M=2
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/summon")
-----------------------------------
local ability_object = {}

ability_object.onAbilityCheck = function(player, target, ability)
    return 0, 0
end

ability_object.onPetAbility = function(target, pet, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 3
    local dmgmodsubsequent = 3
    local totaldamage = 0
    local damage = xi.summon.avatarPhysicalMove(pet, target, skill, numhits, accmod, dmgmod, dmgmodsubsequent, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 2, 3)
    totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASH)
    target:updateEnmityFromDamage(pet, totaldamage)
    return totaldamage
end

return ability_object
