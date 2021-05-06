-----------------------------------
-- Return to Delkfutt's Tower
-- Zilart M8
-----------------------------------
require('scripts/globals/interaction/mission')
require("scripts/globals/keyitems")
require('scripts/globals/missions')
require("scripts/globals/titles")
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.ZILART, xi.mission.id.zilart.RETURN_TO_DELKFUTTS_TOWER)

mission.reward =
{
    nextMission = { xi.mission.log_id.ZILART, xi.mission.id.zilart.ROMAEVE },
}

mission.sections =
{
    -- Section: Mission Active
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] = mission:event(13)
        },

        [xi.zone.STELLAR_FULCRUM] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 0
                end,
            },

            onEventFinish =
            {
                [17] = function(player, csid, option, npc)
                    mission:complete(player)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 0)   
                end,

                [32001] = function(player, csid, option, npc)
                    -- Play last CS if not skipped.
                    if player:getLocalVar("battlefieldWin") == 256 then
                        if option == 1 then
                            return mission:event(17)
                        else
                            mission:complete(player)
                            player:setMissionStatus(xi.mission.log_id.ZILART, 0)                        
                        end
                    end
                end,
            },
        },
    },

    -- Section: Mission Active and missionStatus == 0
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus == 0
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Aldo'] = mission:event(104),

            onEventFinish =
            {
                [104] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 1)
                end,
            },
        },
    },

    -- Section: Mission Active and missionStatus <= 1
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and missionStatus <= 1
        end,

        [xi.zone.LOWER_DELKFUTTS_TOWER] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    return 15
                end,
            },

            onEventFinish =
            {
                [15] = function(player, csid, option, npc)
                    player:setMissionStatus(xi.mission.log_id.ZILART, 2)
                end,
            },
        },
    },
}

return mission
