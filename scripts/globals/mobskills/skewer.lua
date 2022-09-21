---------------------------------------------
-- Skewer
-- Delivers a three-hit attack
-- Type: Physical
-- Range: Melee
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1.8
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 3, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.PIERCING, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.PIERCING)

    return dmg
end

return mobskill_object
