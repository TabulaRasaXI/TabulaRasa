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

#include "common/socket.h"

#include "../entities/charentity.h"
#include "../instance.h"
#include "../status_effect_container.h"
#include "../utils/zoneutils.h"
#include "../vana_time.h"
#include "map/zone.h"
#include "zone_in.h"

/************************************************************************
 *                                                                       *
 *  Returns the ID of the mog house map to be used                       *
 *                                                                       *
 ************************************************************************/

uint16 GetMogHouseID(CCharEntity* PChar)
{
    // TODO: verify wtf is going on with this function. either these aren't supposed to be zone IDs or somehow Jeuno's mog is western adoulin!
    switch (zoneutils::GetCurrentRegion(PChar->getZone()))
    {
        case REGION_TYPE::WEST_AHT_URHGAN:
            return ZONE_214;
        case REGION_TYPE::RONFAURE_FRONT:
            return ZONE_189;
        case REGION_TYPE::GUSTABERG_FRONT:
            return ZONE_199;
        case REGION_TYPE::SARUTA_FRONT:
            return ZONE_219;
        case REGION_TYPE::SANDORIA:
            return (PChar->profile.nation == 0 ? 0x0121 : 0x0101);
        case REGION_TYPE::BASTOK:
            return (PChar->profile.nation == 1 ? 0x0122 : 0x0102);
        case REGION_TYPE::WINDURST:
            return (PChar->profile.nation == 2 ? 0x0123 : 0x0120);
        case REGION_TYPE::JEUNO:
            return 0x0100;
        default:
            ShowWarning("Default case reached for GetMogHouseID by %s (%u)", PChar->GetName(), PChar->getZone());
            return 0x0100;
    }
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

uint8 GetMogHouseFlag(CCharEntity* PChar)
{
    switch (zoneutils::GetCurrentRegion(PChar->getZone()))
    {
        case REGION_TYPE::WEST_AHT_URHGAN:
            if (PChar->profile.mhflag & 0x10)
            {
                return 5;
            }
            break;
        case REGION_TYPE::SANDORIA:
            if (PChar->profile.mhflag & 0x01)
            {
                return 1;
            }
            break;
        case REGION_TYPE::BASTOK:
            if (PChar->profile.mhflag & 0x02)
            {
                return 2;
            }
            break;
        case REGION_TYPE::WINDURST:
            if (PChar->profile.mhflag & 0x04)
            {
                return 3;
            }
            break;
        case REGION_TYPE::JEUNO:
            if (PChar->profile.mhflag & 0x08)
            {
                return 4;
            }
            break;
        default:
            break;
    }
    return 0;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CZoneInPacket::CZoneInPacket(CCharEntity* PChar, const EventInfo* currentEvent)
{
    this->setType(0x0A);
    this->setSize(0x104);

    // необходимо для работы manaklipper
    // последние 8 байт похожи на время
    // unsigned char packet [] = {
    // 0x0D, 0x3A, 0x0C, 0x00, 0x11, 0x00, 0x19, 0x00, 0x02, 0xE4, 0x93, 0x10, 0x91, 0xE5, 0x93, 0x10}; // 0x2a = 0x10
    // 0x89, 0x39, 0x0C, 0x00, 0x19, 0x00, 0x07, 0x00, 0x5C, 0xE1, 0x93, 0x10, 0x81, 0xE3, 0x93, 0x10}; // 0x2a = 0x08
    // memcpy(data + 0x70, &packet, 16);

    // data[0x2A] = 0x08;//data[0x2A] = 0x80;  // в зоне 3 управляет путями следования транспорта 0x10 и 0x08

    ref<uint32>(0x04) = PChar->id;
    ref<uint16>(0x08) = PChar->targid;

    memcpy(data + (0x84), PChar->GetName().c_str(), PChar->GetName().size());

    ref<uint8>(0x0B) = PChar->loc.p.rotation;
    ref<float>(0x0C) = PChar->loc.p.x;
    ref<float>(0x10) = PChar->loc.p.y;
    ref<float>(0x14) = PChar->loc.p.z;

    ref<uint8>(0x1C) = PChar->GetSpeed();
    ref<uint8>(0x1D) = PChar->speedsub;
    ref<uint8>(0x1E) = PChar->GetHPP();
    ref<uint8>(0x1F) = PChar->animation;

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        ref<uint8>(0x20) = static_cast<uint8>(PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower());
    }

    ref<uint8>(0x21) = PChar->GetGender() * 128 + (1 << PChar->look.size);

    // Zone Animation for Transports
    ref<uint8>(0x27)  = PChar->loc.zone->GetZoneDirection();
    ref<uint8>(0x2A)  = PChar->loc.zone->GetZoneAnimation();
    ref<uint32>(0x78) = PChar->loc.zone->GetZoneAnimStartTime();
    ref<uint16>(0x7C) = PChar->loc.zone->GetZoneAnimLength();

    look_t* look      = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);
    ref<uint8>(0x44)  = look->face;
    ref<uint8>(0x45)  = look->race;
    ref<uint16>(0x46) = PChar->menuConfigFlags.flags & NFLAG_DISPLAY_HEAD ? 0 : look->head + 0x1000;
    ref<uint16>(0x48) = look->body + 0x2000;
    ref<uint16>(0x4A) = look->hands + 0x3000;
    ref<uint16>(0x4C) = look->legs + 0x4000;
    ref<uint16>(0x4E) = look->feet + 0x5000;
    ref<uint16>(0x50) = look->main + 0x6000;
    ref<uint16>(0x52) = look->sub + 0x7000;
    ref<uint16>(0x54) = look->ranged + 0x8000;

    if (PChar->m_Monstrosity != 0)
    {
        ref<uint16>(0x44) = PChar->m_Monstrosity;
        ref<uint16>(0x54) = 0xFFFF;
    }

    ref<uint8>(0x56) = PChar->PInstance ? PChar->PInstance->GetBackgroundMusicDay() : PChar->loc.zone->GetBackgroundMusicDay();
    ref<uint8>(0x58) = PChar->PInstance ? PChar->PInstance->GetBackgroundMusicNight() : PChar->loc.zone->GetBackgroundMusicNight();
    ref<uint8>(0x5A) = PChar->PInstance ? PChar->PInstance->GetSoloBattleMusic() : PChar->loc.zone->GetSoloBattleMusic();
    ref<uint8>(0x5C) = PChar->PInstance ? PChar->PInstance->GetPartyBattleMusic() : PChar->loc.zone->GetPartyBattleMusic();
    ref<uint8>(0x5E) = PChar->animation == ANIMATION_MOUNT ? 0x54 : 0xD4;

    ref<uint16>(0x60) = PChar->loc.boundary;
    ref<uint16>(0x68) = PChar->loc.zone->GetWeather();
    ref<uint32>(0x6A) = PChar->loc.zone->GetWeatherChangeTime();
    // ref<uint32>(0x6C) = PChar->loc.zone->GetWeather();
    // ref<uint32>(0x70) = PChar->loc.zone->GetWeatherChangeTime();

    auto csid = currentEvent->eventId;
    if (csid != -1)
    {
        // ref<uint8>(data,(0x1F)) = 4;                             // предположительно animation
        // ref<uint8>(data,(0x20)) = 2;

        ref<uint16>(0x40) = PChar->currentEvent->textTable == -1 ? PChar->getZone() : PChar->currentEvent->textTable;
        ref<uint16>(0x62) = PChar->getZone();
        ref<uint16>(0x64) = currentEvent->eventId;

        // Note that only the first 16 bits are supported by this packet type.
        ref<uint16>(0x66) = currentEvent->eventFlags & 0xFFFF;
    }

    ref<uint16>(0x30) = PChar->getZone();
    ref<uint16>(0x42) = PChar->getZone();

    if (PChar->m_moghouseID != 0)
    {
        ref<uint8>(0x80)  = 1;
        ref<uint16>(0xAA) = GetMogHouseID(PChar);   // Mog House id
        ref<uint8>(0xAE)  = GetMogHouseFlag(PChar); // Mog House leaving flag
    }
    else
    {
        ref<uint8>(0x80)  = 2;
        ref<uint16>(0xAA) = 0x01FF;
        ref<uint8>(0xAC)  = csid > 0 ? 0x01 : 0x00;                    // if 0x01 then pause between zone
        ref<uint8>(0xAF)  = PChar->loc.zone->CanUseMisc(MISC_MOGMENU); // флаг, позволяет использовать mog menu за пределами mog house
    }

    ref<uint32>(0xA0) = PChar->GetPlayTime(); // время, проведенное персонажем в игре с момента создания

    uint32 pktTime = CVanaTime::getInstance()->getVanaTime();

    ref<uint32>(0x38) = pktTime + VTIME_BASEDATE;
    ref<uint32>(0x3C) = pktTime;

    ref<uint32>(0xA4) = PChar->GetTimeRemainingUntilDeathHomepoint();

    ref<uint8>(0xB4) = PChar->GetMJob();
    ref<uint8>(0xB7) = PChar->GetSJob();

    memcpy(data + (0xCC), &PChar->stats, 14);

    ref<uint32>(0xE8) = PChar->GetMaxHP();
    ref<uint32>(0xEC) = PChar->GetMaxMP();

    // MenuConfig (F4-F7) -- see CMenuConfigPacket
    ref<uint8>(0xF4) = 0x18 | PChar->menuConfigFlags.byte1 | (PChar->nameflags.flags & static_cast<uint32>(FLAG_INVITE) ? static_cast<uint32>(NFLAG_INVITE) : 0);
    ref<uint8>(0xF5) = PChar->menuConfigFlags.byte2 | (PChar->m_hasAutoTarget ? 0 : NFLAG_AUTOTARGET >> 8);
    ref<uint8>(0xF6) = PChar->menuConfigFlags.byte3;
    ref<uint8>(0xF7) = PChar->menuConfigFlags.byte4;

    // ChatFilterFlags (F8-FF)
    ref<uint64>(0xF8) = PChar->chatFilterFlags;

    ref<uint8>(0x100) = 0x01; // observed: RoZ = 3, CoP = 5, ToAU = 9, WoTG = 11, SoA/original areas = 1
}
