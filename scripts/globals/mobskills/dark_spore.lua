-----------------------------------
--  Dark Spore
--
--  Description: Unleashes a torrent of black spores in a fan-shaped area of effect, dealing dark damage to targets. Additional effect: Blind
--  Type: Magical Dark (Element)
--
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.BLINDNESS
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 3, 120)

    local cap = 800
    if mob:isInDynamis() and not mob:getMaster() then
        cap = 1055
    end
    local dmgmod = xi.mobskills.mobBreathMove(mob, target, 0.25, 2, xi.magic.ele.DARK, cap)

    local dmg = xi.mobskills.mobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.DARK)
    return dmg
end

return mobskillObject
