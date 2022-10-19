-----------------------------------
-- avatar Global Functions
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/mobskills")
require("scripts/globals/damage")
-----------------------------------
xi = xi or {}

local m = Module:new("smn")

-- m:addOverride("xi.summon.avatarHitDmg", function(dmg, pdifMin, pdifMax, fstrMin, fstrMax, critrate)
function avatarHitDmg(dmg, pdifMin, pdifMax, fstrMin, fstrMax, critrate)
        local fstr = math.random(fstrMin, fstrMax)
        local pdif = math.random(pdifMin * 1000, pdifMax * 1000) / 1000
        if math.random() < critrate then
            pdif = math.min(pdif + 1, 4.2)
        end
        return (dmg + fstr) * pdif
end
-- )
function avatarPhysicalHit(skill, dmg)
    -- if message is not the default. Then there was a miss, shadow taken etc
    return skill:getMsg() == xi.msg.basic.DAMAGE
end
-- m:addOverride("xi.summon.avatarPhysicalMove", function(avatar, target, skill, numberofhits, accmod, dmgmod, dmgmodsubsequent, tpeffect, mtp100, mtp200, mtp300)
--     print("module pm")
function avatarPhysicalMove(avatar, target, skill, numberofhits, accmod, dmgmod, dmgmodsubsequent, tpeffect, mtp100, mtp200, mtp300)
    local function getSummoningSkillOverCap(avatar)
        local summoner = avatar:getMaster()

        local summoningSkill = summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC)
        local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)
        return math.max(summoningSkill - maxSkill, 0)
    end

    local function avatarFSTR(att_str, def_vit)
        local dSTR = att_str - def_vit
        return math.floor(dSTR / 4 + 0.5), math.floor(dSTR / 4 + 0.25)
    end

    local function avatarFTP(tp,ftp1,ftp2,ftp3)
        if tp < 1000 then
            tp = 1000
        end
        if tp >= 1000 and tp < 2000 then
            return ftp1 + (ftp2 - ftp1) / 100 * (tp - 1000)
        elseif tp >= 2000 and tp <= 3000 then
            -- generate a straight line between ftp2 and ftp3 and find point @ tp
            return ftp2 + (ftp3 - ftp2) / 100 * (tp - 2000)
        end
        return 1 -- no ftp mod
    end

    local summoner = avatar:getMaster()
    local summoningSkill = summoner:getSkillLevel(xi.skill.SUMMONING_MAGIC)
    local maxSkill = summoner:getMaxSkillLevel(avatar:getMainLvl(), xi.job.SMN, xi.skill.SUMMONING_MAGIC)
    local skillfromcap = (maxSkill - summoningSkill)
    local returninfo = {}
    local acc = avatar:getACC() + utils.clamp(getSummoningSkillOverCap(avatar), 0, 200)
    local eva = target:getEVA()
    local dmg = avatar:getWeaponDmg()
    local minFstr, maxFstr = avatarFSTR(avatar:getStat(xi.mod.STR), target:getStat(xi.mod.VIT))
    local ratio = avatar:getStat(xi.mod.ATT) / target:getStat(xi.mod.DEF)
    local slevel = summoner:getMainLvl()
    local mlevel = target:getMainLvl()
    local corr = ((mlevel - slevel) * 2)
    local skillcorrect = (getSummoningSkillOverCap(avatar) / 2)
    -- print("corr " ..corr)
    -- print("overcap " ..getSummoningSkillOverCap(avatar))
    -- print("skillfromcap " ..skillfromcap)
    -- print("maxskill " ..maxSkill)

    -- Note: avatars do not have any level correction. This is why they are so good on Wyrms! // https://kegsay.livejournal.com/tag/smn!
    if skillfromcap > 50 then
        hitrate = math.random(0,10)
        --print("firstif! Hitrate: " ..hitrate)
    elseif skillfromcap > 20 then
        hitrate = (math.random(40,95) - corr)
        --print("secondif! Hitrate: " ..hitrate)
    else
        hitrate = (math.random(75,95) + skillcorrect - corr)
        if hitrate >= 95 then hitrate = 95
        end
        --print("lastum! Hitrate: " ..hitrate)
    end

    -- add on native crit hit rate (guesstimated, it actually follows an exponential curve)
    local critrate = (avatar:getStat(xi.mod.DEX) - target:getStat(xi.mod.AGI)) * 0.005 -- assumes +0.5% crit rate per 1 dDEX
    critrate = critrate + avatar:getMod(xi.mod.CRITHITRATE) / 100
    critrate = utils.clamp(critrate, 0.05, 0.2);

    -- Applying pDIF
    if ratio <= 1 then
        maxRatio = 1
        minRatio = 1/3
    elseif ratio < 1.6 then
        maxRatio = (2 * ratio + 1) / 3
        minRatio = (7 * ratio - 4) / 9
    elseif ratio <= 1.8 then
        maxRatio = 1.8
        minRatio = 1
    elseif ratio < 3.6 then
        maxRatio = 2.4 * ratio - 2.52
        minRatio = 5 * ratio / 3 - 2
    else
        maxRatio = 4.2
        minRatio = 4
    end

    -- start the hits
    local hitsdone = 1
    local hitslanded = 0
    local hitdmg = 0
    local finaldmg = 0

    if math.random(1,100) < hitrate then
        hitdmg = avatarHitDmg(dmg, minRatio, maxRatio, minFstr, maxFstr, critrate)
        finaldmg = finaldmg + hitdmg * dmgmod
        hitslanded = hitslanded + 1
    end

    while hitsdone < numberofhits do
        if math.random(1,100) < hitrate then
            hitdmg = avatarHitDmg(dmg, minRatio, maxRatio, minFstr, maxFstr, critrate)
            finaldmg = finaldmg + hitdmg * dmgmodsubsequent
            hitslanded = hitslanded + 1
        end
        hitsdone = hitsdone + 1
    end

    -- all hits missed
    if hitslanded == 0 or finaldmg == 0 then
        finaldmg = 0
        hitslanded = 0
        skill:setMsg(xi.msg.basic.SKILL_MISS)

    -- some hits hit
    else
        target:wakeUp()
    end

    -- apply ftp bonus
    if tpeffect == TP_DMG_BONUS then
        finaldmg = finaldmg * avatarFTP(skill:getTP(), mtp100, mtp200, mtp300)
    end

    returninfo.dmg = finaldmg
    returninfo.hitslanded = hitslanded

    return returninfo

end
-- )

-- m:addOverride("xi.summon.avatarFinalAdjustments", function(dmg,mob,skill,target,skilltype,skillparam,shadowbehav)
function avatarFinalAdjustments(dmg,mob,skill,target,skilltype,skillparam,shadowbehav)
    print("module fa")

    -- physical attack missed, skip rest
    if skilltype == xi.attackType.PHYSICAL and dmg == 0 then
        return 0
    end

    -- set message to damage
    -- this is for AoE because its only set once
    skill:setMsg(xi.msg.basic.DAMAGE)

    --Handle shadows depending on shadow behaviour / skilltype
    if shadowbehav < 5 and shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then --remove 'shadowbehav' shadows.
        targShadows = target:getMod(xi.mod.UTSUSEMI)
        shadowType = xi.mod.UTSUSEMI
        if targShadows == 0 then --try blink, as utsusemi always overwrites blink this is okay
            targShadows = target:getMod(xi.mod.BLINK)
            shadowType = xi.mod.BLINK
        end

        if targShadows > 0 then
        -- Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!
            if targShadows >= shadowbehav then --no damage, just suck the shadows
                skill:setMsg(xi.msg.basic.SHADOW_ABSORB)
                target:setMod(shadowType, targShadows - shadowbehav)
                if shadowType == xi.mod.UTSUSEMI then --update icon
                    effect = target:getStatusEffect(xi.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if targShadows - shadowbehav == 0 then
                            target:delStatusEffect(xi.effect.COPY_IMAGE)
                            target:delStatusEffect(xi.effect.BLINK)
                        elseif targShadows - shadowbehav == 1 then
                            effect:setIcon(xi.effect.COPY_IMAGE)
                        elseif targShadows - shadowbehav == 2 then
                            effect:setIcon(xi.effect.COPY_IMAGE_2)
                        elseif targShadows - shadowbehav == 3 then
                            effect:setIcon(xi.effect.COPY_IMAGE_3)
                        end
                    end
                end
                return shadowbehav
            else -- less shadows than this move will take, remove all and factor damage down
                dmg = dmg * (shadowbehav - targShadows) / shadowbehav
                target:setMod(xi.mod.UTSUSEMI, 0)
                target:setMod(xi.mod.BLINK, 0)
                target:delStatusEffect(xi.effect.COPY_IMAGE)
                target:delStatusEffect(xi.effect.BLINK)
            end
        end
    elseif shadowbehav == MOBPARAM_WIPE_SHADOWS then --take em all!
        target:setMod(xi.mod.UTSUSEMI, 0)
        target:setMod(xi.mod.BLINK, 0)
        target:delStatusEffect(xi.effect.COPY_IMAGE)
        target:delStatusEffect(xi.effect.BLINK)
    end

    -- handle Third Eye using shadowbehav as a guide
    teye = target:getStatusEffect(xi.effect.THIRD_EYE)
    if teye ~= nil and skilltype == xi.attackType.PHYSICAL then --T.Eye only procs when active with PHYSICAL stuff
        if shadowbehav == MOBPARAM_WIPE_SHADOWS then --e.g. aoe moves
            target:delStatusEffect(xi.effect.THIRD_EYE)
        elseif shadowbehav ~= MOBPARAM_IGNORE_SHADOWS then --it can be absorbed by shadows
            --third eye doesnt care how many shadows, so attempt to anticipate, but reduce
            --chance of anticipate based on previous successful anticipates.
            prevAnt = teye:getPower()
            if prevAnt == 0 then
                --100% proc
                teye:setPower(1)
                skill:setMsg(xi.msg.basic.ANTICIPATE)
                return 0
            end
            if math.random() * 10 < 8 - prevAnt then
                --anticipated!
                teye:setPower(prevAnt+1)
                skill:setMsg(xi.msg.basic.ANTICIPATE)
                return 0
            end
            target:delStatusEffect(xi.effect.THIRD_EYE)
        end
    end

    --TODO: Handle anything else (e.g. if you have Magic Shield and its a Magic skill, then do 0 damage.
    if skilltype == xi.attackType.PHYSICAL and target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) then
        return 0
    end

    if skilltype == xi.attackType.RANGED and target:hasStatusEffect(xi.effect.ARROW_SHIELD) then
        return 0
    end

    -- handle elemental resistence
    if skilltype == xi.attackType.MAGICAL and target:hasStatusEffect(xi.effect.MAGIC_SHIELD) then
        return 0
    end

    -- handling phalanx
    dmg = dmg - target:getMod(xi.mod.PHALANX)
    if dmg < 0 then
        return 0
    end

    --handle invincible
    if target:hasStatusEffect(xi.effect.INVINCIBLE) and skilltype == xi.attackType.PHYSICAL then
        return 0
    end
    -- handle pd
    if target:hasStatusEffect(xi.effect.PERFECT_DODGE) or target:hasStatusEffect(xi.effect.ALL_MISS) and skilltype == xi.attackType.PHYSICAL then
        return 0
    end

    -- Calculate Blood Pact Damage before stoneskin
    dmg = dmg + dmg * mob:getMod(xi.mod.BP_DAMAGE) / 100

    -- handling stoneskin
    dmg = utils.stoneskin(target, dmg)

    return dmg
end
-- )

m:addOverride("xi.globals.abilities.pets.axe_kick.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.barracuda_dive.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHINGING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.burning_strike.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 6

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    --get resist multiplier (1x if no resist)
    local resist = xi.mobskills.applyPlayerResistance(pet,-1,target,pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT),xi.skill.ELEMENTAL_MAGIC, xi.magic.ele.FIRE)
    --get the resisted damage
    damage.dmg = damage.dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = xi.mobskills.mobAddBonuses(pet,target,damage.dmg,xi.magic.ele.FIRE)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.camisado.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.claw.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.PIERCING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.crescent_fang.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 6

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.PIERCING,numhits)

    if (damage.hitslanded > 0) then
        target:addStatusEffect(xi.effect.PARALYSIS, 22.5, 0, 90)
    end

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end

)

m:addOverride("xi.globals.abilities.pets.double_punch.onPetAbility", function(target, pet, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 6
    local dmgmodsubsequent = 2

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.double_slap.onPetAbility", function(target, pet, skill)
    local numhits = 2
    local accmod = 1
    local dmgmod = 6
    local dmgmodsubsequent = 2

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.H2H,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.H2H)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.eclipse_bite.onPetAbility", function(target, pet, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 8
    local dmgmodsubsequent = 2
    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASH)
    target:updateEnmityFromDamage(pet,totaldamage)
    return totaldamage
end

)

m:addOverride("xi.globals.abilities.pets.flaming_crush.onPetAbility", function(target, pet, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 10
    local dmgmodsubsequent = 1

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    --get resist multiplier (1x if no resist)
    local resist = xi.mobskills.applyPlayerResistance(pet,-1,target,pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT),xi.skill.ELEMENTAL_MAGIC, xi.magic.ele.FIRE)
    --get the resisted damage
    damage.dmg = damage.dmg*resist
    --add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
    damage.dmg = xi.mobskills.mobAddBonuses(pet,target,damage.dmg,xi.magic.ele.FIRE)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.FIRE,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.FIRE)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.megalith_throw.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 5.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)
    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.moonlit_charge.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 4

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:addStatusEffect(xi.effect.BLINDNESS, 20, 0, 30)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.mountain_buster.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 12
    local dmgmodsubsequent = 0
    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL,xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.poison_nails.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)

    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.PIERCING,numhits)

    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet,totaldamage)

    if (avatarPhysicalHit(skill, totalDamage) and target:hasStatusEffect(xi.effect.POISON) == false) then
        target:addStatusEffect(xi.effect.POISON,1,3,60)
    end

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.predator_claws.onPetAbility", function(target, pet, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 10
    local dmgmodsubsequent = 2
    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)
    return totaldamage
end

)

m:addOverride("xi.globals.abilities.pets.punch.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.rock_buster.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 4

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)

    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.rock_throw.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)

    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.SLASHING,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.rush.onPetAbility", function(target, pet, skill)
    local numhits = 5
    local accmod = 1
    local dmgmod = 5
    local dmgmodsubsequent = 2

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end

)

m:addOverride("xi.globals.abilities.pets.shock_strike.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 3.5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:addStatusEffect(xi.effect.STUN, 1, 0, 2)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.spinning_dive.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 12

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.BLUNT,numhits)
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

m:addOverride("xi.globals.abilities.pets.tail_whip.onPetAbility", function(target, pet, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 5

    local totaldamage = 0
    local damage = avatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,0,TP_NO_EFFECT,1,2,3)
    totaldamage = avatarFinalAdjustments(damage.dmg,pet,skill,target,xi.attackType.PHYSICAL,xi.damageType.PIERCING,numhits)

    local duration = 120
    local resm = xi.mobskills.applyPlayerResistance(pet,-1,target,pet:getStat(xi.mod.INT)-target:getStat(xi.mod.INT),xi.skill.ELEMENTAL_MAGIC, 5)
    if resm < 0.25 then
        resm = 0
    end
    duration = duration * resm

    if (duration > 0 and avatarPhysicalHit(skill, totaldamage) and target:hasStatusEffect(xi.effect.WEIGHT) == false) then
        target:addStatusEffect(xi.effect.WEIGHT, 50, 0, duration)
    end
    target:takeDamage(totaldamage, pet, xi.attackType.PHYSICAL, xi.damageType.PIERCING)
    target:updateEnmityFromDamage(pet,totaldamage)

    return totaldamage
end
)

return m