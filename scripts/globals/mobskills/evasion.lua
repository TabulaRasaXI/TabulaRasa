-----------------------------------
-- Evasion
--
-- Description: Increases evasion
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: 25% Evasion Boost.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power = mob:getStat(xi.mod.EVA) * 0.5
    local duration = 180

    local typeEffect = xi.effect.EVASION_BOOST

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, power, 0, duration))
    return typeEffect
end

return mobskillObject
