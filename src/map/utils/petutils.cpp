﻿/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "common/timer.h"
#include "common/utils.h"

#include <cmath>
#include <cstring>
#include <vector>

#include "../ability.h"
#include "../enmity_container.h"
#include "../entities/automatonentity.h"
#include "../entities/mobentity.h"
#include "../grades.h"
#include "../items/item_weapon.h"
#include "../job_points.h"
#include "../latent_effect_container.h"
#include "../map.h"
#include "../mob_spell_list.h"
#include "../status_effect_container.h"
#include "../zone_instance.h"
#include "battleutils.h"
#include "charutils.h"
#include "mobutils.h"
#include "petutils.h"
#include "puppetutils.h"
#include "zoneutils.h"

#include "../ai/ai_container.h"
#include "../ai/controllers/automaton_controller.h"
#include "../ai/controllers/mob_controller.h"
#include "../ai/controllers/pet_controller.h"
#include "../ai/controllers/spirit_controller.h"
#include "../ai/states/ability_state.h"

#include "../mob_modifier.h"
#include "../packets/char_abilities.h"
#include "../packets/char_sync.h"
#include "../packets/char_update.h"
#include "../packets/entity_update.h"
#include "../packets/message_standard.h"
#include "../packets/pet_sync.h"

struct Pet_t
{
    uint16      PetID;     // ID in pet_list.sql
    look_t      look;      // внешний вид
    std::string name;      // имя
    ECOSYSTEM   EcoSystem; // эко-система

    uint8 minLevel; // минимально-возможный  уровень
    uint8 maxLevel; // максимально-возможный уровень

    uint8  name_prefix;
    uint8  radius; // Model Radius - affects melee range etc.
    uint16 m_Family;
    uint32 time; // время существования (будет использоваться для задания длительности статус эффекта)

    uint8 mJob;
    uint8 sJob;
    uint8 m_Element;
    float HPscale; // HP boost percentage
    float MPscale; // MP boost percentage

    uint16 cmbDelay;
    uint8  speed;
    // stat ranks
    uint8 strRank;
    uint8 dexRank;
    uint8 vitRank;
    uint8 agiRank;
    uint8 intRank;
    uint8 mndRank;
    uint8 chrRank;
    uint8 attRank;
    uint8 defRank;
    uint8 evaRank;
    uint8 accRank;

    uint16 m_MobSkillList;

    // magic stuff
    bool   hasSpellScript;
    uint16 spellList;

    // resists
    int16 slash_sdt;
    int16 pierce_sdt;
    int16 hth_sdt;
    int16 impact_sdt;

    int16 fire_sdt;
    int16 ice_sdt;
    int16 wind_sdt;
    int16 earth_sdt;
    int16 thunder_sdt;
    int16 water_sdt;
    int16 light_sdt;
    int16 dark_sdt;

    int16 fire_meva;
    int16 ice_meva;
    int16 wind_meva;
    int16 earth_meva;
    int16 thunder_meva;
    int16 water_meva;
    int16 light_meva;
    int16 dark_meva;

    Pet_t()
    : EcoSystem(ECOSYSTEM::ECO_ERROR)
    {
        PetID = 0;

        minLevel = -1;
        maxLevel = 99;

        name_prefix = 0;
        radius      = 0;
        m_Family    = 0;
        time        = 0;

        mJob      = 0;
        sJob      = 0;
        m_Element = 0;
        HPscale   = 0.f;
        MPscale   = 0.f;

        cmbDelay = 0;
        speed    = 0;

        strRank = 0;
        dexRank = 0;
        vitRank = 0;
        agiRank = 0;
        intRank = 0;
        mndRank = 0;
        chrRank = 0;
        attRank = 0;
        defRank = 0;
        evaRank = 0;
        accRank = 0;

        m_MobSkillList = 0;

        hasSpellScript = false;
        spellList      = 0;

        slash_sdt  = 0;
        pierce_sdt = 0;
        hth_sdt    = 0;
        impact_sdt = 0;

        fire_sdt    = 0;
        ice_sdt     = 0;
        wind_sdt    = 0;
        earth_sdt   = 0;
        thunder_sdt = 0;
        water_sdt   = 0;
        light_sdt   = 0;
        dark_sdt    = 0;

        fire_meva    = 0;
        ice_meva     = 0;
        wind_meva    = 0;
        earth_meva   = 0;
        thunder_meva = 0;
        water_meva   = 0;
        light_meva   = 0;
        dark_meva    = 0;
    }
};

std::vector<Pet_t*> g_PPetList;

namespace petutils
{
    /************************************************************************
     *                                                                      *
     *  Загружаем список прототипов питомцев                                    *
     *                                                                      *
     ************************************************************************/

    void LoadPetList()
    {
        FreePetList();

        const char* Query = "SELECT\
                pet_list.petid,\
                pet_list.name,\
                modelid,\
                minLevel,\
                maxLevel,\
                time,\
                mobradius,\
                ecosystemID,\
                mob_pools.familyid,\
                mob_pools.mJob,\
                mob_pools.sJob,\
                pet_list.element,\
                (mob_family_system.HP / 100),\
                (mob_family_system.MP / 100),\
                mob_family_system.speed,\
                mob_family_system.STR,\
                mob_family_system.DEX,\
                mob_family_system.VIT,\
                mob_family_system.AGI,\
                mob_family_system.INT,\
                mob_family_system.MND,\
                mob_family_system.CHR,\
                mob_family_system.DEF,\
                mob_family_system.ATT,\
                mob_family_system.ACC, \
                mob_family_system.EVA, \
                hasSpellScript, spellList, \
                slash_sdt, pierce_sdt, h2h_sdt, impact_sdt, \
                fire_sdt, ice_sdt, wind_sdt, earth_sdt, lightning_sdt, water_sdt, light_sdt, dark_sdt, \
                fire_meva, ice_meva, wind_meva, earth_meva, lightning_meva, water_meva, light_meva, dark_meva, \
                cmbDelay, name_prefix, mob_pools.skill_list_id \
                FROM pet_list, mob_pools, mob_resistances, mob_family_system \
                WHERE pet_list.poolid = mob_pools.poolid AND mob_resistances.resist_id = mob_pools.resist_id AND mob_pools.familyid = mob_family_system.familyID";

        if (sql->Query(Query) != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                Pet_t* Pet = new Pet_t();

                Pet->PetID = (uint16)sql->GetIntData(0);
                Pet->name.insert(0, (const char*)sql->GetData(1));

                uint16 sqlModelID[10];
                memcpy(&sqlModelID, sql->GetData(2), 20);
                Pet->look = look_t(sqlModelID);

                Pet->minLevel  = (uint8)sql->GetIntData(3);
                Pet->maxLevel  = (uint8)sql->GetIntData(4);
                Pet->time      = sql->GetUIntData(5);
                Pet->radius    = sql->GetUIntData(6);
                Pet->EcoSystem = (ECOSYSTEM)sql->GetIntData(7);
                Pet->m_Family  = (uint16)sql->GetIntData(8);
                Pet->mJob      = (uint8)sql->GetIntData(9);
                Pet->sJob      = (uint8)sql->GetIntData(10);
                Pet->m_Element = (uint8)sql->GetIntData(11);

                Pet->HPscale = sql->GetFloatData(12);
                Pet->MPscale = sql->GetFloatData(13);

                Pet->speed = (uint8)sql->GetIntData(14);

                Pet->strRank = (uint8)sql->GetIntData(15);
                Pet->dexRank = (uint8)sql->GetIntData(16);
                Pet->vitRank = (uint8)sql->GetIntData(17);
                Pet->agiRank = (uint8)sql->GetIntData(18);
                Pet->intRank = (uint8)sql->GetIntData(19);
                Pet->mndRank = (uint8)sql->GetIntData(20);
                Pet->chrRank = (uint8)sql->GetIntData(21);
                Pet->defRank = (uint8)sql->GetIntData(22);
                Pet->attRank = (uint8)sql->GetIntData(23);
                Pet->accRank = (uint8)sql->GetIntData(24);
                Pet->evaRank = (uint8)sql->GetIntData(25);

                Pet->hasSpellScript = (bool)sql->GetIntData(26);

                Pet->spellList = (uint8)sql->GetIntData(27);

                // Specific Dmage Taken, as a %
                Pet->slash_sdt  = (uint16)(sql->GetFloatData(28) * 1000);
                Pet->pierce_sdt = (uint16)(sql->GetFloatData(29) * 1000);
                Pet->hth_sdt    = (uint16)(sql->GetFloatData(30) * 1000);
                Pet->impact_sdt = (uint16)(sql->GetFloatData(31) * 1000);

                Pet->fire_sdt    = (int16)sql->GetIntData(32); // Modifier 54, base 10000 stored as signed integer. Positives signify less damage.
                Pet->ice_sdt     = (int16)sql->GetIntData(33); // Modifier 55, base 10000 stored as signed integer. Positives signify less damage.
                Pet->wind_sdt    = (int16)sql->GetIntData(34); // Modifier 56, base 10000 stored as signed integer. Positives signify less damage.
                Pet->earth_sdt   = (int16)sql->GetIntData(35); // Modifier 57, base 10000 stored as signed integer. Positives signify less damage.
                Pet->thunder_sdt = (int16)sql->GetIntData(36); // Modifier 58, base 10000 stored as signed integer. Positives signify less damage.
                Pet->water_sdt   = (int16)sql->GetIntData(37); // Modifier 59, base 10000 stored as signed integer. Positives signify less damage.
                Pet->light_sdt   = (int16)sql->GetIntData(38); // Modifier 60, base 10000 stored as signed integer. Positives signify less damage.
                Pet->dark_sdt    = (int16)sql->GetIntData(39); // Modifier 61, base 10000 stored as signed integer. Positives signify less damage.

                // resistances
                Pet->fire_meva    = (int16)sql->GetIntData(40);
                Pet->ice_meva     = (int16)sql->GetIntData(41);
                Pet->wind_meva    = (int16)sql->GetIntData(42);
                Pet->earth_meva   = (int16)sql->GetIntData(43);
                Pet->thunder_meva = (int16)sql->GetIntData(44);
                Pet->water_meva   = (int16)sql->GetIntData(45);
                Pet->light_meva   = (int16)sql->GetIntData(46);
                Pet->dark_meva    = (int16)sql->GetIntData(47);
                /* Todo
                Pet->fire_res_rank    = (int16)sql->GetIntData(??);
                Pet->ice_res_rank     = (int16)sql->GetIntData(??);
                Pet->wind_res_rank    = (int16)sql->GetIntData(??);
                Pet->earth_res_rank   = (int16)sql->GetIntData(??);
                Pet->thunder_res_rank = (int16)sql->GetIntData(??);
                Pet->water_res_rank   = (int16)sql->GetIntData(??);
                Pet->light_res_rank   = (int16)sql->GetIntData(??);
                Pet->dark_res_rank    = (int16)sql->GetIntData(??);
                */

                Pet->cmbDelay       = (uint16)sql->GetIntData(48);
                Pet->name_prefix    = (uint8)sql->GetUIntData(49);
                Pet->m_MobSkillList = (uint16)sql->GetUIntData(50);

                g_PPetList.push_back(Pet);
            }
        }
    }

    /************************************************************************
     *                                                                      *
     *  Освобождаем список прототипов питомцев                              *
     *                                                                      *
     ************************************************************************/

    void FreePetList()
    {
        while (!g_PPetList.empty())
        {
            destroy(*g_PPetList.begin());
            g_PPetList.erase(g_PPetList.begin());
        }
    }

    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget)
    {
        if (PMaster == nullptr || PMaster->PPet == nullptr || PTarget == nullptr)
        {
            ShowWarning("petutils::AttackTarget() - Null master, pet, or target passed to function.");
            return;
        }

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect())
        {
            PPet->PAI->Engage(PTarget->targid);
        }
    }

    void RetreatToMaster(CBattleEntity* PMaster)
    {
        if (PMaster == nullptr || PMaster->PPet == nullptr)
        {
            ShowWarning("petutils::RetreatToMaster() - Null master or pet passed to function.");
            return;
        }

        CBattleEntity* PPet = PMaster->PPet;

        if (!PPet->StatusEffectContainer->HasPreventActionEffect())
        {
            PPet->PAI->Disengage();
        }
    }

    uint16 GetJugWeaponDamage(CPetEntity* PPet)
    {
        uint16 MainLevel = PPet->GetMLevel();
        return MainLevel;
    }
    // Not used as Jugs are based off mob stats (temp note)
    uint16 GetJugBase(CPetEntity* PMob, uint8 rank)
    {
        uint8 lvl = PMob->GetMLevel();
        if (lvl > 50)
        {
            switch (rank)
            {
                case 1:
                    return (uint16)(153 + (lvl - 50) * 5.0f); // A
                case 2:
                    return (uint16)(147 + (lvl - 50) * 4.9f); // B
                case 3:
                    return (uint16)(136 + (lvl - 50) * 4.8f); // C
                case 4:
                    return (uint16)(126 + (lvl - 50) * 4.7f); // D
                case 5:
                    return (uint16)(116 + (lvl - 50) * 4.5f); // E
                case 6:
                    return (uint16)(106 + (lvl - 50) * 4.4f); // F
                case 7:
                    return (uint16)(96 + (lvl - 50) * 4.3f); // G
            }
        }
        else
        {
            switch (rank)
            {
                case 1:
                    return (uint16)(6 + (lvl - 1) * 3.0f); // A
                case 2:
                    return (uint16)(5 + (lvl - 1) * 2.9f); // B
                case 3:
                    return (uint16)(5 + (lvl - 1) * 2.8f); // C
                case 4:
                    return (uint16)(4 + (lvl - 1) * 2.7f); // D
                case 5:
                    return (uint16)(4 + (lvl - 1) * 2.5f); // E
                case 6:
                    return (uint16)(3 + (lvl - 1) * 2.4f); // F
                case 7:
                    return (uint16)(3 + (lvl - 1) * 2.3f); // G
            }
        }
        return 0;
    }

    uint16 GetBaseToRank(uint8 rank, uint16 lvl)
    {
        switch (rank)
        {
            case 1:
                return (5 + ((lvl - 1) * 50) / 100); // A
            case 2:
                return (4 + ((lvl - 1) * 45) / 100); // B
            case 3:
                return (4 + ((lvl - 1) * 40) / 100); // C
            case 4:
                return (3 + ((lvl - 1) * 35) / 100); // D
            case 5:
                return (3 + ((lvl - 1) * 30) / 100); // E
            case 6:
                return (2 + ((lvl - 1) * 25) / 100); // F
            case 7:
                return (2 + ((lvl - 1) * 20) / 100); // G
        }
        return 0;
    }

    void LoadJugStats(CPetEntity* PMob, Pet_t* petStats)
    {
        // follows monster formulas but jugs have no subjob
        JOBTYPE mJob   = PMob->GetMJob();
        uint8   lvl    = PMob->GetMLevel();
        uint8   lvlmax = petStats->maxLevel;
        uint8   lvlmin = petStats->minLevel;

        lvl = std::clamp(lvl, lvlmin, lvlmax);

        uint8  grade;
        uint32 mobHP = 1; // Set mob HP

        grade = grade::GetJobGrade(mJob, 0); // main jobs grade

        uint8 base     = 0; // Column for base hp
        uint8 jobScale = 1; // Column for job scaling
        uint8 scaleX   = 2; // Column for modifier scale

        uint8 BaseHP   = grade::GetMobHPScale(grade, base);     // Main job base HP
        uint8 JobScale = grade::GetMobHPScale(grade, jobScale); // Main job scaling
        uint8 ScaleXHP = grade::GetMobHPScale(grade, scaleX);   // Main job modifier scale

        uint8 RBIgrade = std::min(lvl, (uint8)5); // RBI Grade
        uint8 RBIbase  = 1;                       // Column for RBI base

        uint8 RBI = grade::GetMobRBI(RBIgrade, RBIbase); // RBI

        uint8 mLvlIf    = (PMob->GetMLevel() > 5 ? 1 : 0);
        uint8 mLvlIf30  = (PMob->GetMLevel() > 30 ? 1 : 0);
        uint8 raceScale = 6;

        if (lvl > 0)
        {
            mobHP = BaseHP + (std::min(lvl, (uint8)5) - 1) * (JobScale + raceScale - 1) + RBI + mLvlIf * (std::min(lvl, (uint8)30) - 5) * (2 * (JobScale + raceScale) + std::min(lvl, (uint8)30) - 6) / 2 + mLvlIf30 * ((lvl - 30) * (63 + ScaleXHP) + (lvl - 31) * (JobScale + raceScale));
        }

        PMob->health.maxhp = (int16)(mobHP * petStats->HPscale);

        switch (PMob->GetMJob())
        {
            case JOB_PLD:
            case JOB_WHM:
            case JOB_BLM:
            case JOB_RDM:
            case JOB_DRK:
            case JOB_BLU:
            case JOB_SCH:
                PMob->health.maxmp = (int16)(15.2 * pow(lvl, 1.1075) * petStats->MPscale);
                break;
            default:
                break;
        }

        PMob->speed    = petStats->speed;
        PMob->speedsub = petStats->speed;

        static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->setDamage(GetJugWeaponDamage(PMob));

        // reduce weapon delay of MNK
        if (PMob->GetMJob() == JOB_MNK)
        {
            static_cast<CItemWeapon*>(PMob->m_Weapons[SLOT_MAIN])->resetDelay();
        }

        uint16 fSTR = GetBaseToRank(petStats->strRank, PMob->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PMob->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PMob->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PMob->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PMob->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PMob->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PMob->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 2), PMob->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 3), PMob->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 4), PMob->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 5), PMob->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 6), PMob->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 7), PMob->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(), 8), PMob->GetMLevel());

        PMob->stats.STR = (uint16)(fSTR + mSTR);
        PMob->stats.DEX = (uint16)(fDEX + mDEX);
        PMob->stats.VIT = (uint16)(fVIT + mVIT);
        PMob->stats.AGI = (uint16)(fAGI + mAGI);
        PMob->stats.INT = (uint16)(fINT + mINT);
        PMob->stats.MND = (uint16)(fMND + mMND);
        PMob->stats.CHR = (uint16)(fCHR + mCHR);

        // Set jugs damageType to impact (blunt) damage. All jugs at level 75 cap do impact (blunt) damage. https://ffxiclopedia.fandom.com/wiki/Category:Familiars
        uint32 id       = PMob->m_PetID;
        PMob->m_dmgType = DAMAGE_TYPE::IMPACT;

        // Killer Effect and DEF/EVA/ACC/ATT
        switch (id)
        {
            case 21: // SHEEP FAMILIAR
                PMob->addModifier(Mod::LIZARD_KILLER, 10);
                break;
            case 22: // HARE FAMILIAR
                PMob->addModifier(Mod::LIZARD_KILLER, 10);
                break;
            case 23: // CRAB FAMILIAR
                PMob->addModifier(Mod::AMORPH_KILLER, 10);
                break;
            case 24: // COURIER CARRIE
                PMob->addModifier(Mod::AMORPH_KILLER, 10);
                break;
            case 25: // HOMUNCULUS
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            case 26: // FLYTRAP FAMILIAR
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            case 27: // TIGER FAMILIAR
                PMob->addModifier(Mod::LIZARD_KILLER, 10);
                break;
            case 28: // FLOWERPOT BILL
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            case 29: // EFT FAMILIAR
                PMob->addModifier(Mod::VERMIN_KILLER, 10);
                break;
            case 30: // LIZARD FAMILIAR
                PMob->addModifier(Mod::VERMIN_KILLER, 10);
                break;
            case 31: // MAYFLY FAMILIAR
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 32: // FUNGUAR FAMILIAR
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            case 33: // BEETLE FAMILIAR
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 34: // ANTLION FAMILIAR
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 35: // MITE FAMILIAR
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 36: // LULLABY MELODIA
                PMob->addModifier(Mod::LIZARD_KILLER, 10);
                break;
            case 37: // KEENEARED STEFFI
                PMob->addModifier(Mod::LIZARD_KILLER, 10);
                break;
            case 38: // FLOWERPOT BEN
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            case 39: // SABER SIRAVARDE
                PMob->addModifier(Mod::LIZARD_KILLER, 10);
                break;
            case 40: // COLDBLOOD COMO
                PMob->addModifier(Mod::VERMIN_KILLER, 10);
                break;
            case 41: // SHELLBUSTER OROB
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 42: // VORACIOUS AUDREY
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            case 43: // AMBUSHER ALLIE
                PMob->addModifier(Mod::VERMIN_KILLER, 10);
                break;
            case 44: // LIFEDRINKER LARS
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 45: // PANZER GALAHAD
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 46: // CHOPSUEY CHUCKY
                PMob->addModifier(Mod::PLANTOID_KILLER, 10);
                break;
            case 47: // AMIGO SABOTENDER
                PMob->addModifier(Mod::BEAST_KILLER, 10);
                break;
            default:
                break;
        }

        PMob->setModifier(Mod::DEF, mobutils::GetDefense(PMob, PMob->defRank));
        PMob->setModifier(Mod::EVA, mobutils::GetBase(PMob, PMob->evaRank));
        PMob->setModifier(Mod::ATT, mobutils::GetBase(PMob, PMob->attRank));
        PMob->setModifier(Mod::ACC, mobutils::GetBase(PMob, PMob->accRank));
    }

    void LoadAutomatonStats(CCharEntity* PMaster, CPetEntity* PPet, Pet_t* petStats)
    {
        PPet->WorkingSkills.automaton_melee  = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MELEE), PMaster->GetSkill(SKILL_AUTOMATON_MELEE));
        PPet->WorkingSkills.automaton_ranged = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_RANGED), PMaster->GetSkill(SKILL_AUTOMATON_RANGED));
        PPet->WorkingSkills.automaton_magic  = std::min(puppetutils::getSkillCap(PMaster, SKILL_AUTOMATON_MAGIC), PMaster->GetSkill(SKILL_AUTOMATON_MAGIC));

        // Set capped flags
        for (int i = 22; i <= 24; ++i)
        {
            if (PPet->GetSkill(i) == (puppetutils::getSkillCap(PMaster, (SKILLTYPE)i)))
            {
                PPet->WorkingSkills.skill[i] |= 0x8000;
            }
        }

        // Add mods/merits
        int32 meritbonus = PMaster->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_SKILLS, PMaster);
        PPet->WorkingSkills.automaton_melee += PMaster->getMod(Mod::AUTO_MELEE_SKILL) + meritbonus;
        PPet->WorkingSkills.automaton_ranged += PMaster->getMod(Mod::AUTO_RANGED_SKILL) + meritbonus;
        // Share its magic skills to prevent needing separate spells or checks to see which skill to use
        uint16 amaSkill                     = PPet->WorkingSkills.automaton_magic + PMaster->getMod(Mod::AUTO_MAGIC_SKILL) + meritbonus;
        PPet->WorkingSkills.automaton_magic = amaSkill;
        PPet->WorkingSkills.healing         = amaSkill;
        PPet->WorkingSkills.enhancing       = amaSkill;
        PPet->WorkingSkills.enfeebling      = amaSkill;
        PPet->WorkingSkills.elemental       = amaSkill;
        PPet->WorkingSkills.dark            = amaSkill;

        // Declaration of variables needed for calculation.
        float raceStat          = 0; // Final HP for level based on race.
        float jobStat           = 0; // Final number of HP for the level based on the primary profession.
        float sJobStat          = 0; // Finite number of HP for the level based on the secondary profession.
        int32 bonusStat         = 0; // Bonus number of HP that is added under certain conditions.
        int32 baseValueColumn   = 0; // Number of the column with the base amount of HP
        int32 scaleTo60Column   = 1; // Column number with modifier up to level 60
        int32 scaleOver30Column = 2; // Column number with modifier after level 30
        int32 scaleOver60Column = 3; // Column number with modifier after level 60
        int32 scaleOver75Column = 4; // Column number with modifier after level 75
        int32 scaleOver60       = 2; // Column number with a modifier for calculating MP after level 60
        // int32 scaleOver75       = 3; // Column number with a modifier for calculating Stats after level 75

        uint8 grade;

        uint8   mLvl = PPet->GetMLevel();
        JOBTYPE mjob = PPet->GetMJob();
        JOBTYPE sjob = PPet->GetSJob();
        // Calculate HP gain from main job
        int32 mainLevelOver30     = std::clamp(mLvl - 30, 0, 30); // Calculate condition +1HP every lvl after level 30
        int32 mainLevelUpTo60     = (mLvl < 60 ? mLvl - 1 : 59);  // First calculation mode up to level 60 (Used the same for MP)
        int32 mainLevelOver60To75 = std::clamp(mLvl - 60, 0, 15); // Second calculation mode after level 60
        int32 mainLevelOver75     = (mLvl < 75 ? 0 : mLvl - 75);  // Third calculation mode after level 75

        // Calculate the bonus amount of HP
        int32 mainLevelOver10           = (mLvl < 10 ? 0 : mLvl - 10);  // +2HP on every level after 10
        int32 mainLevelOver50andUnder60 = std::clamp(mLvl - 50, 0, 10); // +2HP at each level between level 50 and 60
        int32 mainLevelOver60           = (mLvl < 60 ? 0 : mLvl - 60);

        // Calculate raceStat jobStat bonusStat sJobStat
        // Calculate by race

        grade = 4;

        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                   (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // raceStat = (int32)(statScale[grade][baseValueColumn] + statScale[grade][scaleTo60Column] * (mLvl - 1));

        // Calculation by main job
        grade = grade::GetJobGrade(mjob, 0);

        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75) +
                  (grade::GetHPScale(grade, scaleOver75Column) * mainLevelOver75);

        // Calculate Bonus HP
        bonusStat          = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        PPet->health.maxhp = (int32)((raceStat + jobStat + bonusStat + sJobStat) * petStats->HPscale);
        PPet->health.hp    = PPet->health.maxhp;

        // Start MP calculation
        raceStat = 0;
        jobStat  = 0;
        sJobStat = 0;

        // Calculate the MP for the race.
        grade = 4;

        // If the main job doesn't have an MP rating, calculate the racial bonus based on the level of the subjob's level (assuming it has an MP rating)
        if (!(grade::GetJobGrade(mjob, 1) == 0 && grade::GetJobGrade(sjob, 1) == 0))
        {
            // calculate normal racial bonus
            raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        // For the main profession
        grade = grade::GetJobGrade(mjob, 1);
        if (grade > 0)
        {
            jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                      grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        grade = grade::GetJobGrade(sjob, 1);
        if (grade > 0)
        {
            sJobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                       grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
        }

        PPet->health.maxmp = (int32)((raceStat + jobStat + sJobStat) * petStats->MPscale);
        PPet->health.mp    = PPet->health.maxmp;

        uint16 fSTR = GetBaseToRank(petStats->strRank, PPet->GetMLevel());
        uint16 fDEX = GetBaseToRank(petStats->dexRank, PPet->GetMLevel());
        uint16 fVIT = GetBaseToRank(petStats->vitRank, PPet->GetMLevel());
        uint16 fAGI = GetBaseToRank(petStats->agiRank, PPet->GetMLevel());
        uint16 fINT = GetBaseToRank(petStats->intRank, PPet->GetMLevel());
        uint16 fMND = GetBaseToRank(petStats->mndRank, PPet->GetMLevel());
        uint16 fCHR = GetBaseToRank(petStats->chrRank, PPet->GetMLevel());

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 2), PPet->GetMLevel());
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 3), PPet->GetMLevel());
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 4), PPet->GetMLevel());
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 5), PPet->GetMLevel());
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 6), PPet->GetMLevel());
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 7), PPet->GetMLevel());
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 8), PPet->GetMLevel());

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 2), PPet->GetSLevel());
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 3), PPet->GetSLevel());
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 4), PPet->GetSLevel());
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 5), PPet->GetSLevel());
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 6), PPet->GetSLevel());
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 7), PPet->GetSLevel());
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 8), PPet->GetSLevel());

        PPet->stats.STR = fSTR + mSTR + sSTR;
        PPet->stats.DEX = fDEX + mDEX + sDEX;
        PPet->stats.VIT = fVIT + mVIT + sVIT;
        PPet->stats.AGI = fAGI + mAGI + sAGI;
        PPet->stats.INT = fINT + mINT + sINT;
        PPet->stats.MND = fMND + mMND + sMND;
        PPet->stats.CHR = fCHR + mCHR + sCHR;

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setSkillType(SKILL_AUTOMATON_MELEE);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (petStats->cmbDelay / 60.0f)))); // every pet should use this eventually
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (petStats->cmbDelay / 60.0f))));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_MELEE) / 9) * 2 + 3);

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setSkillType(SKILL_AUTOMATON_RANGED);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_RANGED])->setDamage((PPet->GetSkill(SKILL_AUTOMATON_RANGED) / 9) * 2 + 3);

        CAutomatonEntity* PAutomaton = static_cast<CAutomatonEntity*>(PPet);

        // Automatons are hard to interrupt
        PPet->addModifier(Mod::SPELLINTERRUPT, 85);

        switch (PAutomaton->getFrame())
        {
            default: // case FRAME_HARLEQUIN:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(2, mLvl > 99 ? 99 : mLvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(10, mLvl > 99 ? 99 : mLvl));
                PPet->m_dmgType = DAMAGE_TYPE::IMPACT;
                break;
            case FRAME_VALOREDGE:
                PPet->setModifier(Mod::SHIELDBLOCKRATE, 45);
                PPet->setMobMod(MOBMOD_CAN_SHIELD_BLOCK, 1);
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(5, mLvl > 99 ? 99 : mLvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(5, mLvl > 99 ? 99 : mLvl));
                PPet->m_dmgType = DAMAGE_TYPE::SLASHING;
                break;
            case FRAME_SHARPSHOT:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(1, mLvl > 99 ? 99 : mLvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(11, mLvl > 99 ? 99 : mLvl));
                PPet->m_dmgType = DAMAGE_TYPE::PIERCING;
                break;
            case FRAME_STORMWAKER:
                PPet->WorkingSkills.evasion = battleutils::GetMaxSkill(10, mLvl > 99 ? 99 : mLvl);
                PPet->setModifier(Mod::DEF, battleutils::GetMaxSkill(12, mLvl > 99 ? 99 : mLvl));
                PPet->m_dmgType = DAMAGE_TYPE::IMPACT;
                break;
        }

        // Add Job Point Stat Bonuses
        if (PMaster->GetMJob() == JOB_PUP)
        {
            PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
            PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
        }
    }

    void LoadAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // Declaration of variables needed for calculation.
        float raceStat  = 0; // final HP for level based on race.
        float jobStat   = 0; // final number of HP for the level based on the main job.
        float sJobStat  = 0; // final number of HP for the level based on the sub job.
        int32 bonusStat = 0; // bonus number of HP that is added under certain conditions.

        // Table Columns
        int32 baseValueColumn   = 0; // Column number with base number HP
        int32 scaleTo60Column   = 1; // Column number with modifier up to 60 levels
        int32 scaleOver30Column = 2; // Column number with modifier after level 30
        int32 scaleOver60Column = 3; // Column number with modifier after level 60
        int32 scaleOver60       = 2; // Column number with a modifier for calculating MP after level 60

        uint8 grade = 5; // Grade for HP

        uint8   mLvl = PPet->GetMLevel();
        uint8   sLvl = PPet->GetSLevel();
        JOBTYPE mjob = PPet->GetMJob();
        JOBTYPE sjob = PPet->GetSJob();

        // Calculate level ranges from main job
        int32 mainLevelOver30     = std::clamp(mLvl - 30, 0, 30); // Calculation of the condition + 1HP each LVL after level 30
        int32 mainLevelUpTo60     = (mLvl < 60 ? mLvl - 1 : 59);  // The first time spent up to level 60 (is also used for MP)
        int32 mainLevelOver60To75 = std::clamp(mLvl - 60, 0, 15); // The second calculation mode after level 60
        int32 mainLevelOver60     = (mLvl < 60 ? 0 : mLvl - 60);

        // Calculate level ranges of sub job
        int32 subLevelOver10 = std::clamp(sLvl - 10, 0, 20); // + 1HP for each level after 10 (/ 2)
        int32 subLevelOver30 = (sLvl < 30 ? 0 : sLvl - 30);  // + 1HP for each level after 30

        // Calculate the bonus amount of HP
        int32 mainLevelOver10           = (mLvl < 10 ? 0 : mLvl - 10);  // + 2hp at each level after 10
        int32 mainLevelOver50andUnder60 = std::clamp(mLvl - 50, 0, 10); // + 2hp at each level between 50 to 60 level

        // Calculate raceStat jobStat bonusStat sJobStat
        // Calculate by race
        raceStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                   (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75);

        // Main job HP calculation
        grade   = grade::GetJobGrade(mjob, 0);
        jobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * mainLevelUpTo60) +
                  (grade::GetHPScale(grade, scaleOver30Column) * mainLevelOver30) + (grade::GetHPScale(grade, scaleOver60Column) * mainLevelOver60To75);

        // Sub job HP calculation
        if (PPet->m_PetID != PETID_WYVERN)
        {
            grade    = grade::GetJobGrade(sjob, 0);
            sJobStat = grade::GetHPScale(grade, baseValueColumn) + (grade::GetHPScale(grade, scaleTo60Column) * (sLvl - 1)) +
                       (grade::GetHPScale(grade, scaleOver30Column) * subLevelOver30) + subLevelOver30 + subLevelOver10;
        }

        // Bonus HP Calculation
        bonusStat = (mainLevelOver10 + mainLevelOver50andUnder60) * 2;
        if (PPet->m_PetID == PETID_ODIN || PPet->m_PetID == PETID_ALEXANDER)
        {
            bonusStat += 6800;
        }
        PPet->health.maxhp = (int16)(raceStat + jobStat + bonusStat + sJobStat);
        PPet->health.hp    = PPet->health.maxhp;

        // if a spirit then add mp so it can cast spells
        if (PPet->m_PetID <= PETID_DARKSPIRIT)
        {
            // Start MP calculation
            raceStat = 0;
            jobStat  = 0;
            sJobStat = 0;

            grade = 4; // Grade for MP

            // If the main job doesn't have an MP rating, calculate the racial bonus based on the level of the subjob's level (assuming it has an MP rating)
            if (!(grade::GetJobGrade(mjob, 1) == 0 && grade::GetJobGrade(sjob, 1) == 0))
            {
                // calculate normal racial bonus
                raceStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                           grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
            }

            // For the main profession
            grade = grade::GetJobGrade(mjob, 1);
            if (grade > 0)
            {
                jobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                          grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
            }

            grade = grade::GetJobGrade(sjob, 1);
            if (grade > 0)
            {
                sJobStat = grade::GetMPScale(grade, 0) + grade::GetMPScale(grade, scaleTo60Column) * mainLevelUpTo60 +
                           grade::GetMPScale(grade, scaleOver60) * mainLevelOver60;
            }

            PPet->health.maxmp = (int32)(raceStat + jobStat + sJobStat);
        }

        PPet->UpdateHealth();
        PPet->health.tp  = 0;
        PPet->health.hp  = PPet->GetMaxHP();
        PPet->health.mp  = PPet->GetMaxMP();
        uint32 racegrade = 4; // Race Grade D

        uint16 fSTR = GetBaseToRank(racegrade, mLvl);
        uint16 fDEX = GetBaseToRank(racegrade, mLvl);
        uint16 fVIT = GetBaseToRank(racegrade, mLvl);
        uint16 fAGI = GetBaseToRank(racegrade, mLvl);
        uint16 fINT = GetBaseToRank(racegrade, mLvl);
        uint16 fMND = GetBaseToRank(racegrade, mLvl);
        uint16 fCHR = GetBaseToRank(racegrade, mLvl);

        uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 2), mLvl);
        uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 3), mLvl);
        uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 4), mLvl);
        uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 5), mLvl);
        uint16 mINT = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 6), mLvl);
        uint16 mMND = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 7), mLvl);
        uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetMJob(), 8), mLvl);

        uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 2), sLvl);
        uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 3), sLvl);
        uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 4), sLvl);
        uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 5), sLvl);
        uint16 sINT = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 6), sLvl);
        uint16 sMND = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 7), sLvl);
        uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PPet->GetSJob(), 8), sLvl);

        if (mLvl >= 45)
        {
            sSTR /= 2;
            sDEX /= 2;
            sAGI /= 2;
            sINT /= 2;
            sMND /= 2;
            sCHR /= 2;
            sVIT /= 2;
        }
        else if (mLvl > 30)
        {
            sSTR /= 3;
            sDEX /= 3;
            sAGI /= 3;
            sINT /= 3;
            sMND /= 3;
            sCHR /= 3;
            sVIT /= 3;
        }
        else
        {
            sSTR /= 4;
            sDEX /= 4;
            sAGI /= 4;
            sINT /= 4;
            sMND /= 4;
            sCHR /= 4;
            sVIT /= 4;
        }

        PPet->stats.STR = fSTR + mSTR + sSTR;
        PPet->stats.DEX = fDEX + mDEX + sDEX;
        PPet->stats.VIT = fVIT + mVIT + sVIT;
        PPet->stats.AGI = fAGI + mAGI + sAGI;
        PPet->stats.INT = fINT + mINT + sINT;
        PPet->stats.MND = fMND + mMND + sMND;
        PPet->stats.CHR = fCHR + mCHR + sCHR;

        // SMN Job Gift Bonuses, DRG and PUP handled in their respective functions
        if (PMaster->GetMJob() == JOB_SMN)
        {
            PPet->addModifier(Mod::ATT, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::DEF, PMaster->getMod(Mod::PET_ATK_DEF));
            PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
            PPet->addModifier(Mod::MATT, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MDEF, PMaster->getMod(Mod::PET_MAB_MDB));
            PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
            PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
        }

        // Set damageType for Avatars and Wyvern
        PPet->m_dmgType = DAMAGE_TYPE::SLASHING;
    }

    void CalculateAvatarStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID    = PPet->m_PetID;
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
                                        { return t->PetID == petID; });

        uint8 mLvl = PMaster->GetMLevel();

        if (PMaster->GetMJob() == JOB_SMN)
        {
            mLvl += PMaster->getMod(Mod::AVATAR_LVL_BONUS);

            if (petID == PETID_CARBUNCLE)
            {
                mLvl += PMaster->getMod(Mod::CARBUNCLE_LVL_BONUS);
            }
            else if (petID == PETID_CAIT_SITH)
            {
                mLvl += PMaster->getMod(Mod::CAIT_SITH_LVL_BONUS);
            }
            PPet->SetMLevel(mLvl);
            PPet->SetSLevel(mLvl); // Avatars always have the same level subjob as their main
        }
        else if (PMaster->GetSJob() == JOB_SMN)
        {
            PPet->SetMLevel(PMaster->GetSLevel());
            PPet->SetSLevel(PMaster->GetSLevel());
        }
        else
        { // should never happen
            ShowDebug("%s summoned an avatar but is not SMN main or SMN sub! Please report. ", PMaster->GetName());
            PPet->SetMLevel(1);
        }

        LoadAvatarStats(PMaster, PPet); // follows mobs calcs with subjob

        PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(PPetData->spellList);

        PPet->setModifier(Mod::DMGPHYS, -5000); //-50% PDT

        PPet->setModifier(Mod::CRIT_DMG_INCREASE, 8); // Avatars have Crit Att Bonus II for +8 crit dmg

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (320.0f / 60.0f))));

        if (petID == PETID_FENRIR)
        {
            static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0 * (280.0f / 60.0f))));
        }

        // In a 2014 update SE updated Avatar base damage
        // Based on testing this value appears to be Level now instead of Level * 0.74f
        // uint16 weaponDamage = 1 + mLvl;
        uint16 weaponDamage = 10 + (mLvl * 0.5);
        if (petID == PETID_CARBUNCLE || petID == PETID_CAIT_SITH)
        {
            weaponDamage = 3 + (mLvl * 0.5);
            // weaponDamage = static_cast<uint16>(floor(mLvl * 0.9f));
        }

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage(weaponDamage);
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (PPetData->cmbDelay / 60.0f))));

        PPet->setModifier(Mod::DEF, mobutils::GetDefense(PPet, PPet->defRank));
        PPet->setModifier(Mod::EVA, mobutils::GetBase(PPet, PPet->evaRank));
        PPet->setModifier(Mod::ATT, mobutils::GetBase(PPet, PPet->attRank));
        PPet->setModifier(Mod::ACC, mobutils::GetBase(PPet, PPet->accRank));

        // Fenrir has been proven to have an additional 30% ATK
        if (petID == PETID_FENRIR)
        {
            PPet->addModifier(Mod::ATT, 0.3 * mobutils::GetBase(PPet, PPet->attRank));
        }

        // Diabolos has been proven to have an additional 30% DEF
        if (petID == PETID_DIABOLOS)
        {
            PPet->addModifier(Mod::DEF, 0.3 * mobutils::GetDefense(PPet, PPet->defRank));
        }

        // cap all magic skills so they play nice with spell scripts
        for (int i = SKILL_DIVINE_MAGIC; i <= SKILL_BLUE_MAGIC; i++)
        {
            uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetMJob(), mLvl > 99 ? 99 : mLvl);
            if (maxSkill != 0)
            {
                PPet->WorkingSkills.skill[i] = maxSkill;
            }
            else // if the mob is WAR/BLM and can cast spell
            {
                // set skill as high as main level, so their spells won't get resisted
                uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i, PPet->GetSJob(), mLvl > 99 ? 99 : mLvl);

                if (maxSubSkill != 0)
                {
                    PPet->WorkingSkills.skill[i] = maxSubSkill;
                }
            }
        }

        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ATTACK, PChar));
            PPet->addModifier(Mod::ATT, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ATTACK, PChar));
            PPet->addModifier(Mod::MACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ACCURACY, PChar));
            PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ACCURACY, PChar));

            PPet->addModifier(Mod::ACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_ACC_BONUS));
            PPet->addModifier(Mod::MACC, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_ACC_BONUS));
            PPet->addModifier(Mod::ATT, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_PHYS_ATK_BONUS) * 2);
            PPet->addModifier(Mod::MAGIC_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_SUMMON_MAGIC_DMG_BONUS) * 5);
            PPet->addModifier(Mod::BP_DAMAGE, PChar->PJobPoints->GetJobPointValue(JP_BLOOD_PACT_DMG_BONUS) * 3);
        }

        PMaster->setModifier(Mod::AVATAR_PERPETUATION, PerpetuationCost(petID, mLvl));

        // Apply job traits to avatars
        BuildPetTraitsTable(PPet);

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateWyvernStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        PPet->SetMJob(JOB_DRG);
        // https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)#About_the_Wyvern
        uint8 mLvl = PMaster->GetMLevel();
        uint8 iLvl = std::clamp(charutils::getMainhandItemLevel(static_cast<CCharEntity*>(PMaster)) - 99, 0, 20);

        PPet->SetMLevel(mLvl + iLvl + PMaster->getMod(Mod::WYVERN_LVL_BONUS));
        PPet->SetSLevel(1); // Subjob level for Wyvern is always 1

        LoadAvatarStats(PMaster, PPet);                                                                               // follows PC calcs (w/o SJ)
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (320.0f / 60.0f)))); // 320 delay
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (320.0f / 60.0f))));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDamage((uint16)(floor(mLvl / 2) + 3));
        // Set stat modifiers
        PPet->setModifier(Mod::DEF, mobutils::GetDefense(PPet, PPet->defRank));
        PPet->setModifier(Mod::EVA, mobutils::GetBase(PPet, PPet->evaRank));
        PPet->setModifier(Mod::ATT, mobutils::GetBase(PPet, PPet->attRank));
        PPet->setModifier(Mod::ACC, mobutils::GetBase(PPet, PPet->accRank));

        // Set wyvern damageType to slashing damage. "Wyverns do slashing damage..." https://www.bg-wiki.com/ffxi/Wyvern_(Dragoon_Pet)
        PPet->m_dmgType = DAMAGE_TYPE::SLASHING;

        // Job Point: Wyvern Max HP
        if (PMaster->objtype == TYPE_PC)
        {
            uint8 jpValue = static_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_WYVERN_MAX_HP_BONUS);
            if (jpValue > 0)
            {
                PPet->addModifier(Mod::HP, jpValue * 10);
            }

            if (PMaster->GetMJob() == JOBTYPE::JOB_DRG)
            {
                PPet->addModifier(Mod::ACC, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::EVA, PMaster->getMod(Mod::PET_ACC_EVA));
                PPet->addModifier(Mod::MACC, PMaster->getMod(Mod::PET_MACC_MEVA));
                PPet->addModifier(Mod::MEVA, PMaster->getMod(Mod::PET_MACC_MEVA));
            }
        }

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateJugPetStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        uint32 petID    = PPet->m_PetID;
        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [petID](Pet_t* t)
                                        { return t->PetID == petID; });

        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setDelay((uint16)(floor(1000.0f * (240.0f / 60.0f))));
        static_cast<CItemWeapon*>(PPet->m_Weapons[SLOT_MAIN])->setBaseDelay((uint16)(floor(1000.0f * (240.0f / 60.0f))));
        // Get the Jug pet cap level
        uint8 highestLvl = PPetData->maxLevel;

        // Increase the pet's level cal by the bonus given by BEAST AFFINITY merits.
        CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
        highestLvl += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_AFFINITY, PChar);

        // And cap it to the master's level or their item's level if the player is level 99
        auto capLevel = 0;
        if ((lua["xi"]["settings"]["main"]["MAX_LEVEL"].get<uint16>() >= 99) && (PMaster->GetMLevel() >= 99))
        {
            capLevel = std::max(PMaster->GetMLevel(), PMaster->m_Weapons[SLOT_MAIN]->getILvl());
        }
        else
        {
            capLevel = PMaster->GetMLevel();
        }

        if (highestLvl > capLevel)
        {
            highestLvl = capLevel;
        }

        // Randomize: 0-2 lvls lower, less Monster Gloves(+1/+2) bonus
        highestLvl -= xirand::GetRandomNumber(3 - std::clamp<int16>(PChar->getMod(Mod::JUG_LEVEL_RANGE), 0, 2));

        PPet->SetMLevel(std::min(PPet->getSpawnLevel(), highestLvl));
        LoadJugStats(PPet, PPetData); // follow monster calcs (w/o SJ)

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateAutomatonStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        CAutomatonEntity* PAutomaton = static_cast<CAutomatonEntity*>(PPet);
        switch (PAutomaton->getFrame())
        {
            default: // case FRAME_HARLEQUIN:
                PPet->SetMJob(JOB_WAR);
                PPet->SetSJob(JOB_RDM);
                break;
            case FRAME_VALOREDGE:
                PPet->SetMJob(JOB_PLD);
                PPet->SetSJob(JOB_WAR);
                break;
            case FRAME_SHARPSHOT:
                PPet->SetMJob(JOB_RNG);
                PPet->SetSJob(JOB_PUP);
                break;
            case FRAME_STORMWAKER:
                PPet->SetMJob(JOB_RDM);
                PPet->SetSJob(JOB_WHM);
                break;
        }

        // TEMP: should be MLevel when unsummoned, and PUP level when summoned
        uint8 mainLevel = PMaster->GetMJob() == JOB_PUP ? PMaster->GetMLevel() + PMaster->getMod(Mod::AUTOMATON_LVL_BONUS) : PMaster->GetSLevel();
        if (PMaster->GetMJob() == JOB_PUP)
        {
            PPet->SetMLevel(mainLevel);
            PPet->SetSLevel(mainLevel / 2); // Todo: SetSLevel() already reduces the level?
        }
        else if (PMaster->GetSJob() == JOB_PUP)
        {
            PPet->SetMLevel(PMaster->GetSLevel());
            PPet->SetSLevel(PMaster->GetSLevel() / 2); // Todo: SetSLevel() already reduces the level?
        }

        LoadAutomatonStats(static_cast<CCharEntity*>(PMaster), PPet, g_PPetList.at(PPet->m_PetID)); // temp

        if (PMaster->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(PMaster);
            PPet->addModifier(Mod::ATTP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
            PPet->addModifier(Mod::DEFP, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
            PPet->addModifier(Mod::MATT, PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar));
            PPet->addModifier(Mod::ACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            PPet->addModifier(Mod::RACC, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            PPet->addModifier(Mod::EVA, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
            PPet->addModifier(Mod::MDEF, PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar));
        }

        FinalizePetStatistics(PMaster, PPet);
    }

    void CalculateLoupanStats(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        PPet->SetMLevel(PMaster->GetMLevel());
        PPet->health.maxhp = (uint32)floor((250 * PPet->GetMLevel()) / 15);

        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_BOLSTER))
        {
            uint8 bolsterJPVal = dynamic_cast<CCharEntity*>(PMaster)->PJobPoints->GetJobPointValue(JP_BOLSTER_EFFECT);
            PPet->health.maxhp += (uint32)floor(PPet->health.maxhp * (0.03 * bolsterJPVal));
        }

        PPet->health.hp = PPet->health.maxhp;

        // This sets the correct visual size for the luopan as pets currently
        // do not make use of the entity flags in the database
        // TODO: make pets use entity flags
        PPet->m_flags = 0x0000008B;
        // Just sit, do nothing
        PPet->speed = 0;

        FinalizePetStatistics(PMaster, PPet);
    }

    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // set C magic evasion
        PPet->setModifier(Mod::MEVA, battleutils::GetMaxSkill(SKILL_ELEMENTAL_MAGIC, JOB_RDM, PPet->GetMLevel() > 99 ? 99 : PPet->GetMLevel()));
        PMaster->applyPetModifiers(PPet);

        // Max [HP/MP] Boost traits
        PPet->UpdateHealth();
        PPet->health.tp = 0;
        PPet->health.hp = PPet->GetMaxHP();
        PPet->health.mp = PPet->GetMaxMP();

        // Stout Servant - Can't really tie it ot a real mod since it applies to the pet
        if (CCharEntity* PCharMaster = dynamic_cast<CCharEntity*>(PMaster))
        {
            if (charutils::hasTrait(PCharMaster, TRAIT_STOUT_SERVANT))
            {
                for (CTrait* trait : PCharMaster->TraitList)
                {
                    if (trait->getID() == TRAIT_STOUT_SERVANT)
                    {
                        PPet->addModifier(Mod::DMG, -(trait->getValue() * 100));
                        break;
                    }
                }
            }
        }
    }

    void SetupPetWithMaster(CBattleEntity* PMaster, CPetEntity* PPet)
    {
        // automaton gets theirs by attachment only
        if (PPet->getPetType() != PET_TYPE::AUTOMATON)
        {
            battleutils::AddTraits(PPet, traits::GetTraits(PPet->GetMJob()), PPet->GetMLevel());
            battleutils::AddTraits(PPet, traits::GetTraits(PPet->GetSJob()), PPet->GetSLevel());
        }

        charutils::BuildingCharAbilityTable(static_cast<CCharEntity*>(PMaster));
        charutils::BuildingCharPetAbilityTable(static_cast<CCharEntity*>(PMaster), PPet, PPet->m_PetID);
        static_cast<CCharEntity*>(PMaster)->pushPacket(new CCharUpdatePacket(static_cast<CCharEntity*>(PMaster)));
        static_cast<CCharEntity*>(PMaster)->pushPacket(new CPetSyncPacket(static_cast<CCharEntity*>(PMaster)));

        // check latents affected by pets
        static_cast<CCharEntity*>(PMaster)->PLatentEffectContainer->CheckLatentsPetType();

        // clang-format off
                PMaster->ForParty([](CBattleEntity* PMember)
                {
                    static_cast<CCharEntity*>(PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
                });
        // clang-format on
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_DEBILITATION))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_DEBILITATION, EFFECT_DEBILITATION, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_DEBILITATION)->GetPower(), 0, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_DEBILITATION)->GetDuration()), true);
        }
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_OMERTA))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_OMERTA, EFFECT_OMERTA, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetPower(), 0, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetDuration()), true);
        }
        if (PMaster->StatusEffectContainer->HasStatusEffect(EFFECT_IMPAIRMENT))
        {
            PPet->StatusEffectContainer->AddStatusEffect(new CStatusEffect(EFFECT_IMPAIRMENT, EFFECT_IMPAIRMENT, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetPower(), 0, PMaster->StatusEffectContainer->GetStatusEffect(EFFECT_IMPAIRMENT)->GetDuration()), true);
        }
    }

    /************************************************************************
     *                                                                      *
     *                                                                      *
     *                                                                      *
     ************************************************************************/

    void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        XI_DEBUG_BREAK_IF(PMaster->PPet != nullptr);

        if (PMaster->objtype == TYPE_PC &&
            (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME))
        {
            puppetutils::LoadAutomaton(static_cast<CCharEntity*>(PMaster));
            PMaster->PPet = static_cast<CCharEntity*>(PMaster)->PAutomaton;
        }
        else
        {
            LoadPet(PMaster, PetID, spawningFromZone);
        }

        CPetEntity* PPet = dynamic_cast<CPetEntity*>(PMaster->PPet);
        if (PPet)
        {
            PPet->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

            PPet->PMaster = PMaster;
            PPet->setBattleID(PMaster->getBattleID());

            if (PMaster->PBattlefield)
            {
                PPet->PBattlefield = PMaster->PBattlefield;
            }

            if (PMaster->PInstance)
            {
                PPet->PInstance = PMaster->PInstance;
            }

            if (spawningFromZone)
            {
                PPet->spawnAnimation = SPAWN_ANIMATION::NORMAL; // Don't play special spawn animation on zone in
            }

            PMaster->loc.zone->InsertPET(PPet);

            PPet->Spawn();
            if (PMaster->objtype == TYPE_PC)
            {
                SetupPetWithMaster(PMaster, PPet);
            }

            // apply stats from previous zone if this pet is being transferred
            if (spawningFromZone)
            {
                PPet->loadPetZoningInfo();
            }
        }
        else if (PMaster->objtype == TYPE_PC)
        {
            static_cast<CCharEntity*>(PMaster)->resetPetZoningInfo();
        }
    }

    void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID)
    {
        // this is ONLY used for mob smn elementals / avatars
        /*
        This should eventually be merged into one big spawn pet method.
        At the moment player pets and mob pets are totally different. We need a central place
        to manage pet families and spawn them.
        */

        // grab pet info
        Pet_t*      petData = g_PPetList.at(PetID);
        CMobEntity* PPet    = dynamic_cast<CMobEntity*>(PMaster->PPet);
        if (PPet)
        {
            PPet->look = petData->look;
            PPet->name = petData->name;
            PPet->SetMJob(petData->mJob);
            PPet->m_EcoSystem = petData->EcoSystem;
            PPet->m_Family    = petData->m_Family;
            PPet->m_Element   = petData->m_Element;
            PPet->HPscale     = petData->HPscale;
            PPet->MPscale     = petData->MPscale;

            PPet->allegiance = PMaster->allegiance;
            PMaster->StatusEffectContainer->CopyConfrontationEffect(PPet);

            // TODO: Lets not do this here.
            if (PPet->m_EcoSystem == ECOSYSTEM::AVATAR || PPet->m_EcoSystem == ECOSYSTEM::ELEMENTAL)
            {
                // assuming elemental spawn
                PPet->setModifier(Mod::DMGPHYS, -5000); //-50% PDT
            }

            PPet->m_SpellListContainer = mobSpellList::GetMobSpellList(petData->spellList);

            PPet->setModifier(Mod::SLASH_SDT, petData->slash_sdt);
            PPet->setModifier(Mod::PIERCE_SDT, petData->pierce_sdt);
            PPet->setModifier(Mod::HTH_SDT, petData->hth_sdt);
            PPet->setModifier(Mod::IMPACT_SDT, petData->impact_sdt);

            PPet->setModifier(Mod::FIRE_SDT, petData->fire_sdt);
            PPet->setModifier(Mod::ICE_SDT, petData->ice_sdt);
            PPet->setModifier(Mod::WIND_SDT, petData->wind_sdt);
            PPet->setModifier(Mod::EARTH_SDT, petData->earth_sdt);
            PPet->setModifier(Mod::THUNDER_SDT, petData->thunder_sdt);
            PPet->setModifier(Mod::WATER_SDT, petData->water_sdt);
            PPet->setModifier(Mod::LIGHT_SDT, petData->light_sdt);
            PPet->setModifier(Mod::DARK_SDT, petData->dark_sdt);

            PPet->setModifier(Mod::FIRE_MEVA, petData->fire_meva); // These are stored as signed integers which
            PPet->setModifier(Mod::ICE_MEVA, petData->ice_meva);   // is directly the modifier starting value.
            PPet->setModifier(Mod::WIND_MEVA, petData->wind_meva); // Positives signify increased resist chance.
            PPet->setModifier(Mod::EARTH_MEVA, petData->earth_meva);
            PPet->setModifier(Mod::THUNDER_MEVA, petData->thunder_meva);
            PPet->setModifier(Mod::WATER_MEVA, petData->water_meva);
            PPet->setModifier(Mod::LIGHT_MEVA, petData->light_meva);
            PPet->setModifier(Mod::DARK_MEVA, petData->dark_meva);
            /* Todo
            fire_res_rank
            ice_res_rank
            wind_res_rank
            earth_res_rank
            thunder_res_rank
            water_res_rank
            light_res_rank
            dark_res_rank
            */
        }
    }

    void DetachPet(CBattleEntity* PMaster, bool petUncharm)
    {
        XI_DEBUG_BREAK_IF(PMaster == nullptr);
        XI_DEBUG_BREAK_IF(PMaster->PPet == nullptr);
        XI_DEBUG_BREAK_IF(PMaster->objtype != TYPE_PC);

        CBattleEntity* PPet  = PMaster->PPet;
        CCharEntity*   PChar = static_cast<CCharEntity*>(PMaster);

        if (PPet->objtype == TYPE_MOB)
        {
            CMobEntity* PMob = static_cast<CMobEntity*>(PPet);

            if (!PMob->isDead())
            {
                PMob->PAI->Disengage();

                // charm time is up, mob attacks player now
                if (PMob->PEnmityContainer->IsWithinEnmityRange(PMob->PMaster) && petUncharm)
                {
                    PMob->PEnmityContainer->UpdateEnmity(PChar, 1, 1);
                    PMob->SetBattleTargetID(PChar->targid);
                }
                else
                {
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                }

                // dirty exp if not full
                PMob->m_giveExp = PMob->GetHPP() == 100;

                // master using leave command
                auto* state = dynamic_cast<CAbilityState*>(PMaster->PAI->GetCurrentState());
                if ((state && state->GetAbility()->getID() == ABILITY_LEAVE) || PChar->loc.zoning || PChar->isDead())
                {
                    PMob->PEnmityContainer->Clear();
                    PMob->m_OwnerID.clean();
                    PMob->updatemask |= UPDATE_STATUS;
                }
            }
            else
            {
                PMob->m_OwnerID.clean();
                PMob->updatemask |= UPDATE_STATUS;
            }

            PMob->isCharmed  = false;
            PMob->allegiance = ALLEGIANCE_TYPE::MOB;
            PMob->charmTime  = time_point::min();
            PMob->PMaster    = nullptr;

            PMob->PAI->SetController(std::make_unique<CMobController>(PMob));
        }
        else if (PPet->objtype == TYPE_PET)
        {
            if (!PPet->isDead())
            {
                PPet->Die();
            }
            CPetEntity* PPetEnt = static_cast<CPetEntity*>(PPet);

            if (PPetEnt->getPetType() == PET_TYPE::AVATAR)
            {
                PMaster->setModifier(Mod::AVATAR_PERPETUATION, 0);
            }

            static_cast<CCharEntity*>(PMaster)->PLatentEffectContainer->CheckLatentsPetType();

            // clang-format off
            PMaster->ForParty([](CBattleEntity* PMember)
            {
                static_cast<CCharEntity*>(PMember)->PLatentEffectContainer->CheckLatentsPartyAvatar();
            });
            // clang-format on

            if (PPetEnt->getPetType() != PET_TYPE::AUTOMATON)
            {
                PPetEnt->PMaster = nullptr;
            }
            else
            {
                PPetEnt->PAI->SetController(nullptr);
            }
            PChar->removePetModifiers(PPetEnt);
            charutils::BuildingCharPetAbilityTable(PChar, PPetEnt, 0); // blank the pet commands
        }

        charutils::BuildingCharAbilityTable(PChar);
        PChar->PPet = nullptr;
        PChar->pushPacket(new CCharUpdatePacket(PChar));
        PChar->pushPacket(new CCharAbilitiesPacket(PChar));
        PChar->pushPacket(new CPetSyncPacket(PChar));
    }

    /************************************************************************
     *                                                                      *
     *                                                                      *
     *                                                                      *
     ************************************************************************/

    void DespawnPet(CBattleEntity* PMaster)
    {
        XI_DEBUG_BREAK_IF(PMaster == nullptr);
        XI_DEBUG_BREAK_IF(PMaster->PPet == nullptr);

        petutils::DetachPet(PMaster);
    }

    int16 PerpetuationCost(uint32 id, uint8 level)
    {
        int16 cost = 0;

        // Fire Spirit through Dark Spirit
        if (id <= PETID_DARKSPIRIT)
        {
            if (level < 5)
            {
                cost = 2;
            }
            else if (level < 9)
            {
                cost = 3;
            }
            else if (level < 14)
            {
                cost = 4;
            }
            else if (level < 18)
            {
                cost = 5;
            }
            else if (level < 23)
            {
                cost = 6;
            }
            else if (level < 27)
            {
                cost = 7;
            }
            else if (level < 32)
            {
                cost = 8;
            }
            else if (level < 36)
            {
                cost = 9;
            }
            else if (level < 40)
            {
                cost = 10;
            }
            else if (level < 46)
            {
                cost = 11;
            }
            else if (level < 49)
            {
                cost = 12;
            }
            else if (level < 54)
            {
                cost = 13;
            }
            else if (level < 58)
            {
                cost = 14;
            }
            else if (level < 63)
            {
                cost = 15;
            }
            else if (level < 67)
            {
                cost = 16;
            }
            else if (level < 72)
            {
                cost = 17;
            }
            else
            {
                cost = 18;
            }
        }
        else if (id == PETID_CARBUNCLE)
        {
            if (level < 10)
            {
                cost = 1;
            }
            else if (level < 18)
            {
                cost = 2;
            }
            else if (level < 27)
            {
                cost = 3;
            }
            else if (level < 36)
            {
                cost = 4;
            }
            else if (level < 45)
            {
                cost = 5;
            }
            else if (level < 54)
            {
                cost = 6;
            }
            else if (level < 63)
            {
                cost = 7;
            }
            else if (level < 72)
            {
                cost = 8;
            }
            else
            {
                cost = 9;
            }
        }
        else if (id == PETID_FENRIR)
        {
            if (level < 8)
            {
                cost = 1;
            }
            else if (level < 15)
            {
                cost = 2;
            }
            else if (level < 22)
            {
                cost = 3;
            }
            else if (level < 30)
            {
                cost = 4;
            }
            else if (level < 37)
            {
                cost = 5;
            }
            else if (level < 45)
            {
                cost = 6;
            }
            else if (level < 51)
            {
                cost = 7;
            }
            else if (level < 59)
            {
                cost = 8;
            }
            else if (level < 66)
            {
                cost = 9;
            }
            else if (level < 73)
            {
                cost = 10;
            }
            else
            {
                cost = 11;
            }
        }
        // NOTE: This condition covers PETID_IFRIT through the below conditions
        else if (id <= PETID_DIABOLOS || id == PETID_SIREN)
        {
            if (level < 10)
            {
                cost = 3;
            }
            else if (level < 19)
            {
                cost = 4;
            }
            else if (level < 28)
            {
                cost = 5;
            }
            else if (level < 38)
            {
                cost = 6;
            }
            else if (level < 47)
            {
                cost = 7;
            }
            else if (level < 56)
            {
                cost = 8;
            }
            else if (level < 65)
            {
                cost = 9;
            }
            else if (level < 68)
            {
                cost = 10;
            }
            else if (level < 71)
            {
                cost = 11;
            }
            else if (level < 74)
            {
                cost = 12;
            }
            else
            {
                cost = 13;
            }
        }

        return cost;
    }

    /*
    Familiars a pet.
    */
    void Familiar(CBattleEntity* PPet)
    {
        /*
            Boost HP by 10%
            Increase charm duration up to 30 mins
            */

        if (PPet == nullptr)
        {
            return;
        }

        // only increase time for charmed mobs
        if (PPet->objtype == TYPE_MOB && PPet->isCharmed)
        {
            // increase charm duration
            // set initial charm time
            PPet->charmTime = server_clock::now();
            // 30 mins - 1-5 mins
            uint32 baseTime = 1800000;
            uint32 randTime = xirand::GetRandomNumber(45000, 300000);
            PPet->charmTime += std::chrono::milliseconds(baseTime - randTime);
        }

        float rate = 0.10f;

        // boost hp by 10%
        uint16 boost = (uint16)(PPet->health.maxhp * rate);

        PPet->health.maxhp += boost;
        PPet->health.hp += boost;
        PPet->UpdateHealth();
    }

    void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone)
    {
        XI_DEBUG_BREAK_IF(PMaster == nullptr);
        XI_DEBUG_BREAK_IF(PetID >= MAX_PETID);

        Pet_t* PPetData = *std::find_if(g_PPetList.begin(), g_PPetList.end(), [PetID](Pet_t* t)
                                        { return t->PetID == PetID; });

        if (PMaster->GetMJob() != JOB_DRG && PetID == PETID_WYVERN)
        {
            return;
        }

        if (PMaster->objtype == TYPE_PC)
        {
            static_cast<CCharEntity*>(PMaster)->petZoningInfo.petID = PetID;
        }

        PET_TYPE petType = PET_TYPE::JUG_PET;

        if (PetID <= PETID_CAIT_SITH || PetID == PETID_SIREN)
        {
            petType = PET_TYPE::AVATAR;
        }
        // TODO: move this out of modifying the global pet list
        else if (PetID == PETID_WYVERN)
        {
            petType = PET_TYPE::WYVERN;

            const char* Query = "SELECT\
                pet_name.name,\
                char_pet.wyvernid\
                FROM pet_name, char_pet\
                WHERE pet_name.id = char_pet.wyvernid AND \
                char_pet.charid = %u";

            if (sql->Query(Query, PMaster->id) != SQL_ERROR && sql->NumRows() != 0)
            {
                while (sql->NextRow() == SQL_SUCCESS)
                {
                    uint16 wyvernid = (uint16)sql->GetIntData(1);

                    if (wyvernid != 0)
                    {
                        PPetData->name.clear();
                        PPetData->name.insert(0, (const char*)sql->GetData(0));
                    }
                }
            }
        }
        else if (PetID == PETID_CHOCOBO)
        {
            petType = PET_TYPE::CHOCOBO;

            const char* Query = "SELECT\
                char_pet.chocoboid\
                FROM char_pet\
                char_pet.charid = %u";

            if (sql->Query(Query, PMaster->id) != SQL_ERROR && sql->NumRows() != 0)
            {
                while (sql->NextRow() == SQL_SUCCESS)
                {
                    uint32 chocoboid = (uint32)sql->GetIntData(0);

                    if (chocoboid != 0)
                    {
                        uint16 chocoboname1 = chocoboid & 0x0000FFFF;
                        uint16 chocoboname2 = chocoboid >>= 16;

                        PPetData->name.clear();

                        Query = "SELECT\
                            pet_name.name\
                            FROM pet_name\
                            WHERE pet_name.id = %u OR pet_name.id = %u";

                        if (sql->Query(Query, chocoboname1, chocoboname2) != SQL_ERROR && sql->NumRows() != 0)
                        {
                            while (sql->NextRow() == SQL_SUCCESS)
                            {
                                if (chocoboname1 != 0 && chocoboname2 != 0)
                                {
                                    PPetData->name.insert(0, (const char*)sql->GetData(0));
                                }
                            }
                        }
                    }
                }
            }
        }
        else if (PetID == PETID_HARLEQUINFRAME || PetID == PETID_VALOREDGEFRAME || PetID == PETID_SHARPSHOTFRAME || PetID == PETID_STORMWAKERFRAME)
        {
            petType = PET_TYPE::AUTOMATON;
        }
        else if (PetID == PETID_LUOPAN)
        {
            petType = PET_TYPE::LUOPAN;
        }

        CPetEntity* PPet = nullptr;
        if (petType == PET_TYPE::AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            PPet = static_cast<CCharEntity*>(PMaster)->PAutomaton;
            PPet->PAI->SetController(std::make_unique<CAutomatonController>(static_cast<CAutomatonEntity*>(PPet)));
        }
        else
        {
            PPet = new CPetEntity(petType);
            PPet->saveModifiers();

            if (petType == PET_TYPE::AVATAR || PetID <= PETID_DARKSPIRIT)
            {
                PPet->PMaster = PMaster;
                PPet->m_PetID = PetID;
                PPet->PAI->SetController(std::make_unique<CSpiritController>(PPet));
            }
        }

        PPet->loc = PMaster->loc;

        if (petType == PET_TYPE::LUOPAN)
        {
            // spawn the luopan at the targets position with offsets from the action packet
            // this is calculated in the action packet to avoid incorrect placement after casting
            // m_ActionOffsetPos is a combination of targets pos + action offset pos
            PPet->loc.p = dynamic_cast<CCharEntity*>(PMaster)->m_ActionOffsetPos;
        }
        else
        {
            // spawn me randomly around master
            PPet->loc.p = nearPosition(PMaster->loc.p, CPetController::PetRoamDistance, (float)M_PI);
        }

        if (petType != PET_TYPE::AUTOMATON)
        {
            PPet->look = PPetData->look;
            PPet->name = PPetData->name;
        }
        else
        {
            PPet->look.size = MODEL_AUTOMATON;
        }

        // Set core member values
        PPet->m_name_prefix  = PPetData->name_prefix;
        PPet->m_Family       = PPetData->m_Family;
        PPet->m_MobSkillList = PPetData->m_MobSkillList;
        PPet->SetMJob(PPetData->mJob);
        PPet->SetSJob(PPetData->sJob);
        PPet->m_Element = PPetData->m_Element;
        PPet->m_PetID   = PPetData->PetID;

        // Set base stat ranks - likely overridden, but prefer to default to DB values if not
        PPet->strRank = PPetData->strRank;
        PPet->dexRank = PPetData->dexRank;
        PPet->vitRank = PPetData->vitRank;
        PPet->agiRank = PPetData->agiRank;
        PPet->intRank = PPetData->intRank;
        PPet->mndRank = PPetData->mndRank;
        PPet->chrRank = PPetData->chrRank;

        // Set baseline battle stats
        PPet->defRank = PPetData->defRank;
        PPet->attRank = PPetData->attRank;
        PPet->accRank = PPetData->accRank;
        PPet->evaRank = PPetData->evaRank;

        if (PPet->getPetType() == PET_TYPE::AVATAR)
        {
            CalculateAvatarStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::JUG_PET)
        {
            uint8 spawnLevel = static_cast<CCharEntity*>(PMaster)->petZoningInfo.petLevel;
            PPet->setSpawnLevel(spawnLevel > 0 ? spawnLevel : UINT8_MAX);
            PPet->setJugDuration(static_cast<int32>(PPetData->time));
            CalculateJugPetStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::WYVERN)
        {
            CalculateWyvernStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::AUTOMATON && PMaster->objtype == TYPE_PC)
        {
            CalculateAutomatonStats(PMaster, PPet);
        }
        else if (PPet->getPetType() == PET_TYPE::LUOPAN && PMaster->objtype == TYPE_PC)
        {
            CalculateLoupanStats(PMaster, PPet);
        }

        PPet->setSpawnLevel(PPet->GetMLevel());
        PPet->status        = STATUS_TYPE::NORMAL;
        PPet->m_ModelRadius = PPetData->radius;
        PPet->m_EcoSystem   = PPetData->EcoSystem;

        PMaster->PPet = PPet;
    }

    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod)
    {
        if (petmod == PetModType::All)
        {
            return true;
        }

        if (auto* PPetEntity = dynamic_cast<CPetEntity*>(PPet))
        {
            if (petmod == PetModType::Avatar && PPetEntity->getPetType() == PET_TYPE::AVATAR)
            {
                return true;
            }
            if (petmod == PetModType::Wyvern && PPetEntity->getPetType() == PET_TYPE::WYVERN)
            {
                return true;
            }
            if (petmod >= PetModType::Automaton && petmod <= PetModType::Stormwaker && PPetEntity->getPetType() == PET_TYPE::AUTOMATON)
            {
                if (petmod == PetModType::Automaton || (uint16)petmod + 28 == (uint16) static_cast<CAutomatonEntity*>(PPetEntity)->getFrame())
                {
                    return true;
                }
            }
            if (petmod == PetModType::Luopan && PPetEntity->getPetType() == PET_TYPE::LUOPAN)
            {
                return true;
            }
        }
        else
        {
            return true;
        }
        return false;
    }

    void AddTraits(CPetEntity* PPet, TraitList_t* traitList, uint8 level)
    {
        for (auto&& PTrait : *traitList)
        {
            if (level >= PTrait->getLevel() && PTrait->getLevel() > 0)
            {
                bool add = true;

                for (std::size_t j = 0; j < PPet->TraitList.size(); ++j)
                {
                    CTrait* PExistingTrait = PPet->TraitList.at(j);

                    if (PExistingTrait->getID() == PTrait->getID())
                    {
                        if (PExistingTrait->getRank() < PTrait->getRank())
                        {
                            PPet->delTrait(PExistingTrait);
                            break;
                        }
                        else if (PExistingTrait->getRank() > PTrait->getRank())
                        {
                            add = false;
                            break;
                        }
                        else if (PExistingTrait->getMod() == PTrait->getMod())
                        {
                            add = false;
                            break;
                        }
                    }
                }

                if (add)
                {
                    PPet->addTrait(PTrait);
                }
            }
        }
    }

    void BuildPetTraitsTable(CPetEntity* PPet)
    {
        // Clear any existing traits from the Pet's table
        for (std::size_t i = 0; i < PPet->TraitList.size(); ++i)
        {
            CTrait* PTrait = PPet->TraitList.at(i);
            PPet->delModifier(PTrait->getMod(), PTrait->getValue());
        }
        PPet->TraitList.clear();

        // Add traits based on the pet job / subjob
        memset(&PPet->m_TraitList, 0, sizeof(PPet->m_TraitList));
        AddTraits(PPet, traits::GetTraits(PPet->GetMJob()), PPet->GetMLevel());

        if (PPet->getPetType() == PET_TYPE::WYVERN)
        {
            if (PPet->PMaster && PPet->PMaster->objtype == TYPE_PC && PPet->PMaster->GetMJob() == JOB_DRG)
            {
                auto PChar = static_cast<CCharEntity*>(PPet->PMaster);
                if (PChar->getEquip(SLOT_BODY) != nullptr &&
                    (PChar->getEquip(SLOT_BODY)->getID() == 15100 ||
                     PChar->getEquip(SLOT_BODY)->getID() == 14513))
                {
                    AddTraits(PPet, traits::GetTraits(PPet->GetSJob()), PPet->GetSLevel());
                }
            }
        }
        else
        {
            AddTraits(PPet, traits::GetTraits(PPet->GetSJob()), PPet->GetSLevel());
        }
    }

}; // namespace petutils
