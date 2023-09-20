-----------------------------------
-- Area: Waughroon Shrine
-- Mob: Princess Jelly
-- Author: Setzor (ported to LSB by dallano)
-----------------------------------
local ID = require("scripts/zones/Waughroon_Shrine/IDs")
require("scripts/globals/pathfind")
require("scripts/globals/utils")
require("scripts/globals/spell_data")
-----------------------------------
local elementalSpells =
{
    { xi.magic.spell.BURN,  xi.magic.spell.FIRE },
    { xi.magic.spell.DROWN, xi.magic.spell.WATER },
    { xi.magic.spell.SHOCK, xi.magic.spell.THUNDER },
    { xi.magic.spell.RASP , xi.magic.spell.STONE },
    { xi.magic.spell.CHOKE, xi.magic.spell.AERO },
    { xi.magic.spell.FROST, xi.magic.spell.BLIZZARD },
    { xi.magic.spell.DIA,   xi.magic.spell.BANISH },
    { xi.magic.spell.BIO,   xi.magic.spell.DRAIN },
}
local centers =
{
    { -177.5, 60, -142 },
    {   22.5,  0,  18 },
    {  222.5, -60, 138 },
}
local mevaList =
{
    { xi.mod.WATER_MEVA,   xi.mod.FIRE_ABSORB },
    { xi.mod.THUNDER_MEVA, xi.mod.WATER_ABSORB },
    { xi.mod.EARTH_MEVA,   xi.mod.LTNG_ABSORB },
    { xi.mod.WIND_MEVA,    xi.mod.EARTH_ABSORB },
    { xi.mod.ICE_MEVA,     xi.mod.WIND_ABSORB },
    { xi.mod.FIRE_MEVA,    xi.mod.ICE_ABSORB },
    { xi.mod.DARK_MEVA,    xi.mod.LIGHT_ABSORB },
    { xi.mod.LIGHT_MEVA,   xi.mod.DARK_ABSORB },
}

local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 40)
end

entity.onMobSpawn = function(mob)
    mob:setSpeed(12)
    mob:setMod(xi.mod.REGEN, 3)
    mob:setLocalVar('mobElement', math.random(1, 8))
    mob:addMod(mevaList[mob:getLocalVar('mobElement')][1], -250)
    mob:addMod(mevaList[mob:getLocalVar('mobElement')][2], 1000)
end

local function getDistanceFromCenter(bfNum, mob)
    local pos = mob:getPos()

    local difX =  pos.x - centers[bfNum][1]
    local difY = pos.y - centers[bfNum][2]
    local difZ = pos.z - centers[bfNum][3]

    return math.sqrt( math.pow(difX, 2) + math.pow(difY, 2) + math.pow(difZ, 2) )
end

local function allJellysInCenter(bfNum)
    local totalMobsAlive = 0
    local totalInCenter = 0
    for i = 1, 8 do
        local princess = GetMobByID(ID.royalJellyQueens[bfNum] + i)
        if getDistanceFromCenter(bfNum, princess) <= 0.5 then
            totalInCenter = totalInCenter + 1
        end
        if princess:isAlive() then
            totalMobsAlive = totalMobsAlive + 1
        end
    end
    if totalMobsAlive == 0 then
        -- Win condition
        return false
    end
    return totalMobsAlive == totalInCenter
end

local function princessesTotalHP(bfNum)
    local totalHP = 0

    for i = 1, 8 do
        local princess = GetMobByID(ID.royalJellyQueens[bfNum] + i)
        if princess:isAlive() then
            totalHP = totalHP + princess:getHP()
        end
    end
    return totalHP
end

local function spawnQueenJelly(bfNum, target)
    local queen = GetMobByID(ID.royalJellyQueens[bfNum])

    if not queen:isSpawned() then
        SpawnMob(ID.royalJellyQueens[bfNum])
        queen:setHP(princessesTotalHP(bfNum))
        queen:setPos(centers[bfNum][1], centers[bfNum][2], centers[bfNum][3], 0)
        queen:setLocalVar('target', target:getID())

        queen:timer(3000, function(queenArg)
            local player = GetPlayerByID(queenArg:getLocalVar('target'))
            if player ~= nil and player:isAlive() then
                queen:updateClaim(player)
            end
        end)

        for i = 1, 8 do
            DespawnMob(ID.royalJellyQueens[bfNum] + i)
        end
    end
end

entity.onMobMagicPrepare = function(mob)
    local element = mob:getLocalVar('mobElement')
    local spell = math.random()

    if spell > 0.6 then
        return elementalSpells[element][1] -- element's DoT
    elseif spell > 0.2 then
        return elementalSpells[element][2] -- element's nuke
    else
        return 258
    end
end

entity.onMobFight = function(mob, target)
    local bfNum = mob:getBattlefield():getArea()
    local queen = GetMobByID(ID.royalJellyQueens[bfNum])
    local center = centers[bfNum]

    mob:pathThrough(center, xi.path.flag.SCRIPT)

    if getDistanceFromCenter(bfNum, mob) <= 0.5 then
        if not queen:isSpawned() and allJellysInCenter(bfNum) then
            spawnQueenJelly(bfNum, target)
        end
    end

    if mob:checkDistance(target) >= 20 then
        mob:setMagicCastingEnabled(false)
    else
        mob:setMagicCastingEnabled(true)
    end
end

entity.onMobEngaged = function(mob, target)
    local bfNum = mob:getBattlefield():getArea()

    for i = 1, 8 do
        local princess = GetMobByID(ID.royalJellyQueens[bfNum] + i)
        if not princess:isDead() then
            princess:updateEnmity(target)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local bfNum = mob:getBattlefield():getArea()
    local queen = GetMobByID(ID.royalJellyQueens[bfNum])

    if not queen:isSpawned() and allJellysInCenter(bfNum) then
        spawnQueenJelly(bfNum, player)
    end
end

return entity
