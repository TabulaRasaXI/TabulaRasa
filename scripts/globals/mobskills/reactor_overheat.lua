-----------------------------------
--  Reactor Overheat
--  Zedi, while in Animation form 3 (Rings)
--  Blinkable 1-3 hit, addtional effect Plague on hit.
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getAnimationSub() ~= 3) then
        return 1
    end

    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 2
    local accmod = 1
    local dmgmod = 1
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, 0, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, info.hitslanded)
    local typeEffect = xi.effect.PLAGUE

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)
    return dmg

end

return mobskill_object
