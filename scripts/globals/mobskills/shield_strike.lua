-----------------------------------
--  Shield Strike
--
--  Description: Attempts to Shield Bash players.  Additional effect: Stun
--  Type: Physical
--  1 shadow?
--  Range: Melee front arc
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

   -- TODO: Knockback

    local numhits = 1
    local accmod = 1
    local dmgmod = 0.5
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

   MobPhysicalStatusEffectMove(mob, target, skill, xi.effect.STUN, 1, 0, 4)

    -- <100 damage to pretty much anything, except on rare occasions.
   target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
