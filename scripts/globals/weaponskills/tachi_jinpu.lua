-----------------------------------
-- Tachi Jinpu
-- Great Katana weapon skill
-- Skill level: 150
-- Two-hit attack. Deals Physical and wind elemental damage to enemy. Additonal Effect Damage varies with TP.
-- Will stack with Sneak Attack and Souleater.
-- Aligned with the Breeze Gorget & Shadow Gorget.
-- Aligned with the Breeze Belt & Shadow Belt.
-- Element: Wind
-- Modifiers: STR:30%
-- 100%TP    200%TP    300%TP
-- .5         .75      1.00
-----------------------------------
require("scripts/globals/magic")
require("scripts/globals/status")
require("scripts/globals/settings")
require("scripts/globals/weaponskills")
-----------------------------------
local weaponskillObject = {}

weaponskillObject.onUseWeaponSkill = function(player, target, wsID, tp, primary, action, taChar)
    local params = {}
    params.numHits = 2
    params.ftp100 = 0.5 params.ftp200 = 0.75 params.ftp300 = 1
    params.str_wsc = 0.4 params.dex_wsc = 0.0 params.vit_wsc = 0.0 params.agi_wsc = 0.0 params.int_wsc = 0.0 params.mnd_wsc = 0.0 params.chr_wsc = 0.0
    params.acc100 = 1.0 params.acc200 = 1.0 params.acc300 = 1.0
    params.atk100 = 1 params.atk200 = 1 params.atk300 = 1
    params.hybridWS = true
    params.includemab = true
    params.element = xi.magic.ele.WIND
    params.skillType = xi.skill.GREAT_KATANA

    if xi.settings.main.USE_ADOULIN_WEAPON_SKILL_CHANGES then
        params.ftp100 = 0.5 params.ftp200 = 0.75 params.ftp300 = 1
        params.str_wsc = 0.3
    end

    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, wsID, params, tp, action, primary, taChar)
    return tpHits, extraHits, criticalHit, damage
end

return weaponskillObject
