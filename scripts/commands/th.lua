---------------------------------------------------------------------------------------------------
-- func: th
-- desc: Prints the TH Value of the currently selected target under the cursor
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 0,
    parameters = ""
};

function onTrigger(player)
    local target = player:getCursorTarget()
    if (target ~= nil) and (target:isMob()) then
        player:PrintToPlayer(string.format("%s's current TH level is: %i ", target:getName(), target:getTHlevel()))
    else
        player:PrintToPlayer("Must select a target using in game cursor first.")
    end
end
