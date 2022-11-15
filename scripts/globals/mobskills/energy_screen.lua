-----------------------------------
-- Energy_Screen
-- Description: Invincible
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    local phase = mob:getLocalVar("battlePhase")
    if phase >= 3 then
        if mob:getLocalVar("nuclearWaste") == 0 and mob:getLocalVar("citadelBuster") == 0 then
            return 0
        end
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.PHYSICAL_SHIELD

    skill:setMsg(xi.mobskills.mobBuffMove(mob, typeEffect, 1, 0, 60))
    return typeEffect
end
return mobskillObject
