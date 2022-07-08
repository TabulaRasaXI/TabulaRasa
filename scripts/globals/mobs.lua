-----------------------------------
-- Global version of onMobDeath
-----------------------------------
require("scripts/globals/magiantrials")
require("scripts/globals/missions")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------

xi = xi or {}
xi.mob = xi.mob or {}

-- onMobDeathEx is called from the core
xi.mob.onMobDeathEx = function(mob, player, isKiller, isWeaponSkillKill)
    -- Things that happen only to the person who landed killing blow
    if isKiller then
        -- DRK quest - Blade Of Darkness
        if
            (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED or
            player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED) and
            player:getEquipID(xi.slot.MAIN) == 16607 and
            player:getCharVar("ChaosbringerKills") < 200 and
            not isWeaponSkillKill
        then
            player:addCharVar("ChaosbringerKills", 1)
        end
    end

    xi.magian.checkMagianTrial(player, {['mob'] = mob, ['triggerWs'] = false})
end

-----------------------------------
-- placeholder / lottery NMs
-----------------------------------

-- is a lottery NM already spawned or primed to pop?
local function lotteryPrimed(phList)
    local nm
    for k, v in pairs(phList) do
        nm = GetMobByID(v)
        if nm ~= nil and (nm:isSpawned() or nm:getRespawnTime() ~= 0) then
            return true
        end
    end
    return false
end

-- potential lottery placeholder was killed
xi.mob.phOnDespawn = function(ph, phList, chance, cooldown, immediate)
    if ph:getZone():getLocalVar("[BEASTMEN]GroupIndex") ~= 0 then
        for _, group in pairs(xi.beastmengroups.zones) do
            if ph:getZoneID() == group[1] then
                for it, idtable in pairs(group[3]) do
                    if idtable[1] == ph:getID() then
                        DisallowRespawn(ph:getID(), false)
                        table.remove(group[3], it)

                        break
                    end
                end

                break
            end
        end
    end

    if type(immediate) ~= "boolean" then immediate = false end

    if xi.settings.main.NM_LOTTERY_CHANCE then
        chance = xi.settings.main.NM_LOTTERY_CHANCE >= 0 and (chance * xi.settings.main.NM_LOTTERY_CHANCE) or 100
    end

    if xi.settings.main.NM_LOTTERY_COOLDOWN then
        cooldown = xi.settings.main.NM_LOTTERY_COOLDOWN >= 0 and (cooldown * xi.settings.main.NM_LOTTERY_COOLDOWN) or cooldown
    end

    local phId = ph:getID()
    local nmId = phList[phId]

    if nmId ~= nil then
        local nm = GetMobByID(nmId)
        if nm ~= nil then
            local pop = nm:getLocalVar("pop")

            chance = math.ceil(chance * 10) -- chance / 1000.
            if os.time() > pop and not lotteryPrimed(phList) and math.random(1000) <= chance then

                -- on PH death, replace PH repop with NM repop
                DisallowRespawn(phId, true)
                DisallowRespawn(nmId, false)
                UpdateNMSpawnPoint(nmId)
                nm:setRespawnTime(immediate and 1 or GetMobRespawnTime(phId)) -- if immediate is true, spawn the nm immediately (1ms) else use placeholder's timer

                nm:addListener("DESPAWN", "DESPAWN_" .. nmId, function(m)
                    -- on NM death, replace NM repop with PH repop
                    DisallowRespawn(nmId, true)
                    DisallowRespawn(phId, false)
                    GetMobByID(phId):setRespawnTime(GetMobRespawnTime(phId))
                    m:setLocalVar("pop", os.time() + cooldown)
                    m:removeListener("DESPAWN_" .. nmId)
                end)

                return true
            end
        end
    end

    return false
end

-----------------------------------
-- Mob skills
-----------------------------------
xi.mob.skills =
{
    RECOIL_DIVE = 641,
    CYTOKINESIS = 2514
}

-----------------------------------
-- mob additional melee effects
-----------------------------------

xi.mob.additionalEffect =
{
    BLIND      = 0,
    CURSE      = 1,
    ENAERO     = 2,
    ENBLIZZARD = 3,
    ENDARK     = 4,
    ENFIRE     = 5,
    ENLIGHT    = 6,
    ENSTONE    = 7,
    ENTHUNDER  = 8,
    ENWATER    = 9,
    EVA_DOWN   = 10,
    HP_DRAIN   = 11,
    MP_DRAIN   = 12,
    PARALYZE   = 13,
    PETRIFY    = 14,
    PLAGUE     = 15,
    POISON     = 16,
    SILENCE    = 17,
    SLOW       = 18,
    STUN       = 19,
    TERROR     = 20,
    TP_DRAIN   = 21,
    WEIGHT     = 22,
}
xi.mob.ae = xi.mob.additionalEffect

local additionalEffects =
{
    [xi.mob.ae.BLIND] =
    {
        chance = 25,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.BLIND,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.BLINDNESS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [xi.mob.ae.CURSE] =
    {
        chance = 20,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.CURSE,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.CURSE_I,
        power = 50,
        duration = 300,
        minDuration = 1,
        maxDuration = 300,
    },
    [xi.mob.ae.ENAERO] =
    {
        ele = xi.magic.ele.WIND,
        sub = xi.subEffect.WIND_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENBLIZZARD] =
    {
        ele = xi.magic.ele.ICE,
        sub = xi.subEffect.ICE_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENDARK] =
    {
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.DARKNESS_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENFIRE] =
    {
        ele = xi.magic.ele.FIRE,
        sub = xi.subEffect.FIRE_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENLIGHT] =
    {
        ele = xi.magic.ele.LIGHT,
        sub = xi.subEffect.LIGHT_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENSTONE] =
    {
        ele = xi.magic.ele.EARTH,
        sub = xi.subEffect.EARTH_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENTHUNDER] =
    {
        ele = xi.magic.ele.LIGHTNING,
        sub = xi.subEffect.LIGHTNING_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.ENWATER] =
    {
        ele = xi.magic.ele.WATER,
        sub = xi.subEffect.WATER_DAMAGE,
        msg = xi.msg.basic.ADD_EFFECT_DMG,
        negMsg = xi.msg.basic.ADD_EFFECT_HEAL,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
    },
    [xi.mob.ae.EVA_DOWN] =
    {
        chance = 25,
        ele = xi.magic.ele.ICE,
        sub = xi.subEffect.EVASION_DOWN,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.EVASION_DOWN,
        power = 25,
        duration = 30,
        minDuration = 1,
        maxDuration = 60,
    },
    [xi.mob.ae.HP_DRAIN] =
    {
        chance = 10,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.HP_DRAIN,
        msg = xi.msg.basic.ADD_EFFECT_HP_DRAIN,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) mob:addHP(power) end,
    },
    [xi.mob.ae.MP_DRAIN] =
    {
        chance = 10,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.MP_DRAIN,
        msg = xi.msg.basic.ADD_EFFECT_MP_DRAIN,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local mp = math.min(power, target:getMP()) target:delMP(mp) mob:addMP(mp) end,
    },
    [xi.mob.ae.PARALYZE] =
    {
        chance = 25,
        ele = xi.magic.ele.ICE,
        sub = xi.subEffect.PARALYSIS,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.PARALYSIS,
        power = 20,
        duration = 30,
        minDuration = 1,
        maxDuration = 60,
    },
    [xi.mob.ae.PETRIFY] =
    {
        chance = 20,
        ele = xi.magic.ele.EARTH,
        sub = xi.subEffect.PETRIFY,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.PETRIFICATION,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [xi.mob.ae.PLAGUE] =
    {
        chance = 25,
        ele = xi.magic.ele.WATER,
        sub = xi.subEffect.PLAGUE,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.PLAGUE,
        power = 1,
        duration = 60,
        minDuration = 1,
        maxDuration = 60,
    },
    [xi.mob.ae.POISON] =
    {
        chance = 25,
        ele = xi.magic.ele.WATER,
        sub = xi.subEffect.POISON,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.POISON,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
        tick = 3,
    },
    [xi.mob.ae.SILENCE] =
    {
        chance = 25,
        ele = xi.magic.ele.WIND,
        sub = xi.subEffect.SILENCE,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.SILENCE,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 30,
    },
    [xi.mob.ae.SLOW] =
    {
        chance = 25,
        ele = xi.magic.ele.EARTH,
        sub = xi.subEffect.DEFENSE_DOWN,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.SLOW,
        power = 1000,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
    [xi.mob.ae.STUN] =
    {
        chance = 20,
        ele = xi.magic.ele.LIGHTNING,
        sub = xi.subEffect.STUN,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.STUN,
        duration = 5,
    },
    [xi.mob.ae.TERROR] =
    {
        chance = 20,
        sub = xi.subEffect.PARALYSIS,
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.TERROR,
        duration = 5,
        code = function(mob, target, power) mob:resetEnmity(target) end,
    },
    [xi.mob.ae.TP_DRAIN] =
    {
        chance = 25,
        ele = xi.magic.ele.DARK,
        sub = xi.subEffect.TP_DRAIN,
        msg = xi.msg.basic.ADD_EFFECT_TP_DRAIN,
        mod = xi.mod.INT,
        bonusAbilityParams = {bonusmab = 0, includemab = false},
        code = function(mob, target, power) local tp = math.min(power, target:getTP()) target:delTP(tp) mob:addTP(tp) end,
    },
    [xi.mob.ae.WEIGHT] =
    {
        chance = 25,
        ele = xi.magic.ele.WIND,
        sub = xi.subEffect.BLIND, -- TODO
        msg = xi.msg.basic.ADD_EFFECT_STATUS,
        applyEffect = true,
        eff = xi.effect.WEIGHT,
        power = 1,
        duration = 30,
        minDuration = 1,
        maxDuration = 45,
    },
}

--[[
    mob, target, and damage are passed from core into mob script's onAdditionalEffect
    effect should be of type xi.mob.additionalEffect (see above)
    params is a table that can contain any of:
        chance: percent chance that effect procs on hit (default 20)
        power: power of effect
        duration: duration of effect, in seconds
        code: additional code that will run when effect procs, of form function(mob, target, power)
    params will override effect's default settings
--]]
xi.mob.onAddEffect = function(mob, target, damage, effect, params)
    if type(params) ~= "table" then params = {} end

    local ae = additionalEffects[effect]

    if ae then
        local chance = params.chance or ae.chance or 100
        local dLevel = target:getMainLvl() - mob:getMainLvl()

        if dLevel > 0 then
            chance = chance - 5 * dLevel
            chance = utils.clamp(chance, 5, 95)
        end

        -- target:PrintToPlayer(string.format("Chance: %i", chance)) -- DEBUG

        if math.random(100) <= chance then

            -- STATUS EFFECT
            if ae.applyEffect then
                local resist = 1
                if ae.ele then
                    resist = applyResistanceAddEffect(mob, target, ae.ele, ae.eff)
                end

                if resist > 0.5 and not target:hasStatusEffect(ae.eff) then
                    local power = params.power or ae.power or 0
                    local tick = ae.tick or 0
                    local duration = params.duration or ae.duration

                    if dLevel < 0 then
                        duration = duration - dLevel
                    end

                    duration = utils.clamp(duration, ae.minDuration, ae.maxDuration) * resist

                    target:addStatusEffect(ae.eff, power, tick, duration)

                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, ae.msg, ae.eff
                end

            -- IMMEDIATE EFFECT
            else
                local power = 0

                if params.power then
                    power = params.power
                elseif ae.mod then
                    local dMod = mob:getStat(ae.mod) - target:getStat(ae.mod)

                    if dMod > 20 then
                        dMod = 20 + (dMod - 20) / 2
                    end

                    power = dMod + target:getMainLvl() - mob:getMainLvl() + damage / 2
                end

                -- target:PrintToPlayer(string.format("Initial Power: %f", power)) -- DEBUG

                power = addBonusesAbility(mob, ae.ele, target, power, ae.bonusAbilityParams)
                power = power * applyResistanceAddEffect(mob, target, ae.ele, 0)
                power = adjustForTarget(target, power, ae.ele)
                if ae.sub ~= xi.subEffect.TP_DRAIN and ae.sub ~= xi.subEffect.MP_DRAIN then
                    power = finalMagicNonSpellAdjustments(mob, target, ae.ele, power)
                end

                -- target:PrintToPlayer(string.format("Adjusted Power: %f", power)) -- DEBUG

                local message = ae.msg
                if power < 0 then
                    if ae.negMsg then
                        message = ae.negMsg
                    else
                        power = 0
                    end
                end

                if power ~= 0 then
                    if params.code then
                        params.code(mob, target, power)
                    elseif ae.code then
                        ae.code(mob, target, power)
                    end

                    return ae.sub, message, power
                end
            end
        end
    else
        printf("invalid additional effect for mobId %i", mob:getID())
    end

    return 0, 0, 0
end
