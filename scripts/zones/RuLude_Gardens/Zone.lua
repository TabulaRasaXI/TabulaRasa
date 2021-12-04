-----------------------------------
--
-- Zone: RuLude_Gardens (243)
--
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/rhapsodies")
require("scripts/globals/items")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    zone:registerRegion(1, -4, -2, 40, 4, 3, 50)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getCurrentMission(COP) == xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG and
        player:getCharVar("PromathiaStatus") == 2
    then
        cs = 10047
    end

    -- MOG HOUSE EXIT
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        local position = math.random(1, 5) + 45
        player:setPos(position, 10, -73, 192)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)

    local regionID = region:GetRegionID()

    if regionID == 1 then

        -- CRASHING WAVES
        if
            player:getCurrentMission(ROV) == xi.mission.id.rov.CRASHING_WAVES and
            player:getLocalVar("CrashingWavesBlocked") ~= 1
        then
            local metPrishe = 0
            local prisheIsSick = 0
            local prisheIsHealthy = 0
            local tenzenSword = 0

            -- TODO: Needs research of when this dialog gets enabled. Have added a condition that makes sense to me.
            if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DISTANT_BELIEFS) then
                metPrishe = 1
            end

            -- TODO: Needs research of when this dialog gets enabled. Have added a condition that makes sense to me.
            if player:getCurrentMission(COP) == xi.mission.id.cop.DARKNESS_NAMED then
                prisheIsSick = 1
            end

            -- TODO: Needs research of when this dialog gets enabled. Have added a condition that makes sense to me.
            if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) then
                prisheIsSick = 1
                prisheIsHealthy = 1
            end

            -- TODO: Needs research of when this dialog gets enabled. Have added a condition that makes sense to me.
            if player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED) then
                tenzenSword = 1
            end

            if
                xi.rhapsodies.charactersAvailable(player) and
                player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
            then
                player:startEvent(10244, metPrishe, prisheIsSick, prisheIsHealthy, tenzenSword)
            else
                player:setLocalVar("CrashingWavesBlocked", 1)
                player:startEvent(10245)
            end

        elseif
            player:getCurrentMission(COP) == xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN and
            player:getCharVar("PromathiaStatus") == 1
        then
            player:startEvent(65, player:getNation())
        elseif
            player:getCurrentMission(COP) == xi.mission.id.cop.A_PLACE_TO_RETURN and
            player:getCharVar("PromathiaStatus") == 0
        then
            player:startEvent(10048)
        elseif
            player:getCurrentMission(COP) == xi.mission.id.cop.FLAMES_IN_THE_DARKNESS and
            player:getCharVar("PromathiaStatus") == 2
        then
            player:startEvent(10051)
        elseif player:getCurrentMission(COP) == xi.mission.id.cop.DAWN then
            if
                player:getCharVar("COP_3-taru_story") == 2 and
                player:getCharVar("COP_shikarees_story") == 1 and
                player:getCharVar("COP_louverance_story") == 3 and
                player:getCharVar("COP_tenzen_story") == 1 and
                player:getCharVar("COP_jabbos_story") == 1
            then
                player:startEvent(122)
            elseif player:getCharVar("PromathiaStatus") == 7 then
                if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_AVAILABLE then
                    player:startEvent(142)
                elseif
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) == QUEST_ACCEPTED and
                    player:getCharVar('StormsOfFate') == 3
                then
                    player:startEvent(143)
                elseif
                    player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE) and
                    player:getCurrentMission(ZILART) == xi.mission.id.zilart.AWAKENING and
                    player:getMissionStatus(xi.mission.log_id.ZILART) == 3 and
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) == QUEST_AVAILABLE and
                    player:getCharVar("StormsOfFateWait") <= os.time()
                then
                    player:startEvent(161)
                elseif
                    player:hasKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER) and
                    player:hasKeyItem(xi.ki.PROMYVION_MEA_SLIVER) and
                    player:hasKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
                then
                    player:startEvent(162)
                elseif
                    player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED) and
                    player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_AVAILABLE and
                    player:getLocalVar('ANZONE') == 0 and
                    player:getCharVar("ApocNighWait") <= os.time()
                then
                    player:startEvent(123)
                end
            end
        end
    end
end

zone_object.onRegionLeave = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 65 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.A_VESSEL_WITHOUT_A_CAPTAIN)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_ROAD_FORKS) -- THE_ROAD_FORKS -- global mission 3.3
        -- We can't have more than 1 current mission at the time, so we keep The road forks as current mission
        -- progress are recorded in the following two variables
        player:setCharVar("MEMORIES_OF_A_MAIDEN_Status", 1) -- MEMORIES_OF_A_MAIDEN--3-3B: Windurst Road
        player:setCharVar("EMERALD_WATERS_Status", 1) -- EMERALD_WATERS-- 3-3A: San d'Oria Road
    elseif csid == 10047 then
        player:setCharVar("PromathiaStatus", 0)
        player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.FOR_WHOM_THE_VERSE_IS_SUNG)
        player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.A_PLACE_TO_RETURN)
    elseif csid == 10048 then
        player:setCharVar("PromathiaStatus", 1)
    elseif csid == 10051 then
        player:setCharVar("PromathiaStatus", 3)
    elseif csid == 122 then
        player:setCharVar("PromathiaStatus", 4)
        player:setCharVar("COP_3-taru_story", 0)
        player:setCharVar("COP_shikarees_story", 0)
        player:setCharVar("COP_louverance_story", 0)
        player:setCharVar("COP_tenzen_story", 0)
        player:setCharVar("COP_jabbos_story", 0)
    elseif csid == 142 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
    elseif csid == 143 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.STORMS_OF_FATE)
        player:setCharVar('StormsOfFate', 0)
        player:setCharVar("StormsOfFateWait", getVanaMidnight())
    elseif csid == 161 then
        npcUtil.giveKeyItem(player, xi.ki.NOTE_WRITTEN_BY_ESHANTARL)
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:setCharVar("StormsOfFateWait", 0)
    elseif csid == 162 then
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.SHADOWS_OF_THE_DEPARTED)
        player:delKeyItem(xi.ki.PROMYVION_HOLLA_SLIVER)
        player:delKeyItem(xi.ki.PROMYVION_DEM_SLIVER)
        player:delKeyItem(xi.ki.PROMYVION_MEA_SLIVER)
        player:messageSpecial(ID.text.YOU_HAND_THE_THREE_SLIVERS)
        player:setLocalVar('ANZONE', 1)
        player:setCharVar("ApocNighWait", getVanaMidnight())
    elseif csid == 123 then
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH)
        player:setCharVar('ApocalypseNigh', 1)
        player:setCharVar("ApocNighWait", 0)

    -- CRASHING WAVES
    elseif csid == 10244 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.CRASHING_WAVES)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.CALL_TO_SERVE)
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.MYSTIC_RETRIEVER, xi.items.CIPHER_OF_TENZENS_ALTER_EGO_II)
        else
            player:addItem(xi.items.CIPHER_OF_TENZENS_ALTER_EGO_II)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.items.CIPHER_OF_TENZENS_ALTER_EGO_II)
        end
    end
end

return zone_object
