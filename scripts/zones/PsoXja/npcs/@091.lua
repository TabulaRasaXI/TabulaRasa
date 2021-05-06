-----------------------------------
-- Area: PsoXja
--  NPC: TOWER_B_Lift_1 !pos 140 31.500 340
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onSpawn = function(npc)

    local elevator =
    {
        id = xi.elevator.TIMED_AUTOMATIC,
        lowerDoor = npc:getID() + 2,
        upperDoor = npc:getID() + 1,
        elevator = npc:getID(),
        reversedAnimations = true,
    }

    npc:setElevator(elevator.id, elevator.lowerDoor, elevator.upperDoor, elevator.elevator, elevator.reversedAnimations)
end

return entity
