-----------------------------------
-- Tidal Wave
-- Deals water elemental damage to enemies within area of effect.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 3
    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 9, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end

return mobskill_object
