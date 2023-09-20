-----------------------------------
-- Area: Pashhow Marshlands
--   NM: Bo'Who Warmonger
-----------------------------------
require("scripts/globals/regimes")
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
-----------------------------------
local entity = {}

-- TODO: Implement better pathing systems for guards to follow master

entity.onMobSpawn = function(mob)
    -- Takes half damage from all attacks
    mob:addMod(xi.mod.UDMGPHYS, -5000)
    mob:addMod(xi.mod.UDMGRANGE, -5000)
    mob:addMod(xi.mod.UDMGMAGIC, -5000)
    mob:addMod(xi.mod.UDMGBREATH, -5000)

    -- May spawn in a party with two other Quadav
    if math.random(3) == 2 then
        GetMobByID(ID.mob.BOWHO_GUARD1):setSpawn(mob:getXPos() + 2, mob:getYPos(), mob:getZPos())
        GetMobByID(ID.mob.BOWHO_GUARD2):setSpawn(mob:getXPos() + 4, mob:getYPos(), mob:getZPos())
        SpawnMob(ID.mob.BOWHO_GUARD1)
        SpawnMob(ID.mob.BOWHO_GUARD2)
    end
end

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()
    for i = 1, 2 do
        GetMobByID(mobId + i):updateEnmity(target)
    end
end

entity.onMobRoam = function(mob)
    local mobId = mob:getID()

    for i = 1, 2 do
        local guard = GetMobByID(mobId + i)
        if guard:isSpawned() and guard:getID() == mobId + 1 then
            guard:pathTo(mob:getXPos() + 1, mob:getYPos() + 3, mob:getZPos() + 0.15)
        elseif guard:isSpawned() and guard:getID() == mobId + 2 then
            guard:pathTo(mob:getXPos() + 3, mob:getYPos() + 5, mob:getZPos() + 0.15)
        end
    end
end

entity.onMagicCastingCheck = function(mob, target, spell)
    -- Frequently casts Cure 3 on itself below 50% HP
    if mob:getHPP() < 50 then
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 80)
    else
        mob:setMobMod(xi.mobMod.HEAL_CHANCE, 40)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 60, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(84, 96) * 900) -- 21 to 24 hours in 15 minute windows
    DespawnMob(ID.mob.BOWHO_GUARD1)
    DespawnMob(ID.mob.BOWHO_GUARD2)
end

return entity
