-----------------------------------
-- ID: 116
-- Item: Windurstian Tree
-----------------------------------
require("scripts/globals/quests")
require('scripts/globals/events/starlight_celebrations')
-----------------------------------
local itemObject = {}

itemObject.onFurniturePlaced = function(player)
    player:setCharVar("[StarlightMisc]TreePlaced", 1)
    player:setCharVar("[StarlightMisc]TreeTimePlaced", VanadielUniqueDay())
    player:setCharVar("[StarlightMisc]WindurstianTree", 1)
end

itemObject.onFurnitureRemoved = function(player)
    player:setCharVar("[StarlightMisc]TreePlaced", 0)
    player:setCharVar("[StarlightMisc]TreeTimePlaced", 0)
    player:setCharVar("[StarlightMisc]WindurstianTree", 0)
end

return itemObject
