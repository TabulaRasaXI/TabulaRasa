-----------------------------------
-- Garrison
-----------------------------------
require("scripts/globals/mobs")
require("scripts/globals/common")
require("scripts/globals/garrison_data")
require("scripts/globals/npc_util")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/pathfind")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}
xi.garrison.lookup = xi.garrison.lookup or {}
-----------------------------------
-- Helpers
-----------------------------------
xi.garrison.onWin = function(player, npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local garrisonLoot = {}
    local text = zones[zoneId].text
    garrisonLoot = xi.garrison.loot[garrisonZoneData.levelCap]
    -- Talk to NPC to Remove effects
    for _, v in ipairs(player:getAlliance()) do
        v:setCharVar(string.format("[GARRISON]Status_%s", zoneId), 1)
        v:addGil(xi.settings.main.GIL_RATE*2000)
        v:messageSpecial(text.GIL_OBTAINED, xi.settings.main.GIL_RATE*2000)
    end
    -- Add loot to Treasure Pool
    for _, loot in pairs(garrisonLoot) do
        local roll = math.random(0,1000)
        if roll <= loot.dropRate then
            player:addTreasure(loot.itemId)
        end
    end
    player:setCharVar(string.format("[GARRISON]Status_%s", zoneId), 0)
    -- Talk to Guard to Remove effects
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    player:delStatusEffect(xi.effect.BATTLEFIELD)
    -- They dont despawn until party leader talks to gaurd
    xi.garrison.despawnNPCs(npc)
    -- Reset Garrison lockout and Time Limit
    npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time())
    npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time())
end

xi.garrison.onLose = function(player, npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local zone = player:getZone()
    local boss   = zone:queryEntitiesByName(garrisonZoneData.mobBoss)[1]
    local bossId = boss:getID()
    local mob = bossId - 8
    local mobnum = 1
    -- Talk to NPC to Remove effects
    for _, v in ipairs(player:getAlliance()) do
        v:setCharVar(string.format("[GARRISON]Status_%s", zoneId), 2)
    end
    -- Despawn all the mobs
    while mobnum <= 9 do
        DespawnMob(mob)
        mobnum = mobnum + 1
        mob = mob + 1
    end
    -- Despawn all the NPCs
    xi.garrison.despawnNPCs(npc)
    -- Reset Garrison lockout and Time Limit
    npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time())
    npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time())
end

xi.garrison.onStatusRemove = function(player, npc)
    local zoneId = npc:getZoneID()
    -- Talk to Guard to Remove effects
    player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
    player:delStatusEffect(xi.effect.BATTLEFIELD)
    player:setCharVar(string.format("[GARRISON]Status_%s", zoneId), 0)
end

xi.garrison.mobsAlive = function(player)
    local zoneId = player:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local killedAllMobs = true
    local zone = player:getZone()
    local boss   = zone:queryEntitiesByName(garrisonZoneData.mobBoss)[1]
    local bossId = boss:getID()
    local mob = bossId - 8
    local mobnum = 1
    -- Check all mobs if alive
    while mobnum <= 9 do
        if GetMobByID(mob):isAlive() then
            killedAllMobs = false
        end
        mobnum = mobnum + 1
        mob = mob + 1
    end
    -- Return result
    if killedAllMobs == false then
        return true
    else
        return false
    end
end

xi.garrison.npcAlive = function(player)
    local zoneId = player:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local killedAllNPC = true
    -- Check all NPCs are dead
    for _, npcID in pairs(npcs) do
        if GetMobByID(npcID):isAlive() then
            killedAllNPC = false
        end
    end
    -- Return result
    if killedAllNPC == false then
        return true
    else
        return false
    end
end

xi.garrison.despawnNPCs = function(npc)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    for _, npcID in ipairs(npcs) do
        DespawnMob(npcID)
    end
end

xi.garrison.clearNPCs = function(zone)
    local zoneId = zone:getID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    for _, npcID in ipairs(npcs) do
        DespawnMob(npcID)
    end
end

xi.garrison.returnHome = function(mob)
  if mob:getRoamFlags() == xi.roamFlag.NONE then
    local spawn = mob:getSpawnPos()
    local current = mob:getPos()
    if spawn.x ~= current.x or spawn.z ~= current.z then
      mob:pathTo(spawn.x, spawn.y, spawn.z, xi.path.flag.NONE)
    end
  end
end

xi.garrison.npcTableEmpty = function(zone)
    local zoneId = zone:getID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local npcs = garrisonZoneData.npcs
    local npcEmpty = true
    -- Check if npc table is empty
    for _, npcID in pairs(npcs) do
        npcEmpty = false
    end
    -- Return result
    if npcEmpty == false then
        return false
    else
        return true
    end
end

xi.garrison.shuffle = function(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end
-----------------------------------
-- Main Functions
-----------------------------------
xi.garrison.tick = function(player, npc, wave, party)
    print("Garrison Tick wave:", wave)
    local zoneId = npc:getZoneID()
    local garrisonRunning = npc:getZone():getLocalVar(string.format("[GARRISON]EndTime_%s", zoneId))
    -- Check all NPCs are dead -> lose
    if
        xi.garrison.mobsAlive(player) == false and
        wave == 4 and
        xi.garrison.npcAlive(player, party) == true
    then
        -- Win
        player:setCharVar(string.format("[GARRISON]Status_%s", zoneId), garrisonRunning)
    elseif
        xi.garrison.mobsAlive(player) == false and
        wave <=3 and
        xi.garrison.npcAlive(player, party) == true
    then
        -- Next wave
        wave = wave + 1
        npc:timer(30000, function(npcArg)
            xi.garrison.spawnWave(player, npc, wave, party)
        end)
    elseif
        xi.garrison.npcAlive(player, party) == false or
        os.time() >= garrisonRunning
    then
        -- lose
        xi.garrison.onLose(player, npc)
    else
        -- Start next tick
        npc:timer(10000, function(npcArg)
            xi.garrison.tick(player, npc, wave, party)
        end)
    end
end

xi.garrison.spawnNPCs = function(npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local xPos = garrisonZoneData.xPos
    local yPos = garrisonZoneData.yPos
    local zPos = garrisonZoneData.zPos
    local rot = garrisonZoneData.rot
    local npcnum = 1
    local npcs = garrisonZoneData.npcs
    for _, mobId in pairs(npcs) do
    local mob = GetMobByID(mobId)
        if npcnum <= party then
        mob:setSpawn(xPos, yPos, zPos, rot)
        mob:setRoamFlags(xi.roamFlag.NONE)
        mob:spawn()
        DisallowRespawn(mob:getID(), true)
        mob:setMobLevel(garrisonZoneData.levelCap - math.floor(garrisonZoneData.levelCap / 5))
        mob:setSpeed(25)
        -- BATTLEFIELD this is to prevent outside help, is not retail
        mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
        mob:setAllegiance(1)
        if npcnum == 6 then
            xPos = garrisonZoneData.xPos - garrisonZoneData.xSecondLine
            zPos = garrisonZoneData.zPos - garrisonZoneData.zSecondLine
        elseif npcnum == 12 then
            xPos = garrisonZoneData.xPos - garrisonZoneData.xThirdLine
            zPos = garrisonZoneData.zPos - garrisonZoneData.zThirdLine
        else
            xPos = xPos - garrisonZoneData.xChange
            zPos = zPos - garrisonZoneData.zChange
        end
        npcnum = npcnum + 1
        end
    end
end

xi.garrison.spawnWave = function(player, npc, wave, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local allianceSize = 0
    local zone = player:getZone()
    local boss   = zone:queryEntitiesByName(garrisonZoneData.mobBoss)[1]
    local bossId = boss:getID()
    local npcs = garrisonZoneData.npcs
    local mobCount = 1
    -- Get wave size based on alliance size
    if party >= 1 then
        allianceSize = wave + 0
    end
    if party > 6 then
        allianceSize = wave + 1
    end
    if party > 12 then
        allianceSize = wave + 2
    end
    allianceSize = math.min(allianceSize, 4)
    -- Spawn mobs in 15 second intervals random from table (2 per interval in 1 party, 4 per interval in alliances)
    xi.garrison.shuffle(garrisonZoneData.waveOrder[allianceSize])
    for _, mobId in ipairs(garrisonZoneData.waveOrder[allianceSize]) do
        if
            (mobCount == 3 or mobCount == 4) and
            party <= 6
        then
            npc:timer(15000, function(npcArg)
                SpawnMob(bossId - mobId)
                -- BATTLEFIELD this is to prevent outside help, is not retail
                GetMobByID(bossId - mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
                for _, npcID in ipairs(npcs) do
                    if GetMobByID(npcID):isAlive() then
                        GetMobByID(bossId - mobId):addEnmity(GetMobByID(npcID), 1, 1)
                    end
                end
            end)
            mobCount = mobCount + 1
        elseif
            (mobCount == 5 or mobCount == 6) and
            party <= 6
        then
            npc:timer(30000, function(npcArg)
                SpawnMob(bossId - mobId)
                -- BATTLEFIELD this is to prevent outside help, is not retail
                GetMobByID(bossId - mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
                for _, npcID in ipairs(npcs) do
                    if GetMobByID(npcID):isAlive() then
                        GetMobByID(bossId - mobId):addEnmity(GetMobByID(npcID), 1, 1)
                    end
                end
            end)
            mobCount = mobCount + 1
        elseif
            (mobCount == 7 or mobCount == 8) and
            party <= 6
        then
            npc:timer(45000, function(npcArg)
                SpawnMob(bossId - mobId)
                -- BATTLEFIELD this is to prevent outside help, is not retail
                GetMobByID(bossId - mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
                for _, npcID in ipairs(npcs) do
                    if GetMobByID(npcID):isAlive() then
                        GetMobByID(bossId - mobId):addEnmity(GetMobByID(npcID), 1, 1)
                    end
                end
            end)
            mobCount = mobCount + 1
        elseif
            mobCount >= 5 and
            party > 6
        then
            npc:timer(15000, function(npcArg)
                SpawnMob(bossId - mobId)
                -- BATTLEFIELD this is to prevent outside help, is not retail
                GetMobByID(bossId - mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
                for _, npcID in ipairs(npcs) do
                    if GetMobByID(npcID):isAlive() then
                        GetMobByID(bossId - mobId):addEnmity(GetMobByID(npcID), 1, 1)
                    end
                end
            end)
            mobCount = mobCount + 1
        else
            SpawnMob(bossId - mobId)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            GetMobByID(bossId - mobId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            for _, npcID in ipairs(npcs) do
                if GetMobByID(npcID):isAlive() then
                    GetMobByID(bossId - mobId):addEnmity(GetMobByID(npcID), 1, 1)
                end
            end
            mobCount = mobCount + 1
        end
    end
    -- Wave 4 spawn boss and restart tick or restart tick
    if wave == 4 then
        npc:timer(60000, function(npcArg)
            -- Spawn boss after 1 minute
            SpawnMob(bossId)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            GetMobByID(bossId):addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            for _, npcID in ipairs(npcs) do
                if GetMobByID(npcID):isAlive() then
                    GetMobByID(bossId):addEnmity(GetMobByID(npcID), 1, 1)
                end
            end
            -- Start tick again
            xi.garrison.tick(player, npc, wave, party)
        end)
    else
        -- Start tick again tick shouldnt start until all mobs have been spawned (even if all npcs died before wave completes all mobs spawn)
        npc:timer(60000, function(npcArg)
            xi.garrison.tick(player, npc, wave, party)
        end)
    end
end

xi.garrison.start = function(player, npc, party)
    local zoneId = npc:getZoneID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local timeLimit = xi.settings.main.GARRISON_TIME_LIMIT
    local wave = 1
    -- Apply level restriction
        for _, v in ipairs(player:getAlliance()) do
            -- Make sure they are in the same zone
            if v:getZoneID() == zoneId then
                if garrisonZoneData.levelCap < 75 then
                    v:addStatusEffect(xi.effect.LEVEL_RESTRICTION, garrisonZoneData.levelCap, 0, os.time() + timeLimit)
                end
                -- BATTLEFIELD this is to prevent outside help, is not retail
                v:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, os.time() + timeLimit)
            end
        end
    -- Make sure no npcs are floating around still
    xi.garrison.despawnNPCs(npc)
    -- Wait 3 seconds before spawning everything
    npc:timer(3000, function(npcArg)
        -- Spawn NPCs
        xi.garrison.spawnNPCs(npc, party)
        -- Start First Wave
        xi.garrison.spawnWave(player, npc, wave, party)
    end)
end

xi.garrison.onTrade = function(player, npc, trade, guardNation)
    -- TODO: Check to see if there is Ballista in the Zone
    -- Offset 41 This area is currently conducting a Ballista match. I have no time to trouble myself with your beastman trinkets.
    -- TODO: Check to see if party has a fellow
    -- Offset 42 A party member has an NPC called up. You cannot take part in this event.
    local zoneId = npc:getZoneID()
    local zone = player:getZone()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local text = zones[zoneId].text
    local lockout = xi.settings.main.GARRISON_LOCKOUT
    local timeLimit = xi.settings.main.GARRISON_TIME_LIMIT
    local garrisonRunning = npc:getZone():getLocalVar(string.format("[GARRISON]LockOut_%s", zoneId))
    local item = garrisonZoneData.itemReq
    local nation = player:getNation()
    local rank = player:getRank(nation)
    local region = garrisonZoneData.textRegion
    local levelCapOffset = 0
    local nationOffset = 1
    -- Nation text offset
    if nation == 0 then
        nationOffset = 3
    elseif nation == 1 then
        nationOffset = 14
    elseif nation == 2 then
        nationOffset = 25
    end
    -- Levelcap text offset
    if garrisonZoneData.levelCap == 20 then
        levelCapOffset = 0
    elseif garrisonZoneData.levelCap == 30 then
        levelCapOffset = 3
    elseif garrisonZoneData.levelCap == 40 then
        levelCapOffset = 5
    elseif garrisonZoneData.levelCap == 50 then
        levelCapOffset = 7
    elseif garrisonZoneData.levelCap == 75 then
        levelCapOffset = 9
    end
    -- Collect entrant information
    local party = player:getAlliance()
    -- Gets party size for spawning each NPC
    party = #party
    -- Make sure the trade has the item before doing other checks
    if npcUtil.tradeHasExactly(trade, item) then
        -- Player has traded the right garrison item now perfom garrison checks
        if
            os.time() > garrisonRunning and
            party <= xi.settings.main.GARRISON_PARTY_LIMIT and
            rank >= xi.settings.main.GARRISON_RANK and
            ( xi.settings.main.GARRISON_ONCE_PER_WEEK == 1 or player:getCharVar("GARRISON_CONQUEST_WAIT") < os.time() ) and
            ( player:getNation() == guardNation or xi.settings.main.GARRISON_NATION_BYPASS == 1 )
        then
            if xi.garrison.npcTableEmpty(zone) == true then
                xi.garrison.buildNpcTable(zone)
            end
            npc:timer(1000, function(npcArg)
                xi.garrison.start(player, npc, party)
            end)
            player:confirmTrade()
            player:setCharVar("GARRISON_CONQUEST_WAIT", getConquestTally())
            npc:getZone():setLocalVar(string.format("[GARRISON]EndTime_%s", zoneId), os.time() + timeLimit)
            npc:getZone():setLocalVar(string.format("[GARRISON]LockOut_%s", zoneId), os.time() + lockout)
            -- Starting dialog
            npc:timer(200, function(npcArg)
                player:messageSpecial(text.GARRISON_BASE + 2)
            end)
            -- Nation dialog depending on which level cap
            npc:timer(400, function(npcArg)
                player:messageSpecial(text.GARRISON_BASE + nationOffset + levelCapOffset, 0, 0, region)
            end)
            -- More nation dialog
            npc:timer(600, function(npcArg)
                player:messageSpecial(text.GARRISON_BASE + nationOffset + levelCapOffset + 1)
            end)
            -- Additional dialog for level cap 20 zones
            if garrisonZoneData.levelCap == 20 then
                npc:timer(800, function(npcArg)
                    player:messageSpecial(text.GARRISON_BASE + nationOffset + levelCapOffset + 2)
                end)
            end
        elseif
            xi.settings.main.GARRISON_ONCE_PER_WEEK == 0 and
            player:getCharVar("GARRISON_CONQUEST_WAIT") > os.time()
        then
            -- Limit Once Per Week
            player:messageSpecial(text.GARRISON_BASE + 40)
        elseif
            player:getNation() ~= guardNation and
            xi.settings.main.GARRISON_NATION_BYPASS == 0
        then
            -- Not of nation event
            player:messageSpecial(text.GARRISON_BASE, trade:getItem():getID(), player:getNation())
        else
            -- Requirements not met
            player:messageSpecial(text.GARRISON_BASE + 1)
        end
    end
end
-- Get dialog fron guard after winning or losing
xi.garrison.onTrigger = function(player, npc)
    local zoneId = npc:getZoneID()
    local text = zones[zoneId].text
    local status = player:getCharVar(string.format("[GARRISON]Status_%s", zoneId))
    if status >= os.time() then
        -- Trader Won
        player:messageSpecial(text.GARRISON_BASE + 36)
        xi.garrison.onWin(player, npc)
    elseif status == 1 then
        -- Party Member Won
        player:messageSpecial(text.GARRISON_BASE + 39)
        xi.garrison.onStatusRemove(player, npc)
    elseif status == 2 then
        -- Party Member Lost
        player:messageSpecial(text.GARRISON_BASE + 37)
        xi.garrison.onStatusRemove(player, npc)
    elseif
        status < os.time() and
        status > 2
    then
        -- Trader took too long to claim prize lose
        player:messageSpecial(text.GARRISON_BASE + 37)
        xi.garrison.onLose(player, npc)
    end
end
-- Zone tick Create NPC Tables if empty
xi.garrison.buildNpcTable = function(zone)
    local region = zone:getRegionID()
    local owner = GetRegionOwner(region)
    local zoneId = zone:getID()
    local garrisonZoneData = xi.garrison.data[zoneId]
    local garrisonRunning = zone:getLocalVar(string.format("[GARRISON]EndTime_%s", zoneId))
    if owner < 3 then
        local npcs = garrisonZoneData.npcs
        local xPos = garrisonZoneData.xPos
        local yPos = garrisonZoneData.yPos
        local zPos = garrisonZoneData.zPos
        local rot = garrisonZoneData.rot
        local npcName = xi.garrison.names[garrisonZoneData.levelCap][owner].npcName
        local npcLook = xi.garrison.looks[garrisonZoneData.levelCap][owner]
        local npcnum = 1
        while npcnum <= 18 do
            xi.garrison.shuffle(npcLook)
            local mob = zone:insertDynamicEntity({
                objtype = xi.objType.MOB,
                name = npcName,
                look = npcLook[1],
                x = xPos,
                y = yPos,
                z = zPos,
                rotation = rot,
                groupId = 1,
                groupZoneId = 210,
                onMobRoam = function(mob) xi.garrison.returnHome(mob) end,
                onMobDeath = function(mob, playerArg, isKiller) end,
                releaseIdOnDeath = false,
            })
            mob:setSpawn(xPos, yPos, zPos, rot)
            mob:setRoamFlags(xi.roamFlag.NONE)
            mob:spawn()
            mob:setMobLevel(garrisonZoneData.levelCap - math.floor(garrisonZoneData.levelCap / 5))
            DisallowRespawn(mob:getID(), true)
            -- BATTLEFIELD this is to prevent outside help, is not retail
            mob:addStatusEffect(xi.effect.BATTLEFIELD, 1, 0, 0)
            mob:setAllegiance(1)
            if npcnum == 6 then
                xPos = garrisonZoneData.xPos - garrisonZoneData.xSecondLine
                zPos = garrisonZoneData.zPos - garrisonZoneData.zSecondLine
            elseif npcnum == 12 then
                xPos = garrisonZoneData.xPos - garrisonZoneData.xThirdLine
                zPos = garrisonZoneData.zPos - garrisonZoneData.zThirdLine
            else
                xPos = xPos - garrisonZoneData.xChange
                zPos = zPos - garrisonZoneData.zChange
            end
            npcnum = npcnum + 1
            table.insert(npcs, mob:getID())
        end
    end
    -- despawn any npc if garrison isnt running
    if os.time() >= garrisonRunning then
        xi.garrison.clearNPCs(zone)
    end
end
