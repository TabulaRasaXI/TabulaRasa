-----------------------------------
-- Spell: Meteor
-- Deals non-elemental damage to an enemy.
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    -- TODO: Correct message is "Incorrect job, job level too low, or required ability not activated."  Unable to locate this in our basic or system message functions.
    -- The client blocks the spell via menus, but it can still be cast via text commands, so we have to block it here, albiet with the wrong message.
    if caster:isMob() then
        -- Promathia has significant fast cast thus need to increase cast time
        -- to match the retail cast time of 10 seconds
        if caster:getName() == "Promathia_2" then
            spell:setCastTime(18000)
        end

        return 0
    elseif caster:hasStatusEffect(xi.effect.ELEMENTAL_SEAL) then
        return 0
    else
        return xi.msg.basic.STATUS_PREVENTS
    end
end

spellObject.onSpellCast = function(caster, target, spell)
    --calculate raw damage
    --Byrthnoth @ Random Facts Thread: Magic @ BG:
    --Spell Base Damage = MAB/MDB*floor(Int + Elemental Magic Skill/6)*3.5
    --NOT AFFECTED BY DARK BONUSES (bonus ETC)
    --I'll just point this out again. It can't resist, there's no dINT, and the damage is non-elemental. The only terms that affect it for monsters (that we know of) are MDB and MDT. If a --normal monster would take 50k damage from your group, Botulus would take 40k damage. Every. Time.
    local dmg = 0
    if caster:isPC() then
        dmg = ((100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF))) * (caster:getStat(xi.mod.INT) + caster:getSkillLevel(xi.skill.ELEMENTAL_MAGIC) / 6) * 3.5
    elseif caster:isMob() and caster:getName() == "Promathia_2" then
        dmg = ((100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF))) * (caster:getStat(xi.mod.INT) + (caster:getMaxSkillLevel(caster:getMainLvl(), xi.job.BLM, xi.skill.ELEMENTAL_MAGIC)) / 6) * 5
    elseif caster:isMob() and caster:getName() == "King_Behemoth" then
        dmg = 14 + caster:getMainLvl() * 30
    else
        dmg = ((100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF))) * (caster:getStat(xi.mod.INT) + (caster:getMaxSkillLevel(caster:getMainLvl(), xi.job.BLM, xi.skill.ELEMENTAL_MAGIC)) / 6) * 9.4
    end

    --add in target adjustment
    dmg = xi.magic.adjustForTarget(target, dmg, spell:getElement())
    --add in final adjustments
    dmg = xi.magic.finalMagicAdjustments(caster, target, spell, dmg)
    return dmg
end

return spellObject
