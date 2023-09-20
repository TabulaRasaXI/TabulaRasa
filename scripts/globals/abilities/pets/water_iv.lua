-----------------------------------
-- Aero 2
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
require("scripts/globals/magic")
-----------------------------------
local abilityObject = {}

abilityObject.onAbilityCheck = function(player, target, ability)
    xi.job_utils.summoner.canUseBloodPact(player, player:getPet(), target, ability)
end

abilityObject.onPetAbility = function(target, pet, skill)
    local params = {}
    params.ftp000 = 3.625 params.ftp150 = 5.31 params.ftp300 = 6.125
    params.str_wsc = 0.0 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.3 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.element = xi.magic.ele.WATER
    params.includemab = true
    params.maccBonus = xi.summon.getSummoningSkillOverCap(pet)
    params.ignoreStateLock = true

    local damage = xi.summon.avatarMagicSkill(pet, target, skill, params)

    local totaldamage = xi.summon.avatarFinalAdjustments(damage.dmg, pet, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(totaldamage, pet, xi.attackType.MAGICAL, xi.damageType.WATER)

    xi.magic.handleSMNBurstMsg(pet, target, skill, params.element, 379)

    return totaldamage
end

return abilityObject
