-----------------------------------
-- Persists NM time of deaths to the database. They must be added to the list here
-- to get this extra behaviour.
-- This is useful if you don't want players rushing to NM spawns after a server
-- restart or a crash (or trying to force crashes/restarts to get NM pops)
-----------------------------------
require("modules/module_utils")
-----------------------------------
local m = Module:new("persist_nm_time_of_deaths")

-- NOTE: These names are as they are as filenames.
-- Example: Behemoth's Dominion => Behemoths_Dominion
-- Example: King Behemoth       => King_Behemoth
-- { zone name, mob name, function to generate respawn time}
-- Format:
local nms_to_persist =
{
    { "Attohwa_Chasm", "Tiamat", function() return math.random(259200, 432000) end }, -- 3 - 5 days
    { "Bostaunieux_Oubliette", "Bloodsucker", function() return 259200 end }, -- 3 days
    { "Behemoths_Dominion", "Behemoth", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
    { "Dragons_Aery", "Fafnir", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
    { "Eastern_Altepa_Desert", "Centurio_XII-I", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "FeiYin", "Capricious_Cassie", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Garlaige_Citadel", "Old_Two-Wings", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Garlaige_Citadel", "Serket", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Garlaige_Citadel", "Skewer_Sam", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Gustav_Tunnel", "Bune", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Jugner_Forest", "King_Arthro", function() return 75900 + math.random(0, 6) * 1800 end }, -- 21:05 - 24:05 hours with half hour windows
    { "King_Ranperres_Tomb", "Vrtra", function() return math.random(259200, 432000) end }, -- 3 - 5 days
    { "Labyrinth_of_Onzozo", "Mysticmaker_Profblix", function() return math.random(7200, 9000) end }, -- 2 to 2.5 hours
    { "Lufaise_Meadows", "Padfoot", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Ordelles_Caves", "Morbolger", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Pashhow_Marshlands", "BoWho_Warmonger", function() return 75600 + math.random(600, 900) end }, -- 21 hours, plus 10 to 15 minutes
    { "Quicksand_Caves", "Antican_Consul", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Rolanberry_Fields", "Simurgh", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Riverne-Site_A01", "Carmine_Dobsonfly", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Riverne-Site_B01", "Boroka", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Sea_Serpent_Grotto", "Ocean_Sahagin", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "The_Shrine_of_RuAvitau", "Faust", function() return math.random(10800, 21600) end }, -- 3 - 6 hours 
    { "The_Shrine_of_RuAvitau", "Mother_Globe", function() return math.random(10800, 21600) end }, -- 3 - 6 hours 
    { "Sauromugue_Champaign", "Roc", function() return math.random(75600, 86400) end }, -- 21 - 24 hours
    { "Uleguerand_Range", "Jormungand", function() return math.random(259200, 432000) end }, -- 3 - 5 days
    { "Valley_of_Sorrows", "Adamantoise", function() return 75600 + math.random(0, 6) * 1800 end }, -- 21 - 24 hours with half hour windows
    { "VeLugannon_Palace", "Zipacna", function() return math.random(10800, 14400) end }, -- 3 - 4 hours 
    { "Yhoator_Jungle", "Bright-handed_Kunberry", function() return math.random(75600, 77400) end }, -- 21 - 21.5 hours
}

-- NOTE: At the time we iterate over these entries, the Lua zone and mob objects won't be ready,
--     : so we deal with everything as strings for now.
for _, entry in pairs(nms_to_persist) do
    local zone_name = entry[1]
    local mob_name = entry[2]
    local var_name = "[Respawn]" .. mob_name
    local respawn_func = entry[3]

    m:addOverride(string.format("xi.zones.%s.mobs.%s.onMobDespawn", zone_name, mob_name),
    function(mob)
        super(mob)

        local respawn = respawn_func()
        mob:setRespawnTime(respawn)
        SetServerVariable(var_name, (os.time() + respawn))
        print(string.format("Writing respawn time to server vars: %s %i", mob:getName(), respawn))
    end)

    m:addOverride(string.format("xi.zones.%s.Zone.onInitialize", zone_name),
    function(zone)
        super(zone)

        local mob = zone:queryEntitiesByName(mob_name)[1]
        local respawn = GetServerVariable(var_name)
        print(string.format("Getting respawn time from server vars: %s %i", mob:getName(), respawn))

        if os.time() < respawn then
            UpdateNMSpawnPoint(mob:getID())
            mob:setRespawnTime(respawn - os.time())
        else
            SpawnMob(mob:getID())
        end
    end)
end

return m
