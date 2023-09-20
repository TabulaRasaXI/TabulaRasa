-----------------------------------
-- Dragoon Job Utilities
-----------------------------------
require("scripts/globals/ability")
require("scripts/globals/items")
require("scripts/globals/jobpoints")
require("scripts/globals/msg")
require("scripts/globals/settings")
require("scripts/globals/spells/damage_spell")
require("scripts/globals/status")
require("scripts/globals/weaponskills")
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.dragoon = xi.job_utils.dragoon or {}
-----------------------------------

-- Returns a table of WS Parameters common to all damage-dealing jumps
local function getJumpWSParams(player, atkMultiplier, tpMultiplier, forceCrit)
    local params =
    {
        numHits = 1,
        ftp100  = 1,
        ftp200  = 1,
        ftp300  = 1,

        str_wsc = 0.0,
        dex_wsc = 0.0,
        vit_wsc = 0.0,
        agi_wsc = 0.0,
        int_wsc = 0.0,
        mnd_wsc = 0.0,
        chr_wsc = 0.0,

        crit100 = 0.0,
        crit200 = 0.0,
        crit300 = 0.0,
        canCrit = true,

        acc100 = 0.0,
        acc200 = 0.0,
        acc300 = 0.0,

        atk100 = atkMultiplier,
        atk200 = atkMultiplier,
        atk300 = atkMultiplier,

        bonusTP = 0,
        targetTPMult = 0,
        attackerTPMult = tpMultiplier,
        hitsHigh = true,
        isJump = true,
    }

    if player:getMod(xi.mod.FORCE_JUMP_CRIT) > 0 or forceCrit then
        params.crit100 = 1.0
        params.crit200 = 1.0
        params.crit300 = 1.0
    end

    return params
end

local function getWyvern(player)
    local wyvern = player:getPet()

    if wyvern and wyvern:getPetID() == xi.pet.id.WYVERN then
        return wyvern
    end

    return nil
end

local function hasWyvern(player)
    return getWyvern(player) and true or false
end

-- Generic Function for damage-based Jumps
-- TODO: implement Fly High attack +5 job points
local function performWSJump(player, target, action, params, abilityID)
    local taChar = player:getTrickAttackChar(target)
    local damage, criticalHit, tpHits, extraHits = xi.weaponskills.doPhysicalWeaponskill(player, target, 0, params, 0, action, true, taChar)
    local totalHits = tpHits + extraHits
    local specEffect = 0x00

    if totalHits > 0 then

        if target:getHP() <= 0 then
            specEffect = bit.bor(specEffect, 0x01) -- Add in "killed target" bit
        end

        if criticalHit then -- set crit bit
            specEffect = bit.bor(specEffect, 0x02)
        end

        if
            abilityID == xi.jobAbility.SOUL_JUMP or
            abilityID == xi.jobAbility.SPIRIT_JUMP
        then
            specEffect = bit.bor(specEffect, 0x04) -- Add in Soul/Spirit bit
        end

        -- TODO: process additional effects such as Delphinius, Pteroslaver Mail +2/3, Hebo's Spear, enspells, other weapon built-in add effects

        action:speceffect(target:getID(), specEffect)
        action:messageID(target:getID(), xi.msg.basic.USES_JA_TAKE_DAMAGE)
    else
        action:messageID(target:getID(), xi.msg.basic.JA_MISS_2)
        action:speceffect(target:getID(), specEffect)
    end

    -- Jumps add JUMP_TP_BONUS regardless of 0 dmg or miss and is affected by Store TP but not the target's subtle blow
    local storeTPModifier = (100 + player:getMod(xi.mod.STORETP)) / 100
    local extraTP = player:getMod(xi.mod.JUMP_TP_BONUS)

    -- Spirit jump specific TP bonus
    if abilityID == xi.jobAbility.SPIRIT_JUMP then
        extraTP = extraTP + player:getMod(xi.mod.JUMP_SPIRIT_TP_BONUS)
    end

    player:addTP(math.floor(extraTP * storeTPModifier))

    -- https://www.bg-wiki.com/ffxi/Fly_High_(Ability)
    if player:hasStatusEffect(xi.effect.FLY_HIGH) then
        local flyHighJumpRecast = 10
        action:setRecast(flyHighJumpRecast)
    end

    return damage, totalHits
end

local function cutEmpathyEffectTable(validEffects, i, maxCount)
    local delindex = 1

    while maxCount < i do
        delindex = math.random(1, i)
        while validEffects[delindex + 1] ~= nil do
            validEffects[delindex] = validEffects[delindex + 1]
            delindex = delindex + 1
        end

        validEffects[delindex + 1] = nil -- could be in the above loop, but unsure if Lua allows copying of nil?
        i = i - 1
    end

    return validEffects
end

-- Ability Check Functions
-- Note: This does not include Always-Allow abilitys (return 0, 0 by default)
xi.job_utils.dragoon.abilityCheckRequiresPet = function(player, target, ability, checkActionable)
    if not hasWyvern(player) then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if checkActionable and not player:getPet():canUseAbilities() then
            return xi.msg.basic.PET_CANNOT_DO_ACTION, 0
        end

        if ability:getID() == xi.jobAbility.SPIRIT_SURGE then
            ability:setRecast(ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST))
        end

        return 0, 0
    end
end

xi.job_utils.dragoon.abilityCheckCallWyvern = function(player, target, ability)
    if player:getPet() ~= nil then
        return xi.msg.basic.ALREADY_HAS_A_PET, 0
    elseif player:hasStatusEffect(xi.effect.SPIRIT_SURGE) then
        return xi.msg.basic.UNABLE_TO_USE_JA, 0
    elseif not player:canUseMisc(xi.zoneMisc.PET) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA, 0
    else
        return 0, 0
    end
end

xi.job_utils.dragoon.abilityCheckSpiritLink = function(player, target, ability)
    local wyvern = player:getPet()

    if not hasWyvern(player) then
        return xi.msg.basic.REQUIRES_A_PET, 0
    else
        if
            wyvern:getHP() == wyvern:getMaxHP() and
            player:getMerit(xi.merit.EMPATHY) == 0
        then
            return xi.msg.basic.UNABLE_TO_USE_JA, 0
        else
            return 0, 0
        end
    end
end

xi.job_utils.dragoon.abilityCheckDeepBreathing = function(player, target, ability)
    if player:getPet() == nil then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif not hasWyvern(player) then
        return xi.msg.basic.NO_EFFECT_ON_PET, 0
    else
        return 0, 0
    end
end

xi.job_utils.dragoon.abilityCheckAngon = function(player, target, ability)
    local id = player:getEquipID(xi.slot.AMMO)

    if id == xi.items.ANGON then
        return 0, 0
    else
        return xi.msg.basic.CANNOT_PERFORM, 0
    end
end

xi.job_utils.dragoon.useSpiritSurge = function(player, target, ability)
    local wyvern = player:getPet()
    local petTP = wyvern:getTP()
    local duration = 60

    -- Spirit Surge increases dragoon's MAX HP increases by 25% of wyvern MaxHP
    -- bg wiki says 25% ffxiclopedia says 15%, going with 25 for now
    local maxHPBoost = target:getPet():getMaxHP() * 0.25

    -- Dragoon gets all of wyverns TP when using Spirit Surge
    target:addTP(petTP)
    wyvern:delTP(petTP)

    -- Spirit Surge increases dragoon's Strength
    local strBoost = 1 + math.floor(wyvern:getMainLvl() / 5)

    target:despawnPet()

    -- All Jump recast times are reset, but not Spirit/Soul jump
    target:resetRecast(xi.recast.ABILITY, 158) -- Jump
    target:resetRecast(xi.recast.ABILITY, 159) -- High Jump
    target:resetRecast(xi.recast.ABILITY, 160) -- Super Jump

    target:addStatusEffect(xi.effect.SPIRIT_SURGE, maxHPBoost, 0, duration, 0, strBoost)
end

xi.job_utils.dragoon.useCallWyvern = function(player, target, ability)
    xi.pet.spawnPet(player, xi.pet.id.WYVERN)
end

xi.job_utils.dragoon.useAncientCircle = function(player, target, ability)
    local duration = 180 + player:getMod(xi.mod.ANCIENT_CIRCLE_DURATION)
    local jpValue = player:getJobPointLevel(xi.jp.ANCIENT_CIRCLE_EFFECT)
    local power = 5

    if player:getMainJob() == xi.job.DRG then
        power = 15 + jpValue
    end

    target:addStatusEffect(xi.effect.ANCIENT_CIRCLE, power, 0, duration)
end

xi.job_utils.dragoon.useJump = function(player, target, ability, action)
    local atkMultiplier = (player:getMod(xi.mod.JUMP_ATT_BONUS) + 100) / 100
    local params = getJumpWSParams(player, atkMultiplier, 1, false)

    -- Only "Jump" and not others get the fTP VIT bonus
    local ftp = 1 + (player:getStat(xi.mod.VIT) / 256)
    params.ftp100 = ftp
    params.ftp200 = ftp
    params.ftp300 = ftp

    local damage, totalHits = performWSJump(player, target, action, params, ability:getID())

    -- Under Spirit Surge, Jump also decreases target defense by 20% for 60 seconds
    if
        totalHits > 0 and
        player:hasStatusEffect(xi.effect.SPIRIT_SURGE) and
        not target:hasStatusEffect(xi.effect.DEFENSE_DOWN) -- Does this overwrite itself?
    then
        target:addStatusEffect(xi.effect.DEFENSE_DOWN, 20, 0, 60)
    end

    return damage
end

local function checkForRemovableEffectsOnSpiritLink(player, wyvern)
    -- Removes all DoTs, all at once.
    -- Would this be better as an DoT effect flag?
    -- https://www.ffxiah.com/forum/topic/44396/sigurds-descendants-the-art-of-dragon-slaying/108/#3646578

    -- Confirmed in Brenner:
    wyvern:delStatusEffect(xi.effect.POISON)
    wyvern:delStatusEffect(xi.effect.BIO)
    wyvern:delStatusEffect(xi.effect.DIA)
    wyvern:delStatusEffect(xi.effect.REQUIEM)

    wyvern:delStatusEffect(xi.effect.BURN)
    wyvern:delStatusEffect(xi.effect.FROST)
    wyvern:delStatusEffect(xi.effect.CHOKE)
    wyvern:delStatusEffect(xi.effect.RASP)
    wyvern:delStatusEffect(xi.effect.SHOCK)
    wyvern:delStatusEffect(xi.effect.DROWN)

    -- Player casted doom (Cruel Joke) was removed in brenner 100% of the time
    wyvern:delStatusEffect(xi.effect.DOOM)

    -- If you can use Spirit Link at all, sleep is removed. Empathy merits control use at 100% HP.
    removeSleepEffects(wyvern)

    if player:getMod(xi.mod.ENHANCES_SPIRIT_LINK) > 0 then
        -- https://www.ffxiah.com/forum/topic/44396/sigurds-descendants-the-art-of-dragon-slaying/108/#3646600
        -- Remove 2 erasable effects or effects that can be removed by -na
        local additionalRemovableEffects =
        {
            [xi.effect.BLINDNESS]     = true,
            [xi.effect.PARALYSIS]     = true,
            [xi.effect.SILENCE]       = true,
            [xi.effect.CURSE_I]       = true,
            [xi.effect.CURSE_II]      = true,
            [xi.effect.PLAGUE]        = true,
            [xi.effect.DISEASE]       = true,
            [xi.effect.PETRIFICATION] = true,
            [xi.effect.AMNESIA]       = true,
        }

        local effects = wyvern:getStatusEffects()
        local validEffects = {}

        for _, effect in pairs(effects) do
            local id = effect:getType()
            if
                bit.band(effect:getFlag(), xi.effectFlag.ERASABLE) == xi.effectFlag.ERASABLE or
                additionalRemovableEffects[id] ~= nil
            then
                table.insert(validEffects, id)
            end
        end

        if #validEffects > 0 then
            local removeIndex = math.random(1, #validEffects)

            wyvern:delStatusEffect(validEffects[removeIndex])
            table.remove(validEffects, removeIndex)

            if #validEffects > 0 then
                wyvern:delStatusEffect(validEffects[math.random(1, #validEffects)])
            end
        end
    end
end

xi.job_utils.dragoon.useSpiritLink = function(player, target, ability)
    local wyvern = player:getPet()
    local playerHP = player:getHP()

    checkForRemovableEffectsOnSpiritLink(player, wyvern)

    -- Empathy copying
    local empathyTotal = player:getMerit(xi.merit.EMPATHY)

    -- Add wyvern levels to the tune of 200 per empathy merit
    if xi.settings.main.ENABLE_WOTG == 1 then
        xi.job_utils.dragoon.addWyvernExp(player, 200 * empathyTotal)
    end

    if empathyTotal > 0 then
        local validEffects = {}
        local i = 0
        local effects = player:getStatusEffects()

        local copyi = 0

        for _, effect in pairs(effects) do
            if bit.band(effect:getFlag(), xi.effectFlag.EMPATHY) == xi.effectFlag.EMPATHY then
                validEffects[i + 1] = effect
                i = i + 1
            end
        end

        if i < empathyTotal then
            empathyTotal = i
        elseif i > empathyTotal then
            validEffects = cutEmpathyEffectTable(validEffects, i, empathyTotal)
        end

        local copyEffect = nil
        while copyi < empathyTotal do
            copyEffect = validEffects[copyi + 1]
            if wyvern:hasStatusEffect(copyEffect:getType()) then
                wyvern:delStatusEffectSilent(copyEffect:getType())
            end

            wyvern:addStatusEffect(copyEffect:getType(), copyEffect:getPower(), copyEffect:getTick(), math.ceil((copyEffect:getTimeRemaining()) / 1000)) -- id, power, tick, duration(convert ms to s)
            copyi = copyi + 1
        end
    end

    local drainamount = (math.random(25, 35) / 100) * playerHP
    local jpValue = player:getJobPointLevel(xi.jp.SPIRIT_LINK_EFFECT)

    drainamount = drainamount * (1 - (0.01 * jpValue))

    if wyvern:getHP() == wyvern:getMaxHP() then
        drainamount = 0 -- Prevents player HP loss if wyvern is at full HP
    end

    if player:hasStatusEffect(xi.effect.STONESKIN) then
        local skin = player:getMod(xi.mod.STONESKIN)

        if skin >= drainamount then
            if skin == drainamount then
                player:delStatusEffect(xi.effect.STONESKIN)
            else
                local effect = player:getStatusEffect(xi.effect.STONESKIN)
                effect:setPower(effect:getPower() - drainamount) -- fixes the status effect so when it ends it uses the new power instead of old
                player:delMod(xi.mod.STONESKIN, drainamount) -- removes the amount from the mod
            end
        else
            player:delStatusEffect(xi.effect.STONESKIN)
            player:takeDamage(drainamount - skin)
        end

    else
        player:takeDamage(drainamount)
    end

    local healPet = drainamount * 2

    -- TODO: replace with item mod
    if player:getEquipID(xi.slot.HEAD) == 15238 then
        healPet = healPet + 15
    end

    return wyvern:addHP(healPet) -- add the hp to wyvern
end

xi.job_utils.dragoon.useHighJump = function(player, target, ability, action)
    local params = getJumpWSParams(player, 1, 1, false)
    local damage, totalHits = performWSJump(player, target, action, params, ability:getID())

    if target:isMob() then
        local enmityShed = 50
        if player:getMainJob() ~= xi.job.DRG then
            enmityShed = 30
        end

        target:lowerEnmity(player, enmityShed + player:getMod(xi.mod.HIGH_JUMP_ENMITY_REDUCTION)) -- reduce total accumulated enmity
    end

    if
        totalHits > 0 and
        player:hasStatusEffect(xi.effect.SPIRIT_SURGE)
    then
        -- Under Spirit Surge, High Jump reduces TP of target
        -- https://www.bg-wiki.com/ffxi/Spirit_Surge
        target:delTP(damage * 2)
    end

    return damage
end

xi.job_utils.dragoon.useSuperJump = function(player, target, ability)
    -- http://wiki.ffo.jp/html/3367.html
    for _, mob in pairs(player:getNotorietyList()) do
        -- TODO: testing shows max range on this is >50' but stops somewhere above this. Need exact number.
        if mob:isMob() and mob:checkDistance(player) <= 75.0 then
            mob:setCE(player, 1)
            mob:setVE(player, 0)
        end
    end

    ability:setMsg(xi.msg.basic.NONE)

    -- Prevent the player from performing actions while in the air
    player:queue(0, function(playerArg)
        playerArg:untargetableAndUnactionable(5000)
    end)

    -- If the Dragoon's wyvern is out, alive, and engaged, tell it to use Super Climb
    local wyvern = getWyvern(player)
    if
        wyvern ~= nil and
        wyvern:getHP() > 0 and
        wyvern:isEngaged()
    then
        wyvern:useJobAbility(xi.jobAbility.SUPER_CLIMB, wyvern)
    end

    -- Handle Spirit Surge -50% enmity reduction on super jump to closest party member behind the dragoon
    if player:hasStatusEffect(xi.effect.SPIRIT_SURGE) then
        local minDistance = 9999
        local closestPartyMember = nil

        -- Find the closest party member
        local party = player:getPartyWithTrusts()
        for _, member in pairs(party) do
            local distance = member:checkDistance(player)
            if
                member:getID() ~= player:getID() and
                not member:isDead() and
                (distance < minDistance or closestPartyMember == nil)
            then
                closestPartyMember = member
                minDistance = distance
            end
        end

        -- TODO: verify conditions for how close the dragoon needs to be to the mob, if at all
        -- It doesn't matter what direction the dragoon is facing http://wiki.ffo.jp/html/3367.html#comment_1
        if
            closestPartyMember and
            closestPartyMember:isBehind(player) and
            (player:checkDistance(target) < closestPartyMember:checkDistance(target)) -- Verify dragoon is closer than the party member that we want to reduce the enmity of
        then
            if target:isMob() then
                target:lowerEnmity(closestPartyMember, 50)
            end
        end
    end
end

-- https://www.bg-wiki.com/ffxi/Angon
xi.job_utils.dragoon.useAngon = function(player, target, ability)
    local typeEffect = xi.effect.DEFENSE_DOWN
    local duration = 15 + player:getMerit(xi.merit.ANGON) -- This will return 30 sec at one investment because merit power is 15.

    if not target:addStatusEffect(typeEffect, 20, 0, duration) then
        ability:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    end

    target:updateClaim(player)
    player:removeAmmo()

    return typeEffect
end

xi.job_utils.dragoon.useDeepBreathing = function(player, target, ability)
    local wyvern = getWyvern(player)
    if wyvern then
        wyvern:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 0, 0, 180) -- Message when effect is lost is "Magic Attack boost wears off."
    end
end

xi.job_utils.dragoon.useSpiritBond = function(player, target, ability)
    player:addStatusEffect(xi.effect.SPIRIT_BOND, 0, 0, 180)
end

xi.job_utils.dragoon.useSpiritJump = function(player, target, ability, action)
    local atkMultiplier = (player:getMod(xi.mod.JUMP_ATT_BONUS) + 100) / 100
    atkMultiplier = atkMultiplier + (player:getMod(xi.mod.JUMP_SOUL_SPIRIT_ATT_BONUS)) / 100

    local tpMultiplier = 1
    local forceCrit = false

    -- https://www.bg-wiki.com/ffxi/Spirit_Jump
    if hasWyvern(player) then
        tpMultiplier = 2
        atkMultiplier = atkMultiplier + 0.25
        forceCrit = true
    end

    local params = getJumpWSParams(player, atkMultiplier, tpMultiplier, forceCrit)
    local damage, _ = performWSJump(player, target, action, params, ability:getID())

    return damage
end

xi.job_utils.dragoon.useSoulJump = function(player, target, ability, action)
    local atkMultiplier = (player:getMod(xi.mod.JUMP_ATT_BONUS) + 100) / 100
    atkMultiplier = atkMultiplier + (player:getMod(xi.mod.JUMP_SOUL_SPIRIT_ATT_BONUS)) / 100

    local tpMultiplier = 1
    local forceCrit = false

    -- https://www.bg-wiki.com/ffxi/Soul_Jump
    if hasWyvern(player) then
        tpMultiplier = 3
        atkMultiplier = atkMultiplier + 0.5
        forceCrit = true
    end

    local params = getJumpWSParams(player, atkMultiplier, tpMultiplier, forceCrit)
    local damage, _ = performWSJump(player, target, action, params, ability:getID())

    return damage
end

xi.job_utils.dragoon.useDragonBreaker = function(player, target, ability)
    player:addStatusEffect(xi.effect.DRAGON_BREAKER, 20, 0, 180)
end

xi.job_utils.dragoon.useFlyHigh = function(player, target, ability)
    -- All Jump recast times are reset
    target:resetRecast(xi.recast.ABILITY, 158) -- Jump
    target:resetRecast(xi.recast.ABILITY, 159) -- High Jump
    target:resetRecast(xi.recast.ABILITY, 160) -- Super Jump
    target:resetRecast(xi.recast.ABILITY, 166) -- Spirit Jump
    target:resetRecast(xi.recast.ABILITY, 167) -- Soul Jump

    player:addStatusEffect(xi.effect.FLY_HIGH, 0, 0, 30)
end

xi.job_utils.dragoon.useSteadyWing = function(player, target, ability, action)
    local wyvern = getWyvern(player)

    -- https://www.bg-wiki.com/ffxi/Steady_Wing
    if wyvern then
        local power = 1.3 * wyvern:getMaxHP() + wyvern:getHP()

        action:reaction(wyvern:getID(), 0x10) -- Observed on retail
        if wyvern:addStatusEffect(xi.effect.STONESKIN, power, 0, 300) then
            local effect = wyvern:getStatusEffect(xi.effect.STONESKIN)
            if effect then
                effect:unsetFlag(xi.effectFlag.DISPELABLE) -- Observed to not be dispelable
                effect:setTier(5) -- Empathy doesn't overwrite this stoneskin wih player casted stoneskin
            end
        end
    end
end

-- Breath Formula: https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#Healing_Breath
xi.job_utils.dragoon.useHealingBreath = function(wyvern, target, skill, action)
    local healingBreathTable =
    {
        --                                   { base, multiplier }
        [xi.jobAbility.HEALING_BREATH]     = {  8, 25 },
        [xi.jobAbility.HEALING_BREATH_II]  = { 24, 38 },
        [xi.jobAbility.HEALING_BREATH_III] = { 42, 45 },
        [xi.jobAbility.HEALING_BREATH_IV]  = { 60, 53 },
    }

    local master = wyvern:getMaster()
    local deepBreathingMerits = master:getMerit(xi.merit.DEEP_BREATHING)
    local deepMult = 0
    if wyvern:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) then
        deepMult = 37.5 + (12.5 * deepBreathingMerits)

        -- add in augment power, +5 per merit level (including first)
        if master:getMod(xi.mod.ENHANCE_DEEP_BREATHING) > 0 then
            deepMult = deepMult + deepBreathingMerits * 5
        end

        wyvern:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    end

    local jobPointBonus = master:getJobPointLevel(xi.jp.WYVERN_BREATH_EFFECT) * 10
    local breathAugmentsBonus = 1 + master:getMod(xi.mod.UNCAPPED_WYVERN_BREATH) / 100
    local gear = master:getMod(xi.mod.WYVERN_BREATH) -- Master gear that enhances breath
    local base = healingBreathTable[skill:getID()][1]
    local baseMultiplier = healingBreathTable[skill:getID()][2]

    -- gear cap of 64/256 in multiplier
    local multiplier = (baseMultiplier + math.min(gear, 64) + math.floor(deepMult) + (math.floor(wyvern:getTP() / 200) / 1.165)) / 256
    local curePower = math.floor(wyvern:getMaxHP() * multiplier) + base + jobPointBonus * breathAugmentsBonus
    local totalHPRestored = target:addHP(curePower)

    skill:setMsg(xi.msg.basic.JA_RECOVERS_HP_2)
    action:reaction(target:getID(), 0x18)

    -- also cure the Wyvern if Spirit Bond is up
    if master:hasStatusEffect(xi.effect.SPIRIT_BOND) then
        local totalWyvernHPRestored = wyvern:addHP(curePower)

        action:addAdditionalTarget(wyvern:getID())
        action:setAnimation(wyvern:getID(), action:getAnimation(target:getID()))
        action:messageID(wyvern:getID(), xi.msg.basic.SELF_HEAL_SECONDARY)
        action:reaction(wyvern:getID(), 0x18)
        action:param(wyvern:getID(), totalWyvernHPRestored)
    end

    if master:getMod(xi.mod.ENHANCES_STRAFE) > 0 then
        wyvern:addTP(master:getMerit(xi.merit.STRAFE_EFFECT) * 50) -- add 50 TP per merit with augmented AF2 legs
    end

    return totalHPRestored
end

-- https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#Elemental_Breath
xi.job_utils.dragoon.useDamageBreath = function(wyvern, target, skill, action, damageType)
    local master = wyvern:getMaster()

    local deepBreathingMerits = master:getMerit(xi.merit.DEEP_BREATHING)
    local deepMult = 0

    if wyvern:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) then
        deepMult = 0.75 + (0.25 * deepBreathingMerits)

        -- add in augment power, +0.1 per merit level (including first)
        if master:getMod(xi.mod.ENHANCE_DEEP_BREATHING) > 0 then
            deepMult = deepMult + deepBreathingMerits * 0.1
        end

        wyvern:delStatusEffect(xi.effect.MAGIC_ATK_BOOST)
    end

    local jobPointBonus = master:getJobPointLevel(xi.jp.WYVERN_BREATH_EFFECT) * 10
    local breathAugmentsBonus = master:getMod(xi.mod.UNCAPPED_WYVERN_BREATH) / 100
    local gear = master:getMod(xi.mod.WYVERN_BREATH) -- Master gear that enhances breath

    -- gear cap of 64/256 in multiplier
    local multiplier = 1.0 + (math.min(gear, 64)) / 256

    local damage = math.floor(math.floor(wyvern:getHP() / 6 + 15 + jobPointBonus)) * multiplier * (1.0 + breathAugmentsBonus + deepMult)

    -- strafe merits are +10 per merit
    local strafeMeritPower = master:getMerit(xi.merit.STRAFE_EFFECT)
    if master:getMod(xi.mod.ENHANCES_STRAFE) > 0 then
        wyvern:addTP(strafeMeritPower * 5) -- add 50 TP per merit with augmented AF2 legs
    end

    local bonusMacc = strafeMeritPower + master:getMod(xi.mod.WYVERN_BREATH_MACC)
    local element = damageType - xi.damageType.ELEMENTAL

    -- "Breath accuracy is directly affected by a wyvern's current HP", but no data exists.
    local resist              = xi.spells.damage.calculateResist(wyvern, target,  nil, 0, element, 0, bonusMacc)
    local sdt                 = xi.spells.damage.calculateSDT(wyvern, target, nil, element)
    local magicBurst          = xi.spells.damage.calculateIfMagicBurst(wyvern, target,  0, element)
    local nukeAbsorbOrNullify = xi.spells.damage.calculateNukeAbsorbOrNullify(wyvern, target, nil, element)

    -- It appears that MB breaths don't do more damage based on testing.
    damage = damage * resist * sdt * nukeAbsorbOrNullify

    if damage >= 0 then
        damage = AbilityFinalAdjustments(damage, wyvern, skill, target, xi.attackType.BREATH, damageType, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
        action:messageID(target:getID(), xi.msg.basic.USES_JA_TAKE_DAMAGE)
        if magicBurst > 1 then
            action:messageID(target:getID(), xi.msg.basic.JA_MAGIC_BURST) -- Magic Burst! Target takes X points of damage
        end

        target:takeDamage(damage, wyvern, xi.attackType.BREATH, damageType)
    else
        -- absorb

        -- Capped in 2022 --
        -- retail uses message 121, "Wyvern uses Frost Breath.\nWyvern recovers <amount> HP." which is wrong
        -- if SE ever fixes this, it will need to change
        -- skill:setMsg(???)
        -- if magicBurst > 1  then
            -- skill:setMsg(???)
        -- end

        -- Borrow Rune Fencer's behavior for now, including setting the Magic Burst bit.
        -- The bit does not actually change the message.
        action:messageID(target:getID(), xi.msg.basic.JA_RECOVERS_HP)
        if magicBurst > 1  then
            action:modifier(target:getID(), xi.actionModifier.MAGIC_BURST)
        end

        return target:addHP(math.abs(damage))
    end

    return damage
end

-- There is an instance of the wyvern refusing to use breaths on retail, such as against Shinryu.
-- The wyvern will not respond to Smiting Breath, as you are simply unable to use it.
xi.job_utils.dragoon.pickAndUseDamageBreath = function(player, target)
    local breathList =
    {
        xi.jobAbility.FLAME_BREATH,
        xi.jobAbility.FROST_BREATH,
        xi.jobAbility.GUST_BREATH,
        xi.jobAbility.SAND_BREATH,
        xi.jobAbility.LIGHTNING_BREATH,
        xi.jobAbility.HYDRO_BREATH,
    }

    local resistances =
    {
        target:getMod(xi.mod.FIRE_MEVA),
        target:getMod(xi.mod.ICE_MEVA),
        target:getMod(xi.mod.WIND_MEVA),
        target:getMod(xi.mod.EARTH_MEVA),
        target:getMod(xi.mod.THUNDER_MEVA),
        target:getMod(xi.mod.WATER_MEVA),
    }

    local lowest = resistances[1]
    local breath = breathList[math.random(#breathList)]
    local head = player:getEquippedItem(xi.slot.HEAD)

    -- https://ffxiclopedia.fandom.com/wiki/Drachen_Armet?oldid=965925
    -- https://ffxiclopedia.fandom.com/wiki/Elemental_Breath?oldid=738854
    -- The wyvern picks breath based on the lowest resistance if the player has Drachen Armet equipped.
    -- If all resistances are equal, a random breath is used.
    -- However there innately exists a chance where wyvern use breath based on weakness.
    if
        head == xi.items.DRACHEN_ARMET or
        head == xi.items.DRACHEN_ARMET_P1 or
        math.random() < 0.5
    then
        for i, v in ipairs(breathList) do
            if resistances[i] < lowest then
                lowest = resistances[i]
                breath = v
            end
        end
    end

    player:getPet():useJobAbility(breath, target)
end

xi.job_utils.dragoon.useRestoringBreath = function(player, ability, action)
    local wyvern = player:getPet()

    local healingbreath = xi.jobAbility.HEALING_BREATH
    local breathHealRange = 14

    if player:getMainLvl() >= 80 then
        healingbreath = xi.jobAbility.HEALING_BREATH_IV
    elseif player:getMainLvl() >= 40 then
        healingbreath = xi.jobAbility.HEALING_BREATH_III
    elseif player:getMainLvl() >= 20 then
        healingbreath = xi.jobAbility.HEALING_BREATH_II
    end

    local function inBreathRange(target)
        return wyvern:checkDistance(target) <= breathHealRange
    end

    local highestHPDiff = -1
    local target = nil

    -- Find the target with the most HP diff from max
    local party = player:getPartyWithTrusts()
    for _, member in pairs(party) do
        local maxHPDiff = member:getMaxHP() - member:getHP()
        if
            inBreathRange(member) and
            (maxHPDiff > highestHPDiff and maxHPDiff > 0) -- Dont pick target if they have full HP
        then
            target = member
            highestHPDiff = maxHPDiff
        end
    end

    if target == nil then -- If no one else found, target master
        target = player
    end

    local jobPointRecastReduction = player:getMod(xi.mod.DRAGOON_BREATH_RECAST)
    action:setRecast(ability:getRecast() - jobPointRecastReduction)

    wyvern:useJobAbility(healingbreath, target)
end

xi.job_utils.dragoon.useSmitingBreath = function(player, target, ability, action)
    local jobPointRecastReduction = player:getMod(xi.mod.DRAGOON_BREATH_RECAST)
    action:setRecast(ability:getRecast() - jobPointRecastReduction)

    xi.job_utils.dragoon.pickAndUseDamageBreath(player, target)
end

xi.job_utils.dragoon.addWyvernExp = function(player, exp)
    local wyvern   = player:getPet()
    local prevExp = wyvern:getLocalVar("wyvern_exp")
    local numLevelUps = wyvern:getLocalVar("wyvern_level_ups")

    if prevExp < 1000 and numLevelUps < 5 then
        -- cap exp at 1000 to prevent wyvern leveling up many times from large exp awards
        local currentExp = utils.clamp(exp + prevExp, 0, 1000)
        local diff = math.floor(currentExp / 200) - numLevelUps

        while diff > 0 do
            -- wyvern leveled up (diff is the number of level ups)
            wyvern:addMod(xi.mod.ACC, 6)
            wyvern:addMod(xi.mod.HPP, 6)
            wyvern:addMod(xi.mod.ATTP, 5)
            wyvern:setHP(wyvern:getMaxHP())
            player:messageBasic(xi.msg.basic.STATUS_INCREASED, 0, 0, wyvern)
            wyvern:setLocalVar("wyvern_level_ups", numLevelUps + 1)
            diff = diff - 1
        end

        wyvern:setLocalVar("wyvern_exp", prevExp + exp)
    end

    return numLevelUps
end
