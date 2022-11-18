-- Zone: La Theine Plateau (102)
-- Desc: this file contains functions that are shared by multiple luas in this zone's directory
-----------------------------------
local ID = require("scripts/zones/La_Theine_Plateau/IDs")
require("scripts/globals/npc_util")
-----------------------------------

local laTheineGlobal =
{
    --[[..............................................................................................
        move the FallenEgg NPC. optionally hide for secondsHidden seconds.
        ..............................................................................................]]
    moveFallenEgg = function(secondsHidden)
        local fallenEggPositions =
        {
            [1] =  { 211.000, 24.000,  257.000 },
            [2] =  { 228.000, 25.000,  249.000 },
            [3] =  { 221.000, 24.000,  252.000 },
            [4] =  { 202.000, 23.000,  243.000 },
            [5] =  { 185.000, 21.000,  243.000 },
            [6] =  { 165.000, 16.000,  247.000 },
            [7] =  { 335.000, 40.000,  268.000 },
            [8] =  { 336.000, 40.000,  266.000 },
            [9] =  { 348.000, 40.000,  274.000 },
            [10] = { 360.000, 40.000,  269.000 },
            [11] = { 352.000, 40.000,  258.000 },
            [12] = { 341.000, 40.000,  254.000 },
            [13] = { 213.000, 24.000,  282.000 },
            [14] = { 202.000, 24.000,  286.000 },
            [15] = { 190.000, 23.000,  291.000 },
            [16] = { 193.000, 24.000,  305.000 },
            [17] = { 183.000, 23.000,  309.000 },
            [18] = { 179.000, 23.000,  336.000 },
            [19] = { 201.000, 24.000,  348.000 },
            [20] = { 162.000, 24.000,  321.000 },
            [21] = { 159.000, 22.000,  310.000 },
            [22] = { 159.000, 17.000,  291.000 },
            [23] = { 554.000, 24.000,   90.000 },
            [24] = { 576.000, 24.000,   82.000 },
            [25] = { 582.000, 23.000,   97.000 },
            [26] = { 570.000, 23.000,  124.000 },
            [27] = { 580.000, 23.000,  140.000 },
            [28] = { 603.000, 23.000,  156.000 },
            [29] = { 620.000, 24.000,  166.000 },
            [30] = { 629.000, 26.000,  142.000 },
            [31] = { 656.000, 30.000,  131.000 },
            [32] = { 651.000, 31.000,  113.000 },
            [33] = { 657.000, 31.000,   93.000 },
            [34] = { 668.000, 31.000,   90.000 },
            [35] = { 693.000, 30.000,   70.000 },
            [36] = { 708.000, 30.000,  133.000 },
            [37] = { 630.000, 24.000,  179.000 },
            [38] = { 595.000, 24.000,  177.000 },
            [39] = { 571.000, 24.000,  157.000 },
            [40] = { 579.000, 40.000, -444.000 },
            [41] = { 594.000, 40.000, -404.000 },
            [42] = { 602.000, 40.000, -411.000 },
            [43] = { 615.000, 39.000, -393.000 },
            [44] = { 615.000, 37.000, -382.000 },
            [45] = { 606.000, 39.000, -374.000 },
            [46] = { 629.000, 40.000, -406.000 },
            [47] = { 631.000, 40.000, -425.000 },
            [48] = { 631.000, 40.000, -442.000 },
            [49] = { 626.000, 40.000, -463.000 },
            [50] = { 636.000, 40.000, -470.000 },
            [51] = { 602.000, 40.000, -485.000 },
            [52] = { 599.000, 40.000, -521.000 },
            [53] = { 601.000, 40.000, -508.000 },
            [54] = { 560.000, 24.000, -321.000 },
            [55] = { 570.000, 26.000, -330.000 },
            [56] = { 560.000, 24.000, -334.000 },
            [57] = { 563.000, 24.000, -347.000 },
            [58] = { 553.000, 24.000, -351.000 },
            [59] = { 537.000, 24.000, -357.000 },
            [60] = { 533.000, 25.000, -368.000 },
            [61] = { 546.000, 25.000, -365.000 },
            [62] = { 519.000, 24.000, -361.000 },
        }

        local fallenEgg = GetNPCByID(ID.npc.FALLEN_EGG)
        local newPosition = npcUtil.pickNewPosition(ID.npc.FALLEN_EGG, fallenEggPositions)
        if secondsHidden ~= nil and secondsHidden > 0 then
            fallenEgg:hideNPC(secondsHidden)
        end
        fallenEgg:setPos(newPosition.x, newPosition.y, newPosition.z)
    end
}

return laTheineGlobal
