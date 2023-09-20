-----------------------------------
-- Wild Ginseng
--
-- Description: Gives mob Blink
--
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = math.random(210, 270)
    local regenPower = 30

    -- Bearclaw Rabbit ENM: Follow the White Rabbit
    if mob:getPool() == 384 then
        regenPower = 50
    end

    mob:addStatusEffect(xi.effect.BLINK, 3, 0, duration)
    mob:addStatusEffect(xi.effect.PROTECT, 60, 0, duration)
    mob:addStatusEffect(xi.effect.SHELL, 60, 0, duration)
    mob:addStatusEffect(xi.effect.HASTE, 2000, 0, duration) -- 20% haste
    mob:addStatusEffect(xi.effect.REGEN, regenPower, 3, duration)

    mob:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.BLINK)
end

return mobskillObject
