---------------------------------------------------------------------------------------------------
-- func: getwspoints
-- desc: prints current ws points, optionaly specifying the weapon slot to check (default main)
---------------------------------------------------------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

cmdprops =
{
    permission = 0,
    parameters = "s"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!getwspoints (main/sub/ranged)")
end

function onTrigger(player, equipSlot)
    local name = player:getName()
    if not equipSlot then
        equipSlot = "main"
        player:PrintToPlayer("No equip slot specified, defaulting to mainhand weapon.")
    end

    local equip = xi.slot[string.upper(equipSlot)]
    if not equip or equip > xi.slot.RANGED then
        error(player, "Invalid equip slot specified.")
        return
    end

    local points = player:getStorageItem(0, 0, equip):getWeaponskillPoints()
    player:PrintToPlayer(string.format("The weapon in %s's %s slot has %i ws points", name, equipSlot, points))
end
