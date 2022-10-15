-----------------------------------
--  Amatsu: Tsukioboro
--  Type: Physical
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        mob:getObjType() == xi.objType.TRUST or
        mob:getAnimationSub() == 0
    then
        return 0
    else
        return 1
    end
end
mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.SILENCE
    local power = 1
    local duration = 60
    local numhits = 1
    local accmod = 1
    local dmgmod = 4
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1.5625, 1.875, 2.50)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)
    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    if info.hitslanded > 0 then
        target:addStatusEffect(typeEffect, power, 0, duration)
    end
    return dmg
end

return mobskillObject
