-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Brittle Rock
-- Immune to sleep (light, dark), poison, cannot regain HP on deaggro
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/assault")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    assaultUtil.adjustMobLevel(mob)
    mob:addStatusEffect(xi.effect.NO_REST, 1, 0, 0)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(xi.mod.UDMGPHYS,-75)
    mob:setMod(xi.mod.UDMGBREATH,-95)
    mob:setMod(xi.mod.UDMGRANGE,-95)
    mob:setMod(xi.mod.UDMGMAGIC, -90)
    mob:setMod(xi.mod.CURSERES, 9999)
    mob:setMod(xi.mod.EVA, 0)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:addListener("WEAPONSKILL_TAKE", "BRITTLE_ROCK_WEAPONSKILL_TAKE", function(mob, user, wsid)
        if wsid == 1838 then
            mob:setHP(0)
        end
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
    if mob:getLocalVar("dead") == 0 then
        mob:setLocalVar("dead", 1)
        local mobID = mob:getID()
        local instance = mob:getInstance()

        if mobID == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK1 then
            GetNPCByID(ID.npc._1rx, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobID == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK2 then
            GetNPCByID(ID.npc._1ry, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobID == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK3 then
            GetNPCByID(ID.npc._1rz, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobID == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK4 then
            GetNPCByID(ID.npc._jr0, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobID == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK5 then
            GetNPCByID(ID.npc._jr1, instance):setAnimation(xi.animation.OPEN_DOOR)
        end

        instance:setProgress(instance:getProgress() + 1)
    end
end

entity.onMobDespawn = function(mob)
end

return entity
