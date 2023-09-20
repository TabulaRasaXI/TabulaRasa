require("scripts/globals/common")
require("scripts/globals/status")
require("scripts/globals/interaction/quest")

utils = {}

-- Max uint32 constant, replaces negative values in event parameters
-- Note: If correcting a negative value, this is *already* -1, adjust accordingly!
utils.MAX_UINT32 = 4294967295
utils.MAX_INT32  = 2147483647

-- Used to keep the linter quiet
function utils.unused(...)
end

-- bind and related functions are from https://stackoverflow.com/a/18229720
local unpack = unpack or table.unpack

local function packn(...)
    return { n = select('#', ...), ... }
end

local function unpackn(t)
    return unpack(t, 1, t.n)
end

local function mergen(...)
    local res = { n = 0 }
    for i = 1, select('#', ...) do
        local t = select(i, ...)
        for j = 1, t.n do
            res.n = res.n + 1
            res[res.n] = t[j]
        end
    end

    return res
end

function utils.bind(func, ...)
    local args = packn(...)
    return function(...)
        return func(unpackn(mergen(args, packn(...))))
    end
end

-- Creates a slice of an input table and returns a new table
function utils.slice(inputTable, first, last, step)
    local slicedTable = {}
    first = first or 1
    last = last or #inputTable
    step = step or 1
    local position = 1

    for i = first, last, step do
        slicedTable[position] = inputTable[i]
        position = position + 1
    end

    return slicedTable
end

-- Shuffles a table and returns a new table containing the randomized result.
function utils.shuffle(inputTable)
    local shuffledTable = {}

    for _, v in ipairs(inputTable) do
        local pos = math.random(1, #shuffledTable + 1)
        table.insert(shuffledTable, pos, v)
    end

    return shuffledTable
end

utils.append = nil

-- Recursively appends the input table into the provided base table.
-- Non-table keys are overwritten by input.
function utils.append(base, input)
    for k, v in pairs(input) do
        local baseValue = base[k]
        if baseValue ~= nil and type(baseValue) == 'table' and type(v) == 'table' then
            utils.append(baseValue, v)
        else
            base[k] = v
        end
    end

    return base
end

-- Returns a new table with the two input tables joined together.
-- Values from second input have higher priority.
function utils.join(input1, input2)
    local result = {}
    utils.append(result, input1)
    utils.append(result, input2)
    return result
end

function utils.minutes(minutes)
    return minutes * 60
end

-- Generates a random permutation of integers >= min_val and <= max_val
-- If a min_val isn't given, 1 is used (assumes permutation of lua indices)
function utils.permgen(max_val, min_val)
    local indices = {}
    min_val = min_val or 1

    if min_val >= max_val then
        for iter = min_val, max_val, -1 do
            indices[iter] = iter
        end
    else
        for iter = min_val, max_val, 1 do
            indices[iter] = iter
        end
    end

    return utils.shuffle(indices)
end

-- Generates a table of unique values given a range and number of entries. This should
-- only be used when you need unique random values smaller than the input range.  Use
-- utils.shuffle() or utils.permgen() directly if length of array is equal to the input
-- list.
-- Examples:
-- Input: (1, 3, 2)  Sample Output: { 3, 1 }    (randomized)
-- Input: (1, 10, 3) Sample Output: { 4, 9, 2 } (randomized)
function utils.uniqueRandomTable(minVal, maxVal, numEntries)
    local resultTable = {}
    local shuffledTable = utils.permgen(maxVal, minVal)

    if numEntries > #shuffledTable then
        print("utils.uniqueRandomTable(): numEntries exceeds length of shuffledTable!")
        return nil
    end

    for i = 1, numEntries do
        resultTable[i] = shuffledTable[i]
    end

    return resultTable
end

function utils.chance(likelihood)
    return math.random(100) <= likelihood
end

function utils.clamp(input, min_val, max_val)
    if min_val ~= nil and input < min_val then
        input = min_val
    elseif max_val ~= nil and input > max_val then
        input = max_val
    end

    return input
end

--  Returns a table containing all the elements in the specified range.
--  Source: https://github.com/mebens/range
function utils.range(from, to, step)
    local t = {}
    local argType = type(from)
    step = step or 1

    if argType == "number" then
        for i = from, to, step do t[#t + 1] = i end
    elseif argType == "string" then
        local e = string.byte(to)
        for i = string.byte(from), e, step do t[#t + 1] = string.char(i) end
    elseif argType == "table" then
        local metaNext = getmetatable(from).__next

        if metaNext then
            local i = from

            while i < to do
                t[#t + 1] = i
                i = metaNext(i, step)
            end

            t[#t + 1] = to
        end
    end

    return t
end

-----------------------------------
--
-- Functional
--
-- Functional methods provide a means to simplify logic that consists in
-- simple operations when iterating a table.
-- In general, they can make code much more concise and readable, but they
-- can also end up making it a cluttered mess, so use your judgement
-- when deciding if you want to use these methods
-----------------------------------

-- Given a table and a mapping function, returns a new table created by
-- applying the given mapping function to the given table elements
function utils.map(tbl, func)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = func(k, v)
    end
    return t
end

-- Given a table and a filter function, returns a new table composed of the
-- elements that pass the given filter.
-- e.g: utils.filter({ "a", "b", "c", "d" }, function(k, v) return v >= "c" end)  --> { "c", "d }
function utils.filter(tbl, func)
    local out = {}

    for k, v in pairs(tbl) do
        if func(k, v) then
            out[k] = v
        end
    end

    return out
end

-- Given a table and a filter function, returns a new table composed of the
-- elements that pass the given filter.
-- Unlike utils.filter, this method will return an iterable table.
-- e.g utils.filterArray({ "a", "b", "c", "d" }, function(k, v) return v >= "c" end)  --> { 1 => "c", 2 => "d" }
function utils.filterArray(tbl, func)
    local out = {}

    for k, v in pairs(tbl) do
        if func(k, v) then
            table.insert(out, v)
        end
    end

    return out
end

-- Returns true if any member of the given table passes the given
-- predicate function
function utils.any(tbl, predicate)
    for k, v in pairs(tbl) do
        if predicate(k, v) then
            return true
        end
    end

    return false
end

-- Returns the sum of applying the given function to each element of the given table
-- e.g: utils.sum({ 1, 2, 3 }, function(k, v) return v end)  --> 6
function utils.sum(tbl, func)
    local sum = 0

    for k, v in pairs(tbl) do
        sum = sum + func(k, v)
    end

    return sum
end

-- To be used with utils.sum.
-- Used to count the number of times an element in a table
-- matches the given predicate
-- e.g: utils.sum({ "a, "a", "b" }, utils.counter(function (k, v) return v == "a" end)) --> 2
function utils.counter(predicate)
    return function (k, v)
        if predicate(k, v) then
            return 1
        else
            return 0
        end
    end
end

-- returns unabsorbed damage
function utils.stoneskin(target, dmg)
    --handling stoneskin
    if dmg > 0 then
        local skin = target:getMod(xi.mod.STONESKIN)
        if skin > 0 then
            if skin > dmg then --absorb all damage
                target:delMod(xi.mod.STONESKIN, dmg)
                return 0
            else --absorbs some damage then wear
                target:delStatusEffect(xi.effect.STONESKIN)
                target:setMod(xi.mod.STONESKIN, 0)
                return dmg - skin
            end
        end
    end

    return dmg
end

function utils.rampart(target, dmg)
    if dmg > 0 then
        local shield = target:getMod(xi.mod.RAMPART_MAGIC_SHIELD)
        if shield > 0 then
            if shield > dmg then -- absorbs damage
                target:delMod(xi.mod.RAMPART_MAGIC_SHIELD, dmg)
                return 0
            else -- absorbs some damage
                target:setMod(xi.mod.RAMPART_MAGIC_SHIELD, 0)
                return dmg - shield
            end
        end
    end

    return dmg
end

-- returns reduced magic damage from RUN buff, "One for All"
function utils.oneforall(target, dmg)
    if dmg > 0 then
        local oneForAllEffect = target:getStatusEffect(xi.effect.ONE_FOR_ALL)

        if oneForAllEffect ~= nil then
            local power = oneForAllEffect:getPower()
            dmg = math.max(0, dmg - power)
        end
    end

    return dmg
end

function utils.takeShadows(target, mob, dmg, shadowbehav)
    if shadowbehav == nil then
        shadowbehav = 1
    end

    local targShadows = target:getMod(xi.mod.UTSUSEMI)
    local shadowType = xi.mod.UTSUSEMI

    if targShadows == 0 then
        --try blink, as utsusemi always overwrites blink this is okay
        targShadows = target:getMod(xi.mod.BLINK)
        shadowType = xi.mod.BLINK
    end

    local shadowsLeft = targShadows
    local shadowsUsed = 0

    if targShadows > 0 then
        if shadowType == xi.mod.BLINK then
            for i = 1, shadowbehav, 1 do
                if shadowsLeft > 0 then
                    if math.random() <= 0.8 then
                        shadowsUsed = shadowsUsed + 1
                        shadowsLeft = shadowsLeft - 1
                    end
                end
            end

            if shadowsUsed >= shadowbehav then
                dmg = 0
            else
                dmg = (dmg / shadowbehav) * (shadowbehav - shadowsUsed)
            end
        else
            if targShadows >= shadowbehav then
                shadowsLeft = targShadows - shadowbehav

                if shadowsLeft > 0 then
                    -- Update icon
                    local effect = target:getStatusEffect(xi.effect.COPY_IMAGE)
                    if effect ~= nil then
                        if shadowsLeft == 1 then
                            effect:setIcon(xi.effect.COPY_IMAGE)
                        elseif shadowsLeft == 2 then
                            effect:setIcon(xi.effect.COPY_IMAGE_2)
                        elseif shadowsLeft == 3 then
                            effect:setIcon(xi.effect.COPY_IMAGE_3)
                        elseif shadowsLeft >= 4 then
                            effect:setIcon(xi.effect.COPY_IMAGE_4)
                        end
                    end
                end

                dmg = 0
            else
                shadowsLeft = 0
                dmg = dmg * (shadowbehav - targShadows) / shadowbehav
            end
        end

        if mob and mob:isMob() then
            target:addEnmity(mob, -25 * shadowbehav, 0)
        end

        target:setMod(shadowType, shadowsLeft)

        if shadowsLeft <= 0 then
            target:delStatusEffect(xi.effect.COPY_IMAGE)
            target:delStatusEffect(xi.effect.BLINK)
        end
    end

    return dmg
end

function utils.conalDamageAdjustment(attacker, target, skill, maxDamage, minimumPercentage)
    local finalDamage = 1
    -- #TODO: Currently all cone attacks use static 45 degree (360 scale) angles in core, when cone attacks
    -- have different angles and there's a method to fetch the angle, use a line like the below
    -- local coneAngle = skill:getConalAngle()
    local coneAngle = 32 -- 256-degree based, equivalent to "45 degrees" on 360 degree scale

    -- #TODO: Conal attacks hit targets in a cone with a center line of the "primary" target (the mob's
    -- highest enmity target). These primary targets can be within 128 degrees of the mob's front. However,
    -- there's currently no way for a conal skill to store (and later check) the primary target a mob skill
    -- was trying to hit. Therefore the "damage drop off" here is based from an origin of the mob's rotation
    -- instead. Should conal skills become capable of identifying their primary target, this should be changed
    -- to be based on the degree difference from the primary target instead.
    local conalAnglePower = coneAngle - math.abs(attacker:getFacingAngle(target))

    if conalAnglePower < 0 then
        -- #TODO The below print will be a valid print upon fixing to-do above relating to beam center orgin
        conalAnglePower = 0
    end

    -- Calculate the amount of damage to add above the minimum percentage based on how close
    -- the target is to the center of the conal (0 degrees from the attacker's facing)
    local minimumDamage    = maxDamage * minimumPercentage
    local damagePerAngle   = (maxDamage - minimumDamage) / coneAngle
    local additionalDamage = damagePerAngle * conalAnglePower

    finalDamage = math.max(1, math.ceil(minimumDamage + additionalDamage))

    return finalDamage
end

-- returns true if taken by third eye
function utils.thirdeye(target)
    --third eye doesnt care how many shadows, so attempt to anticipate, but reduce
    --chance of anticipate based on previous successful anticipates.
    local teye = target:getStatusEffect(xi.effect.THIRD_EYE)
    local seigan = target:getStatusEffect(xi.effect.SEIGAN)

    if teye == nil then
        return false
    end

    local prevAnt = teye:getPower()

    if prevAnt == 0 or (math.random() * 100) < (80 - (prevAnt * 10)) then
        --anticipated!
        if seigan == nil or prevAnt == 6 or math.random() * 100 > 100 - (prevAnt + 1) * 15 then
            target:delStatusEffect(xi.effect.THIRD_EYE)
        else
            teye:setPower(prevAnt + 1)
        end
        return true
    else
        target:delStatusEffect(xi.effect.THIRD_EYE) -- how did we get here?  the previous clause checks for prevAnt == 6
        return true
    end
end

-----------------------------------
--     SKILL LEVEL CALCULATOR
--     Returns a skill level based on level and rating.
--
--    See the translation of aushacho's work by Themanii:
--    http://home.comcast.net/~themanii/skill.html
--
--    The arguments are skill rank (numerical), and level.  1 is A+, 2 is A-, and so on.
-----------------------------------

-- skillLevelTable contains matched pairs based on rank; First value is multiplier, second is additive value.  Index is the subtracted
-- baseInRange value (see below)
-- Original formula: ((level - <baseInRange>) * <multiplier>) + <additive>; where level is a range defined in utils.getSkillLvl
local skillLevelTable =
{
    --         A+             A-             B+             B              B-             C+             C              C-             D              E              F
    [1]  = { { 3.00,   6 }, { 3.00,   6 }, { 2.90,   5 }, { 2.90,   5 }, { 2.90,   5 }, { 2.80,   5 }, { 2.80,   5 }, { 2.80,   5 }, { 2.70,   4 }, { 2.50,   4 }, { 2.30,   4 } }, -- Level <= 50
    [50] = { { 5.00, 153 }, { 5.00, 153 }, { 4.90, 147 }, { 4.90, 147 }, { 4.90, 147 }, { 4.80, 142 }, { 4.80, 142 }, { 4.80, 142 }, { 4.70, 136 }, { 4.50, 126 }, { 4.30, 116 } }, -- Level > 50 and Level <= 60
    [60] = { { 4.85, 203 }, { 4.10, 203 }, { 3.70, 196 }, { 3.23, 196 }, { 2.70, 196 }, { 2.50, 190 }, { 2.25, 190 }, { 2.00, 190 }, { 1.85, 183 }, { 1.95, 171 }, { 2.05, 159 } }, -- Level > 60 and Level <= 70
    [70] = { { 5.00, 251 }, { 5.00, 244 }, { 3.70, 233 }, { 3.23, 228 }, { 2.70, 223 }, { 3.00, 215 }, { 2.60, 212 }, { 2.00, 210 }, { 1.85, 201 }, { 1.95, 190 }, { 2.00, 179 } }, -- Level > 70
}

-- Get the corresponding table entry to use in skillLevelTable based on level range
-- TODO: Minval for ranges 2 and 3 in the conditional is probably not necessary
local function getSkillLevelIndex(level)
    local rangeId = nil

    if level <= 50 then
        rangeId = 1
    elseif level > 50 and level <= 60 then
        rangeId = 50
    elseif level > 60 and level <= 70 then
        rangeId = 60
    else
        rangeId = 70
    end

    return rangeId
end

function utils.getSkillLvl(rank, level)
    local levelTableIndex = getSkillLevelIndex(level)
    return ((level - levelTableIndex) * skillLevelTable[levelTableIndex][rank][1]) + skillLevelTable[levelTableIndex][rank][2]
end

function utils.getMobSkillLvl(rank, level)
    if level > 50 then
        if rank == 1 then
            return 153 + (level - 50) * 5
        end

        if rank == 2 then
            return 147 + (level - 50) * 4.9
        end

        if rank == 3 then
            return 136 + (level - 50) * 4.8
        end

        if rank == 4 then
            return 126 + (level - 50) * 4.7
        end

        if rank == 5 then
            return 116 + (level - 50) * 4.5
        end

        if rank == 6 then
            return 106 + (level - 50) * 4.4
        end

        if rank == 7 then
            return 96 + (level - 50) * 4.3
        end
    end

    if rank == 1 then
        return 6 + (level - 1) * 3
    end

    if rank == 2 then
        return 5 + (level - 1) * 2.9
    end

    if rank == 3 then
        return 5 + (level - 1) * 2.8
    end

    if rank == 4 then
        return 4 + (level - 1) * 2.7
    end

    if rank == 5 then
        return 4 + (level - 1) * 2.5
    end

    if rank == 6 then
        return 3 + (level - 1) * 2.4
    end

    if rank == 7 then
        return 3 + (level - 1) * 2.3
    end

    return 0
end

-- System Strength Bonus table.  This is used by xi.mobskills.mobBreathMove, but determines weakness of
-- a definding system, vs the attacking system.  This table is indexed by the attacker.
-- This table can scale beyond two values, but at this time, no data has been recorded.
-- Values: 1 == Bonus, -1 == Weakness, 0 == Default (No Weakness or Bonus)
local systemStrengthTable =
{
    [xi.eco.BEAST   ] = { [xi.eco.LIZARD  ] = 1, [xi.eco.PLANTOID] = -1, },
    [xi.eco.LIZARD  ] = { [xi.eco.VERMIN  ] = 1, [xi.eco.BEAST   ] = -1, },
    [xi.eco.VERMIN  ] = { [xi.eco.PLANTOID] = 1, [xi.eco.LIZARD  ] = -1, },
    [xi.eco.PLANTOID] = { [xi.eco.BEAST   ] = 1, [xi.eco.VERMIN  ] = -1, },
    [xi.eco.AQUAN   ] = { [xi.eco.AMORPH  ] = 1, [xi.eco.BIRD    ] = -1, },
    [xi.eco.AMORPH  ] = { [xi.eco.BIRD    ] = 1, [xi.eco.AQUAN   ] = -1, },
    [xi.eco.BIRD    ] = { [xi.eco.AQUAN   ] = 1, [xi.eco.AMORPH  ] = -1, },
    [xi.eco.UNDEAD  ] = { [xi.eco.ARCANA  ] = 1, },
    [xi.eco.ARCANA  ] = { [xi.eco.UNDEAD  ] = 1, },
    [xi.eco.DRAGON  ] = { [xi.eco.DEMON   ] = 1, },
    [xi.eco.DEMON   ] = { [xi.eco.DRAGON  ] = 1, },
    [xi.eco.LUMORIAN] = { [xi.eco.LUMINION] = 1, },
    [xi.eco.LUMINION] = { [xi.eco.LUMORIAN] = 1, },
}

function utils.getSystemStrengthBonus(attacker, defender)
    local attackerSystem = attacker:getSystem()
    local defenderSystem = defender:getSystem()

    for k, v in pairs(systemStrengthTable) do
        if k == attackerSystem then
            for defId, weakValue in pairs(systemStrengthTable[k]) do
                if defId == defenderSystem then
                    return weakValue
                end
            end
        end
    end

    return 0
end

-- utils.mask contains functions for bitmask variables
utils.mask =
{
    -- return mask's pos-th bit as bool
    getBit = function(mask, pos)
        return bit.band(mask, bit.lshift(1, pos)) ~= 0
    end,

    -- return value of mask after setting its pos-th bit
    -- val can be bool or number.  if number, any non-zero value will be treated as true.
    setBit = function(mask, pos, val)
        local state = false

        if type(val) == "boolean" then
            state = val
        elseif type(val) == "number" then
            state = (val ~= 0)
        end

        if state then
            -- turn bit on
            return bit.bor(mask, bit.lshift(1, pos))
        else
            -- turn bit off
            return bit.band(mask, bit.bnot(bit.lshift(1, pos)))
        end
    end,

    -- return number of true bits in mask of length len
    -- if len is omitted, assume 32
    countBits = function(mask, len)
        if not len then
            len = 32
        end

        local count = 0

        for i = 0, len - 1 do
            count = count + bit.band(bit.rshift(mask, i), 1)
        end

        return count
    end,

    -- are all bits true in mask of length len?
    -- if len is omitted, assume 32
    isFull = function(mask, len)
        if not len then
            len = 32
        end

        local fullMask = (2 ^ len) - 1

        return bit.band(mask, fullMask) == fullMask
    end,
}

function utils.prequire(...)
    local ok, result = pcall(require, ...)
    if ok then
        return result
    else
        local vars = { ... }
        printf("Error while trying to load '%s': %s", vars[1], result)
    end
end

-- Checks to see if a specific value is contained in a table.  This is often
-- used for tables that do not define specific indices.
-- See: Sigil NPCs
function utils.contains(value, collection)
    for _, v in pairs(collection) do
        if value == v then
            return true
        end
    end

    return false
end

-- Checks to see if a specific key is contained in the table.  This is used by
-- tables that contain specific indices that may be non-sequential.
-- See: xi.teleport.escape
function utils.hasKey(keyVal, collection)
    for k, _ in pairs(collection) do
        if k == keyVal then
            return true
        end
    end

    return false
end

-- Selects a random entry from a table, returns the index and the entry
-- https://gist.github.com/jdev6/1e7ff30671edf88d03d4
function utils.randomEntryIdx(t)
    local keys = {}

    for key, _ in pairs(t) do
        keys[#keys + 1] = key
    end

    local index = keys[math.random(1, #keys)]
    return index, t[index]
end

function utils.randomEntry(t)
    local _, item = utils.randomEntryIdx(t)
    return item
end

-- Helper functions for Interaction Framework Quests
-- These should only be used when working between quests, or outside
-- of the quest script itself.  Quest vars will be deleted automatically
-- when that quest:complete(player) is called!

function utils.getQuestVar(player, logId, questId, varName)
    local charVarName = Quest.getVarPrefix(logId, questId) .. varName
    return player:getCharVar(charVarName)
end

function utils.setQuestVar(player, logId, questId, varName, value)
    local charVarName = Quest.getVarPrefix(logId, questId) .. varName
    player:setCharVar(charVarName, value)
end

-- utils.splitStr("a.b.c", ".") => { "a", "b", "c" }
function utils.splitStr(s, sep)
    local fields = {}
    local pattern = string.format("([^%s]+)", sep)
    local _ = string.gsub(s, pattern, function(c)
        fields[#fields + 1] = c
    end)

    return fields
end

function utils.mobTeleport(mob, hideDuration, pos, disAnim, reapAnim)
    --TODO Table of animations that are used for teleports for reference

    if hideDuration == nil then
        hideDuration = 5000
    end

    if disAnim == nil then
        disAnim = "kesu"
    end

    if reapAnim == nil then
        reapAnim = "deru"
    end

    if pos == nil then
        pos = mob:getPos()
    end

    local mobSpeed = mob:getSpeed()

    if hideDuration < 1000 then
        hideDuration = 1000
    end

    if mob:isDead() then
        return
    end

    mob:entityAnimationPacket(disAnim)
    mob:hideName(true)
    mob:setUntargetable(true)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setPos(pos, 0)
    mob:setSpeed(0)

    mob:timer(hideDuration, function(mobArg)
        mobArg:setPos(pos, 0)
        mobArg:hideName(false)
        mobArg:setUntargetable(false)
        mobArg:setAutoAttackEnabled(true)
        mobArg:setMagicCastingEnabled(true)
        mobArg:setMobAbilityEnabled(true)
        mobArg:setSpeed(mobSpeed)
        mobArg:entityAnimationPacket(reapAnim)

        if mobArg:isDead() then
            return
        end
    end)
end

local ffxiRotConversionFactor = 360.0 / 255.0

function utils.ffxiRotToDegrees(ffxiRot)
    return ffxiRotConversionFactor * ffxiRot
end

function utils.lateralTranslateWithOriginRotation(origin, translation)
    local degrees = utils.ffxiRotToDegrees(origin.rot)
    local rads = math.rad(degrees)
    local newCoords = {}

    newCoords.x = origin.x + ((math.cos(rads) * translation.x) + (math.sin(rads) * translation.z))
    newCoords.z = origin.z + ((math.cos(rads) * translation.z) - (math.sin(rads) * translation.x))
    newCoords.y = origin.y
    newCoords.rot = origin.rot

    return newCoords
end

function utils.getNearPosition(origin, offset, radians)
    local destination =
    {
        x = origin.x + math.cos(2 * math.pi - radians) * offset,
        y = origin.y,
        z = origin.z + math.sin(2 * math.pi - radians) * offset
    }

    return destination
end

function utils.distance(A, B, ignoreVertical)
    return math.sqrt(utils.distanceSquared(A, B, ignoreVertical))
end

function utils.distanceSquared(A, B, ignoreVertical)
    local dX = B.x - A.x
    local dY = (ignoreVertical and 0.0) or B.y - A.y
    local dZ = B.z - A.z

    return dX * dX + dY * dY + dZ * dZ
end

function utils.distanceWithin(A, B, within, ignoreVertical)
    return utils.distanceSquared(A, B, ignoreVertical) <= within * within
end

function utils.getWorldAngle(A, B)
    -- lua math.atan functions like cpp atan2. On top of this, all ffxi world angles are positive.
    -- So we have to adjust the range of lua's math.atan from [-pi, pi] to [0, 2pi]
    -- Similarly, cpp's atanf gets its range adjusted from [-pi/2, pi/2] to [0, 2pi]
    -- It does this by checking the quadrant, which math.atan does automatically.
    -- Finally, ffxi rotations go in the opposite direction from standard rotations.
    local radians = math.atan((B.z - A.z) / (B.x - A.x)) * -1.0

    if B.x > A.x and B.z > A.z then
        -- Quadrant 1
        radians = radians + 2 * math.pi
    elseif B.x > A.x then
        -- Quadrant 4
        radians = radians + 0
    elseif B.z > A.z then
        -- Quadrant 2
        radians = radians + math.pi
    else
        -- Quadrant 3
        radians = radians + math.pi
    end

    return radians
end

function utils.getWorldRotation(A, B)
    return utils.angleToRotation(utils.getWorldAngle(A, B))
end

function utils.getAngleDifference(a, b)
    local diff = math.abs(b - a)
    if diff > math.pi then
        diff = 2 * math.pi - diff
    end

    return diff
end

-- Returns whether the angle formed between A and B with origin is <= within radians.
function utils.angleWithin(origin, A, B, within)
    return utils.getAngleDifference(utils.getWorldAngle(origin, A), utils.getWorldAngle(origin, B)) <= within
end

local ffxiRotationToAngleFactor = 2.0 * math.pi / 256.0
local ffxiAngleToRotationFactor  = 256.0 / (2.0 * math.pi)

function utils.rotationToAngle(ffxiRotation)
    return ffxiRotation * ffxiRotationToAngleFactor
end

function utils.angleToRotation(radians)
    return radians * ffxiAngleToRotationFactor
end

-- Returns inline value  boolean      any     any
function utils.ternary(conditional, trueVal, falseVal)
    if conditional then
        return trueVal
    end

    return falseVal
end

function utils.arenaDrawIn(mob, target, table)
    local nextDrawIn = target:getLocalVar("[Draw-In]WaitTime")
    local condition1 = utils.ternary(table.condition1 ~= nil, table.condition1, false)
    local condition2 = utils.ternary(table.condition2 ~= nil, table.condition2, false)
    local condition3 = utils.ternary(table.condition3 ~= nil, table.condition3, false)
    local condition4 = utils.ternary(table.condition4 ~= nil, table.condition4, false)
    local position   = utils.ternary(table.position ~= nil, table.position, { mob:getXPos(), mob:getYPos(), mob:getZPos(), mob:getRotPos() })

    if
        (condition1 or condition2 or condition3 or condition4) and
        (os.time() > nextDrawIn)
    then
        target:setPos(position[1], position[2], position[3], utils.ternary(position[4] ~= nil, position[4], 0))
        mob:messageBasic(232, 0, 0, target)
        target:setLocalVar("[Draw-In]WaitTime", os.time() + 1)
    end
end
