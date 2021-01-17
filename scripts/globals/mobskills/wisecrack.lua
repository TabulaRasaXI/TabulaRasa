---------------------------------------------
-- Wisecrack
-- Description: Inflicts AOE charm
-- Type: Enfeebling
-- Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.CHARM_I

    if not target:isPC() then
        skill:setMsg(tpz.msg.basic.SKILL_MISS)
        return typeEffect
    end

    local msg = MobStatusEffectMove(mob, target, typeEffect, 0, 3, 60)
    if msg == tpz.msg.basic.SKILL_ENFEEB_IS then
        mob:charm(target)
    end
    skill:setMsg(msg)

    return typeEffect
end

return mobskill_object
