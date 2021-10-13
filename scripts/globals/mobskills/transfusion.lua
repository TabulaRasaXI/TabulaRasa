-----------------------------------
--  Transfusion
--
--  Description: Steals HP from players within range.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown radial
--  Notes:
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

    local dmgmod = 1

    local info = MobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(MobDrainMove(mob, target, xi.mobskills.drainType.HP, dmg, xi.attackType.MAGICAL, xi.damageType.DARK))

    return dmg
end

return mobskill_object
