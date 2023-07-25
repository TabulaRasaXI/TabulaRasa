-----------------------------------
-- Unlock Mog Wardrobe slots as you complete missions
-----------------------------------
require("modules/module_utils")
require("scripts/globals/utils")
require("scripts/globals/player")
require("scripts/globals/status")
-----------------------------------
local m = Module:new("custom_containers")

m:addOverride("xi.player.onGameIn", function(player, firstLogin, zoning)
    -- NOTE: These will all be clamped between 0-80,
    --     : so using -80 is fine
    local locker = player:getContainerSize(xi.inv.MOGLOCKER)
    local sack = player:getContainerSize(xi.inv.MOGSACK)
    local case = player:getContainerSize(xi.inv.MOGCASE)
    local safe = player:getContainerSize(xi.inv.MOGSAFE)
    local safe2 = player:getContainerSize(xi.inv.MOGSAFE2)
    local wardrobe = player:getContainerSize(xi.inv.WARDROBE)
    local wardrobe2 = player:getContainerSize(xi.inv.WARDROBE2)
    local wardrobe3 = player:getContainerSize(xi.inv.WARDROBE3)
    local wardrobe4 = player:getContainerSize(xi.inv.WARDROBE4)
    local wardrobe5 = player:getContainerSize(xi.inv.WARDROBE5)
    local wardrobe6 = player:getContainerSize(xi.inv.WARDROBE6)
    local wardrobe7 = player:getContainerSize(xi.inv.WARDROBE7)
    local wardrobe8 = player:getContainerSize(xi.inv.WARDROBE8)

    -- we should try to minimize unneccesary db calls
    -- please look to disable this entire module at some point
    player:changeContainerSize(xi.inv.MOGLOCKER, - locker)
    player:changeContainerSize(xi.inv.MOGSACK, - sack)
    player:changeContainerSize(xi.inv.MOGCASE, - case)
    player:changeContainerSize(xi.inv.MOGSAFE2, 80)
    player:changeContainerSize(xi.inv.WARDROBE2, 80)
    player:changeContainerSize(xi.inv.WARDROBE3, 80)
    player:changeContainerSize(xi.inv.WARDROBE4, 80)
    player:changeContainerSize(xi.inv.WARDROBE5, 80)
    player:changeContainerSize(xi.inv.WARDROBE6, 80)
    player:changeContainerSize(xi.inv.WARDROBE7, 80)
    player:changeContainerSize(xi.inv.WARDROBE8, 80)
    super(player, firstLogin, zoning)
end)

return m
