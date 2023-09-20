-----------------------------------
-- Antigravity w/ 1 Gear
-- Knockback and damage, knockback varies with gear count
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
-----------------------------------
-- TODO: The potency of the knockback effect varies with
-- the number of gears in the enemy formation. A single gear produces only a
-- slight knockback, whereas triple gears produce a very strong knockback.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:delHP(dmg)

    return dmg
end

return mobskillObject
