#!/bin/bash

# Requires the following packages:
# Package manager: luarocks
# luarocks install luacheck --local
# luarocks install lanes --local

target=${1:-scripts}

global_funcs=`python3 << EOF
import re
file = open('src/map/lua/luautils.cpp', 'r')
data = file.read()
file.close()
# Find all bound global functions
matches = re.findall(r'(?<=set_function\(\")(.*)(?=\",)', data)
# Make sure they're capitalized
matches = map(lambda s: s[:1].upper() + s[1:] if s else '', matches)
# Print space-delimited for piping back to bash
print(*matches)
EOF`

global_objects=(
    xi
    ai
    os
    _

    Module
    Override
    super
    applyOverride

    common
    zones
    quests
    utils
    npcUtil

    mixins
    g_mixins
    applyMixins

    set
    printf
    switch
    clearVarFromAll
    getVanaMidnight
    getMidnight
    getConquestTally
    vanaDay

    mission
    Mission
    quest
    Quest
    HiddenQuest
    fileExists
    InteractionGlobal
    InteractionLookup
    Action
    actionUtil
    interactionUtil
    KeyItemAction
    LambdaAction
    Message
    NoAction
    Sequence
    Container
    Event
    Battlefield
    BattlefieldMission
    BattlefieldQuest
    Limbus
    SeasonalEvent

    removeSleepEffects

    QUEST_AVAILABLE
    QUEST_ACCEPTED
    QUEST_COMPLETED

    onBattlefieldHandlerInitialise

    doAutoPhysicalWeaponskill
    doAutoRangedWeaponskill
    doPhysicalWeaponskill
    doRangedWeaponskill
    doMagicWeaponskill
    doesElementMatchWeaponskill
    applyResistanceAddEffect
    takeWeaponskillDamage

    fTP
    fSTR
    fSTR2
    calculateRawWSDmg
    calculatedIgnoredDef
    cMeleeRatio
    generatePdif
    getMeleeDmg
    handleWSGorgetBelt

    RoeParseTimed
    getRoeRecords
    RoeParseRecords

    cmdprops
    error
    onTrigger

    SetExplorerMoogles

    applyHalloweenNpcCostumes
    isHalloweenEnabled
    onHalloweenTrade

    addBonuses
    addBonusesAbility
    applyBarspell
    applyBarstatus
    applyResistance
    applyResistanceAbility
    applyResistanceEffect
    adjustForTarget
    calculateDuration
    calculateDurationForLvl
    calculateMagicDamage
    calculatePotency
    canOverwrite
    dayWeatherBonus
    doBoostGain
    doDivineBanishNuke
    doDivineNuke
    doElementalNuke
    doEnspell
    doNinjutsuNuke
    finalMagicAdjustments
    finalMagicNonSpellAdjustments
    getBaseCure
    getCurePower
    getCurePowerOld
    getCureFinal
    getBaseCureOld
    getEffectResistance
    getElementalDamageReduction
    getElementalDebuffDOT
    getFlourishAnimation
    getStepAnimation
    hasSleepEffects
    skillchainCount
    takeAbilityDamage

    doAutoRangedWeaponskill
    doAutoPhysicalWeaponskill

    AbilityFinalAdjustments

    MOBSKILL_MAGICAL
    MOBSKILL_PHYSICAL

    TPMOD_NONE
    TPMOD_CHANCE
    TPMOD_CRITICAL
    TPMOD_DAMAGE
    TPMOD_ACC
    TPMOD_ATTACK
    TPMOD_DURATION
    SC_NONE
    SC_IMPACTION
    SC_TRANSFIXION
    SC_DETONATION
    SC_REVERBERATION
    SC_SCISSION
    SC_INDURATION
    SC_LIQUEFACTION
    SC_COMPRESSION
    SC_FUSION
    SC_FRAGMENTATION
    SC_DISTORTION
    SC_GRAVITATION
    SC_DARKNESS
    SC_LIGHT
    SC_LIGHT_II
    SC_DARKNESS_II
    INT_BASED
    CHR_BASED
    MND_BASED
    BluePhysicalSpell
    BlueMagicalSpell
    BlueFinalAdjustments
    getBlueEffectDuration

    LEUJAOAM_ASSAULT_POINT
    MAMOOL_ASSAULT_POINT
    LEBROS_ASSAULT_POINT
    PERIQIA_ASSAULT_POINT
    ILRUSI_ASSAULT_POINT
    NYZUL_ISLE_ASSAULT_POINT

    ForceCrash
    BuildString

    DYNAMIC_LOOKUP
)

ignores=(
    "unused variable ID"
)

ignore_rules=(
    311 # value assigned to variable <> is unused
    542 # empty if branch
)

~/.luarocks/bin/luacheck ${target} \
--quiet --jobs 4 --no-config --codes \
--no-unused-args \
--no-max-line-length \
--max-cyclomatic-complexity 30 \
--globals ${global_funcs[@]} ${global_objects[@]} \
--ignore ${ignores[@]} ${ignore_rules[@]} | grep -v "Total:"

python3 ./tools/ci/lua_stylecheck.py ${target}

