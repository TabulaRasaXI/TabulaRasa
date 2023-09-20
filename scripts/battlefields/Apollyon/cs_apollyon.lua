-----------------------------------
-- Area: Apollyon
-- Name: CS Apollyon
-- !addkeyitem black_card
-- !addkeyitem cosmo_cleanse
-- !additem 2127
-- !pos 600 -0.5 -600 38
-----------------------------------
local ID = require("scripts/zones/Apollyon/IDs")
require("scripts/globals/battlefield")
require("scripts/globals/limbus")
require("scripts/globals/items")
require("scripts/globals/keyitems")
-----------------------------------

local content = Limbus:new({
    zoneId           = xi.zone.APOLLYON,
    battlefieldId    = xi.battlefield.id.CS_APOLLYON,
    maxPlayers       = 18,
    timeLimit        = utils.minutes(20),
    index            = 5,
    area             = 6,
    entryNpc         = '_12i',
    requiredKeyItems = { xi.ki.COSMO_CLEANSE, { xi.ki.RED_CARD, xi.ki.BLACK_CARD }, message = ID.text.YOU_INSERT_THE_CARD_POLISHED },
    requiredItems    = { xi.items.METAL_CHIP },
    name             = "CS_APOLLYON",
    timeExtension   = 5,
})

function content:isValidEntry(player, npc)
    return self.entryNpc == '_12i' or self.entryNpc == '_127'
end

function content:onEntryEventUpdate(player, csid, option, npc)
    if Battlefield.onEntryEventUpdate(self, player, csid, option, npc) then
        if npc:getName() == '_12i' then
            self.exitLocation = 1
            self.lossEventParams  = { [5] = 1 }
        else
            self.exitLocation = 0
            self.lossEventParams  = {}
        end
    end
end

function content:onBattlefieldTick(battlefield, tick)
    Battlefield.onBattlefieldTick(self, battlefield, tick)

    -- Do nothing unless the battlefield has been locked due to engaged
    if battlefield:getStatus() ~= xi.battlefield.status.LOCKED then
        return
    end

    -- Do nothing if aggroTime hasn't been set or aggroTime hasn't been reached yet
    local now = os.time()
    local aggroTime = battlefield:getLocalVar("AutoAggroTime")
    if aggroTime == 0 or aggroTime > now then
        return
    end

    -- Get which player is going to be aggrod
    local player = GetPlayerByID(battlefield:getLocalVar("AutoAggroTarget"))
    if player:isDead() then
        -- Need to find a new target
        local players = battlefield:getPlayers()
        for _, battlefieldPlayer in pairs(players) do
            if battlefieldPlayer:isAlive() then
                player = battlefieldPlayer
                break
            end
        end
    end

    -- Determine which boss should aggro next
    local previousBoss = battlefield:getLocalVar("AutoAggro")
    local nextBoss = 0
    if previousBoss == ID.CS_APOLLYON.mob.CARNAGECHIEF_JACKBODOKK then
        nextBoss = ID.CS_APOLLYON.mob.DEE_WAPA_THE_DESOLATOR
    elseif previousBoss == ID.CS_APOLLYON.mob.DEE_WAPA_THE_DESOLATOR then
        nextBoss = ID.CS_APOLLYON.mob.NAQBA_CHIRURGEON
    else
        nextBoss = ID.CS_APOLLYON.mob.CARNAGECHIEF_JACKBODOKK
    end

    local boss = GetMobByID(nextBoss)

    battlefield:setLocalVar("AutoAggro", boss:getID())
    battlefield:setLocalVar("AutoAggroTime", os.time() + utils.minutes(7))
    battlefield:setLocalVar("AutoAggroTarget", player:getID())

    if boss:isAlive() then
        boss:updateEnmity(player)
    end
end

function content:onBattlefieldWipe(battlefield, players)
    Battlefield.onBattlefieldWipe(self, battlefield, players)
    battlefield:setLocalVar("AutoAggro", 0)
    battlefield:setLocalVar("AutoAggroTime", 0)
    battlefield:setLocalVar("AutoAggroTarget", 0)
end

function content.handleBossCombatTick(boss, supportOffsets, otherSupportOffsets)
    local group = boss:getLocalVar("supportGroup")
    local offsets = group == 1 and supportOffsets or otherSupportOffsets
    local bossID = boss:getID()

    for _, offset in ipairs(offsets) do
        if GetMobByID(bossID + offset):getStatus() ~= xi.status.DISAPPEAR then
            return
        end
    end

    boss:injectActionPacket(boss:getID(), 11, 432, 0, 24, 0, 603, 0)

    local bossX = boss:getXPos()
    local bossY = boss:getYPos()
    local bossZ = boss:getZPos()

    offsets = group == 0 and supportOffsets or otherSupportOffsets
    for _, offset in ipairs(offsets) do
        local support = GetMobByID(bossID + offset)
        support:setSpawn(bossX + math.random(-2, 2), bossY, bossZ + math.random(-2, 2))
        support:spawn()
    end

    -- Alternate which support group to spawn
    boss:setLocalVar("supportGroup", (group + 1) % 2)
end

function content.handleBossAutoAggro(mob, target)
    local mobBattlefield = mob:getBattlefield()
    -- Do nothing if auto-aggro is already setup
    if mobBattlefield:getLocalVar("AutoAggro") ~= 0 then
        return
    end

    mobBattlefield:setLocalVar("AutoAggro", mob:getID())
    mobBattlefield:setLocalVar("AutoAggroTime", os.time() + utils.minutes(7))
    mobBattlefield:setLocalVar("AutoAggroTarget", target:getID())
end

local setupSharedHate = function(bossID, battlefield, mobs)
    local targID = GetMobByID(bossID):getTargID()
    for _, mob in ipairs(mobs) do
        if mob:getID() ~= bossID then
            mob:setMobMod(xi.mobMod.SHARE_TARGET, targID)
        end
    end
end

content.groups =
{
    {
        mobs = { "Carnagechief_Jackbodokk" },
    },

    {
        mobs =
        {
            "Carnagechief_Jackbodokk",
            "Grognard_Mesmerizer",
            "Grognard_Neckchopper",
            "Grognard_Footsoldier",
            "Grognard_Grappler",
            "Grognard_Predator",
            "Grognard_Impaler",
            "Orcs_Wyvern",
        },

        mods =
        {
            [xi.mod.SLASH_SDT] = 2000,
            [xi.mod.UDMGMAGIC] = 2000,
            [xi.mod.IMPACT_SDT] = 100,
            [xi.mod.HTH_SDT] = 100,
            [xi.mod.PIERCE_SDT] = 100,
        },

        isParty = true,
        superlink = true,
        spawned = false,
        initialize = utils.bind(setupSharedHate, ID.CS_APOLLYON.mob.CARNAGECHIEF_JACKBODOKK),
    },

    {
        mobs = { "NaQba_Chirurgeon" },
    },

    {
        mobs =
        {
            "NaQba_Chirurgeon",
            "Star_Ruby_Quadav",
            "Wootz_Quadav",
            "Fossil_Quadav",
            "Star_Sapphire_Quadav",
            "Whitegold_Quadav",
            "Lightsteel_Quadav",
        },

        mods =
        {
            [xi.mod.PIERCE_SDT] = 2000,
            [xi.mod.UDMGMAGIC] = 2000,
            [xi.mod.IMPACT_SDT] = 100,
            [xi.mod.HTH_SDT] = 100,
            [xi.mod.SLASH_SDT] = 100,
        },

        isParty = true,
        superlink = true,
        spawned = false,
        initialize = utils.bind(setupSharedHate, ID.CS_APOLLYON.mob.NAQBA_CHIRURGEON),
    },

    {
        mobs = { "Dee_Wapa_the_Desolator" },
    },

    {
        mobs =
        {
            "Dee_Wapa_the_Desolator",
            "Yagudos_Avatar",
            "Yagudo_Archpriest",
            "Yagudo_Knight_Templar",
            "Yagudo_Disciplinant",
            "Yagudo_Prelatess",
            "Yagudo_Kapellmeister",
            "Yagudo_Eradicator",
            "Yagudos_Elemental",
        },

        mods =
        {
            [xi.mod.IMPACT_SDT] = 2000,
            [xi.mod.HTH_SDT] = 2000,
            [xi.mod.UDMGMAGIC] = 100,
        },

        isParty = true,
        superlink = true,
        spawned = false,
        initialize = utils.bind(setupSharedHate, ID.CS_APOLLYON.mob.DEE_WAPA_THE_DESOLATOR),
    },

    {
        mobs =
        {
            "Carnagechief_Jackbodokk",
            "NaQba_Chirurgeon",
            "Dee_Wapa_the_Desolator",
        },

        mobMods =
        {
            [xi.mobMod.SOUND_RANGE] = 10,
            [xi.mobMod.DETECTION] = bit.bor(xi.detects.SIGHT, xi.detects.HEARING),
        },

        death = function(battlefield, mob, count)
            if count == 1 then
                xi.limbus.spawnFrom(mob, ID.CS_APOLLYON.npc.TIME_CRATES[1])
            elseif count == 2 then
                xi.limbus.spawnFrom(mob, ID.CS_APOLLYON.npc.TIME_CRATES[2])
            elseif count == 3 then
                npcUtil.showCrate(GetNPCByID(ID.CS_APOLLYON.npc.LOOT_CRATE))
            end
        end
    }
}

content.loot =
{
    [ID.CS_APOLLYON.npc.LOOT_CRATE] =
    {
        {
            quantity = 5,
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            quantity = 2,
            { itemid =    0, droprate = 1000 }, -- Nothing
            { itemid = 1875, droprate = 1000 }, -- Ancient Beastcoin
        },

        {
            { itemid = 2127, droprate =  59 }, -- Metal Chip
            { itemid =    0, droprate = 100 }, -- Nothing
        },
    },
}

return content:register()
