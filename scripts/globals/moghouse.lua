-----------------------------------
-- Mog House related functions
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/utils')
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/zone")
require('scripts/globals/events/starlight_celebrations')
-----------------------------------

xi = xi or {}
xi.moghouse = xi.moghouse or {}

-----------------------------------
-- Mog Locker constants
-----------------------------------
local mogLockerStartTimestamp   = 1009810800 -- unix timestamp for 2001/12/31 15:00
local mogLockerTimestampVarName = "mog-locker-expiry-timestamp"

xi.moghouse.MOGLOCKER_ALZAHBI_VALID_DAYS    = 7
xi.moghouse.MOGLOCKER_ALLAREAS_VALID_DAYS   = 5
xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE = "mog-locker-access-type"

xi.moghouse.lockerAccessType =
{
    ALZAHBI  = 0,
    ALLAREAS = 1,
}

xi.moghouse.moghouseZones =
{
    xi.zone.AL_ZAHBI,             -- 49
    xi.zone.AHT_URHGAN_WHITEGATE, -- 50
    xi.zone.SOUTHERN_SAN_DORIA_S, -- 80
    xi.zone.BASTOK_MARKETS_S,     -- 87
    xi.zone.WINDURST_WATERS_S,    -- 94
    xi.zone.RESIDENTIAL_AREA,     -- 219
    xi.zone.SOUTHERN_SAN_DORIA,   -- 230
    xi.zone.NORTHERN_SAN_DORIA,   -- 231
    xi.zone.PORT_SAN_DORIA,       -- 232
    xi.zone.BASTOK_MINES,         -- 234
    xi.zone.BASTOK_MARKETS,       -- 235
    xi.zone.PORT_BASTOK,          -- 236
    xi.zone.WINDURST_WATERS,      -- 238
    xi.zone.WINDURST_WALLS,       -- 239
    xi.zone.PORT_WINDURST,        -- 240
    xi.zone.WINDURST_WOODS,       -- 241
    xi.zone.RULUDE_GARDENS,       -- 243
    xi.zone.UPPER_JEUNO,          -- 244
    xi.zone.LOWER_JEUNO,          -- 245
    xi.zone.PORT_JEUNO,           -- 246
    xi.zone.WESTERN_ADOULIN,      -- 256
    xi.zone.EASTERN_ADOULIN,      -- 257
}

xi.moghouse.rentARoomTable =
{
    [xi.zone.NORTHERN_SAN_DORIA]   = { nation = xi.nation.SANDORIA, csbase = 594, moveroom = 595, repeatcs = 596, hasrent  = 597, needrent = 598 },
    [xi.zone.SOUTHERN_SAN_DORIA]   = { nation = xi.nation.SANDORIA, csbase = 585, moveroom = 586, repeatcs = 587, hasrent  = 588, needrent = 589 },
    [xi.zone.PORT_SAN_DORIA]       = { nation = xi.nation.SANDORIA, csbase = 574, moveroom = 575, repeatcs = 576, hasrent  = 577, needrent = 578 },
    [xi.zone.WINDURST_WOODS]       = { nation = xi.nation.WINDURST, csbase = 362, repeatcs = 363, moveroom = 364, needrent = 365, hasrent  = 366 },
    [xi.zone.WINDURST_WATERS]      = { nation = xi.nation.WINDURST, csbase = 526, repeatcs = 527, moveroom = 528, needrent = 529, hasrent  = 530 },
    [xi.zone.WINDURST_WALLS]       = { nation = xi.nation.WINDURST, csbase = 276, repeatcs = 277, moveroom = 278, needrent = 279, hasrent  = 280 },
    [xi.zone.PORT_WINDURST]        = { nation = xi.nation.WINDURST, csbase = 299, repeatcs = 300, moveroom = 301, needrent = 302, hasrent  = 303 },
    [xi.zone.BASTOK_MINES]         = { nation = xi.nation.BASTOK,   csbase = 70                                                                  },
    [xi.zone.BASTOK_MARKETS]       = { nation = xi.nation.BASTOK,   csbase = 2                                                                   },
    [xi.zone.PORT_BASTOK]          = { nation = xi.nation.BASTOK,   csbase = 95                                                                  },
    [xi.zone.PORT_JEUNO]           = { nation = xi.nation.OTHER,    csbase = 21                                                                  },
    [xi.zone.LOWER_JEUNO]          = { nation = xi.nation.OTHER,    csbase = 97                                                                  },
    [xi.zone.UPPER_JEUNO]          = { nation = xi.nation.OTHER,    csbase = 87                                                                  },
    [xi.zone.RULUDE_GARDENS]       = { nation = xi.nation.OTHER,    csbase = 76                                                                  },
    [xi.zone.AL_ZAHBI]             = { nation = xi.nation.OTHER,    csbase = 0                                                                   },
    [xi.zone.AHT_URHGAN_WHITEGATE] = { nation = xi.nation.OTHER,    csbase = 500                                                                 },
}

xi.moghouse.rentregionBits =
{
    [xi.region.SANDORIA]        = 0,
    [xi.region.BASTOK]          = 1,
    [xi.region.WINDURST]        = 2,
    [xi.region.JEUNO]           = 3,
    [xi.region.WEST_AHT_URHGAN] = 7,
}

xi.moghouse.nationRegionBits =
{
    [xi.nation.SANDORIA] = xi.region.SANDORIA,
    [xi.nation.BASTOK]   = xi.region.BASTOK,
    [xi.nation.WINDURST] = xi.region.WINDURST,
}

xi.moghouse.isInMogHouseInHomeNation = function(player)
    if not player:isInMogHouse() then
        return false
    end

    local currentZone = player:getZoneID()
    local nation      = player:getNation()

    -- TODO: Simplify nested conditions
    if nation == xi.nation.BASTOK then
        if
            currentZone >= xi.zone.BASTOK_MINES and
            currentZone <= xi.zone.PORT_BASTOK
        then
            return true
        end
    elseif nation == xi.nation.SANDORIA then
        if
            currentZone >= xi.zone.SOUTHERN_SAN_DORIA and
            currentZone <= xi.zone.PORT_SAN_DORIA
        then
            return true
        end
    else
        if
            currentZone >= xi.zone.WINDURST_WATERS and
            currentZone <= xi.zone.WINDURST_WOODS
        then
            return true
        end
    end

    return false
end

xi.moghouse.moogleTrade = function(player, npc, trade)
    if player:isInMogHouse() then
        local numBronze = trade:getItemQty(xi.items.IMPERIAL_BRONZE_PIECE)

        if numBronze > 0 then
            if xi.moghouse.addMogLockerExpiryTime(player, numBronze) then
                player:tradeComplete()
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET + 2, xi.moghouse.getMogLockerExpiryTimestamp(player))
            end
        end
    end
end

xi.moghouse.moogleTrigger = function(player, npc)

    if player:isInMogHouse() then

        if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
            if xi.moghouse.isInMogHouseInHomeNation(player) then
                local treePlaced = player:getCharVar("[StarlightMisc]TreePlaced")
                local placedDay = player:getCharVar("[StarlightMisc]TreeTimePlaced")
                local earnedReward = player:getCharVar("[StarlightMisc]DreamHatHQ")
                local hasItem = player:hasItem(xi.items.DREAM_HAT_P1)
                local hasPresent = player:hasItem(xi.items.SPECIAL_PRESENT)
                local currentDay = VanadielUniqueDay()

                if treePlaced ~= 0 then
                    if (earnedReward ~= 1) or (not hasItem and not hasPresent) then
                        local sandOrianTree = player:getCharVar("[StarlightMisc]SandOrianTree")
                        local bastokanTree = player:getCharVar("[StarlightMisc]BastokanTree")
                        local windurstianTree = player:getCharVar("[StarlightMisc]WindurstianTree")
                        local jeunoanTree = player:getCharVar("[StarlightMisc]JeunoanTree")
                        local holidayFame = player:getFameLevel(xi.quest.fame_area.HOLIDAY)

                        if (placedDay < currentDay) then
                            if holidayFame == 9 then
                                if sandOrianTree == 1 then
                                    player:startEvent(30017, 0, 0, 0, 86)
                                elseif bastokanTree == 1 then
                                    player:startEvent(30017, 0, 0, 0, 115)
                                elseif windurstianTree == 1 then
                                    player:startEvent(30017, 0, 0, 0, 116)
                                elseif jeunoanTree == 1 then
                                    player:startEvent(30017, 0, 0, 0, 138)
                                end
                            end
                        end
                    end
                end
            end
        end

        local lockerTs = xi.moghouse.getMogLockerExpiryTimestamp(player)

        if lockerTs ~= nil then
            if lockerTs == -1 then -- Expired
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET + 1, xi.items.IMPERIAL_BRONZE_PIECE)
            else
                player:messageSpecial(zones[player:getZoneID()].text.MOG_LOCKER_OFFSET, lockerTs)
            end
        end

        player:sendMenu(1)
    end
end

xi.moghouse.moogleEventUpdate = function(player, csid, option)
end

xi.moghouse.moogleEventFinish = function(player, csid, option)
    if csid == 30017 and option == 0 then
        local invAvailable = player:getFreeSlotsCount()

        if invAvailable ~= 0 then
            player:setCharVar("[StarlightMisc]DreamHatHQ", 1)
        end

        npcUtil.giveItem(player, 5269)
    end
end

-- Unlocks a mog locker for a player. Returns the 'expired' timestamp (-1)
xi.moghouse.unlockMogLocker = function(player)
    player:setCharVar(mogLockerTimestampVarName, -1)

    -- Safety check in case some servers auto-set 80 slots for mog locker items.
    if player:getContainerSize(xi.inv.MOGLOCKER) == 0 then
        player:changeContainerSize(xi.inv.MOGLOCKER, 30)
    end

    return -1
end

-- Sets the mog locker access type (all area or alzahbi only). Returns the new access type.
xi.moghouse.setMogLockerAccessType = function(player, accessType)
    player:setCharVar(xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE, accessType)

    return accessType
end

-- Gets the mog locker access type (all area or alzahbi only). Returns the new access type.
xi.moghouse.getMogLockerAccessType = function(player)
    return player:getCharVar(xi.moghouse.MOGLOCKER_PLAYERVAR_ACCESS_TYPE)
end

-- Gets the expiry time for your locker. A return value of -1 is expired. A return value of nil means mog locker hasn't been unlocked.
xi.moghouse.getMogLockerExpiryTimestamp = function(player)
    local expiryTime = player:getCharVar(mogLockerTimestampVarName)

    if expiryTime == 0 then
        return nil
    end

    local now = os.time() - mogLockerStartTimestamp

    if now > expiryTime then
        player:setCharVar(mogLockerTimestampVarName, -1)

        return -1
    end

    return expiryTime
end

-- Adds time to your mog locker, given the number of bronze coins.
-- The amount of time per bronze is affected by the access type
-- The expiry time itself is the number of seconds past 2001/12/31 15:00
-- Returns true if time was added successfully, false otherwise.
xi.moghouse.addMogLockerExpiryTime = function(player, numBronze)
    local accessType       = xi.moghouse.getMogLockerAccessType(player)
    local numDaysPerBronze = 5

    if accessType == xi.moghouse.lockerAccessType.ALZAHBI then
        numDaysPerBronze = 7
    end

    local currentTs = xi.moghouse.getMogLockerExpiryTimestamp(player)

    if currentTs == nil then
        return false
    end

    if currentTs == -1 then
        currentTs = os.time() - mogLockerStartTimestamp
    end

    local timeIncrease = 60 * 60 * 24 * numDaysPerBronze * numBronze
    local newTs        = currentTs + timeIncrease

    player:setCharVar(mogLockerTimestampVarName, newTs)

    -- Send an invent size packet to enable the items if they weren't.
    player:changeContainerSize(xi.inv.MOGLOCKER, 0)

    return true
end

xi.moghouse.exitJobChange = function(player, prevZone)
    if player:getCharVar('[Moghouse]Exit_Pending') == 1 and prevZone == player:getZoneID() then
        player:setVolatileCharVar('[Moghouse]Exit_Pending', 0)
        if xi.settings.map.MH_EXIT_HOMEPOINT then
            if player:getCharVar('[Moghouse]Exit_Job_Change') == 1 and not player:isCurrentHomepoint() then
                player:timer(100, function(playerArg)
                    playerArg:startEvent(30004, 1)
                end)
            end
        end
    else
        player:setVolatileCharVar('[Moghouse]Exit_Job_Change', 0)
    end
end

xi.moghouse.exitJobChangeFinish = function(player, csid, option)
    if xi.settings.map.MH_EXIT_HOMEPOINT then
        if csid == 30004 and option == 0 then
            player:setHomePoint()
        elseif csid == 30004 then
            player:setVolatileCharVar('[Moghouse]Exit_Job_Change', 0)
        end
    end
end

xi.moghouse.nationrRentARoom = function(player, npc, zonetable, regionid)
    local rentregion = player:getCharVar("[Moghouse]Rent-A-Room")
    if player:getNation() == zonetable.nation then
        if player:getCharVar("[Moghouse]GuardSpeech") == 0 then -- First time talking to guard.
            player:setCharVar("[Moghouse]GuardSpeech", 1)
            player:startEvent(zonetable.csbase)
        elseif rentregion ~= regionid and xi.settings.map.ERA_RENT_A_ROOM then -- Needs to move room.
            player:startEvent(zonetable.moveroom, xi.moghouse.rentregionBits[rentregion])
        else
            player:startEvent(zonetable.repeatcs) -- Second time talking to guard with room in city.
        end
    else
        if rentregion ~= regionid then
            player:startEvent(zonetable.needrent) -- Needs Registration
        else
            player:startEvent(zonetable.hasrent) -- Already Registered
        end
    end
end

xi.moghouse.onTriggerRentARoom = function(player, npc)
    local zonetable = xi.moghouse.rentARoomTable[player:getZoneID()]
    local regionid  = player:getZone():getRegionID()
    local rentregion = player:getCharVar("[Moghouse]Rent-A-Room")

    if regionid == xi.region.BASTOK then
        player:startEvent(zonetable.csbase, player:getNation(), xi.moghouse.rentregionBits[rentregion])
    elseif regionid == xi.region.SANDORIA or regionid == xi.region.WINDURST then
        xi.moghouse.nationrRentARoom(player, npc, zonetable, regionid)
    else
        player:startEvent(zonetable.csbase, xi.moghouse.rentregionBits[rentregion])
    end
end

xi.moghouse.onEventFinishRentARoom = function(player, csid, option)
    local regionid  = player:getZone():getRegionID()
    local zonetable = xi.moghouse.rentARoomTable[player:getZoneID()]

    if regionid == xi.region.BASTOK and csid == zonetable.csbase and option == 2 then
        player:setCharVar("[Moghouse]Rent-a-room", player:getZone():getRegionID())
    elseif regionid == xi.region.SANDORIA or regionid == xi.region.WINDURST then
        if (csid == zonetable.moveroom or csid == zonetable.needrent) and option == 0 then -- Is a Visitor or Citizen Who Moved Rooms
            player:setCharVar("[Moghouse]Rent-a-room", player:getZone():getRegionID())
        end
    else
        if option == 0 then
            player:setCharVar("[Moghouse]Rent-a-room", player:getZone():getRegionID())
        end
    end
end

xi.moghouse.isRented = function(player)
    local playerzone = player:getZoneID()
    local isrentexempt = (playerzone >= xi.zone.SOUTHERN_SAN_DORIA_S and playerzone <= xi.zone.WINDURST_WATERS_S) or (playerzone >= xi.zone.WESTERN_ADOULIN and playerzone <= xi.zone.EASTERN_ADOULIN)

    if isrentexempt or not xi.settings.map.RENT_A_ROOM then
        return true
    end

    local playerregion = player:getZone():getRegionID()
    local ishomenation = playerregion == xi.moghouse.nationRegionBits[player:getNation()]
    local isrentedcity = playerregion == player:getCharVar("[Moghouse]Rent-a-room")

    if xi.settings.map.RENT_A_ROOM and utils.ternary(xi.settings.map.ERA_RENT_A_ROOM, isrentedcity, ishomenation or isrentedcity) then
        return true
    end

    return false
end
