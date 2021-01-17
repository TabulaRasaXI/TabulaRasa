---------------------------------------------
-- Arcane Stomp
--
-- Description: Stomps the ground to apply elemental absorption.
-- Type: Enhancing
-- Utsusemi/Blink absorb: N/A
-- Range: AoE surrounding Gurfurlur, affects all mobs.
-- Notes: Only used by Gurfurlur the Menacing. This results in all elemental damage (from spells or weaponskills) healing him. Aspir still works normally.  Lasts approximately 5 minutes, cannot be dispelled.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(MobBuffMove(mob, tpz.effect.MAGIC_SHIELD, 3, 0, 300))
    return tpz.effect.MAGIC_SHIELD
end

return mobskill_object
