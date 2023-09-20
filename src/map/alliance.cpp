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

#include "alliance.h"
#include "../common/logging.h"

#include <algorithm>
#include <cstring>

#include "conquest_system.h"
#include "entities/battleentity.h"
#include "map.h"
#include "message.h"
#include "party.h"
#include "treasure_pool.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"

#include "packets/char_sync.h"
#include "packets/char_update.h"
#include "packets/menu_config.h"
#include "packets/party_define.h"
#include "packets/party_member_update.h"

CAlliance::CAlliance(CBattleEntity* PEntity)
{
    XI_DEBUG_BREAK_IF(PEntity->PParty == nullptr);

    m_AllianceID = PEntity->PParty->GetPartyID();

    // Will need to deal with these:
    // m_PSyncTarget
    // m_PQuarterMaster

    addParty(PEntity->PParty);
    this->aLeader = PEntity->PParty;
    sql->Query("UPDATE accounts_parties SET partyflag = partyflag | %d WHERE partyid = %u AND partyflag & %d;", ALLIANCE_LEADER, m_AllianceID,
               PARTY_LEADER);
}

CAlliance::CAlliance(uint32 id)
: m_AllianceID(id)
, aLeader(nullptr)
{
}

void CAlliance::dissolveAlliance(bool playerInitiated)
{
    if (playerInitiated)
    {
        // sql->Query("UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~%d WHERE allianceid = %u;", ALLIANCE_LEADER | PARTY_SECOND
        // | PARTY_THIRD, m_AllianceID);
        uint8 data[8]{};
        ref<uint32>(data, 0) = m_AllianceID;
        ref<uint32>(data, 4) = m_AllianceID;
        message::send(MSG_PT_DISBAND, data, sizeof data, nullptr);
    }
    else
    {
        sql->Query("UPDATE accounts_parties JOIN accounts_sessions USING (charid) \
                        SET allianceid = 0, partyflag = partyflag & ~%d \
                        WHERE allianceid = %u AND IF(%u = 0 AND %u = 0, true, server_addr = %u AND server_port = %u);",
                   ALLIANCE_LEADER | PARTY_SECOND | PARTY_THIRD, m_AllianceID, map_ip.s_addr, map_port, map_ip.s_addr, map_port);

        // first kick out the third party if it exsists
        CParty* party = nullptr;
        if (this->partyList.size() == 3)
        {
            party = this->partyList.at(2);
            this->delParty(party);
            party->ReloadParty();
        }

        // kick out the second party
        if (this->partyList.size() == 2)
        {
            party = this->partyList.at(1);
            this->delParty(party);
            party->ReloadParty();
        }

        // kick out the first party
        if (this->partyList.size() == 1)
        {
            party              = this->partyList.at(0);
            party->m_PAlliance = nullptr;
            party->ReloadParty();
        }

        this->partyList.clear();

        // TODO: This entire system needs rewriting to both:
        //     : - Make it stable
        //     : - Get rid of `delete this` and manage memory nicely
        delete this; // cpp.sh allow
    }
}

bool CAlliance::hasOnlyOneParty() const
{
    if (partyList.size() != 1)
    {
        return false;
    }

    // Load party count to make sure that there is only one party in the alliance across all servers
    return loadPartyCount() == 1;
}

bool CAlliance::isFull() const
{
    if (partyList.size() == 3)
    {
        return true;
    }

    // Load party count to make sure that that all parties are accounted for across all servers
    return loadPartyCount() == 3;
}

uint32 CAlliance::loadPartyCount() const
{
    int ret = sql->Query("SELECT * FROM accounts_parties WHERE allianceid = %u GROUP BY partyid;", m_AllianceID, PARTY_SECOND | PARTY_THIRD);
    if (ret != SQL_ERROR)
    {
        return (uint32)sql->NumRows();
    }
    return 0;
}

void CAlliance::removeParty(CParty* party)
{
    // if main party then pass alliance lead to the next (d/c fix)
    if (this->getMainParty() == party)
    {
        int ret = sql->Query("SELECT charname FROM accounts_sessions JOIN chars ON accounts_sessions.charid = chars.charid \
                                JOIN accounts_parties ON accounts_parties.charid = chars.charid WHERE allianceid = %u AND partyflag & %d \
                                AND partyid != %d ORDER BY timestamp ASC LIMIT 1;",
                             m_AllianceID, PARTY_LEADER, party->GetPartyID());
        if (ret != SQL_ERROR && sql->NumRows() != 0 && sql->NextRow() == SQL_SUCCESS)
        {
            std::string newLeader((const char*)sql->GetData(0));
            assignAllianceLeader(newLeader.c_str());
        }
        if (this->getMainParty() == party)
        {
            dissolveAlliance();
            return;
        }
    }

    delParty(party);

    sql->Query("UPDATE accounts_parties SET allianceid = 0, partyflag = partyflag & ~%d WHERE partyid = %u;",
               ALLIANCE_LEADER | PARTY_SECOND | PARTY_THIRD, party->GetPartyID());
    uint8 data[4]{};
    ref<uint32>(data, 0) = m_AllianceID;
    message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);

    uint8 data2[4]{};
    ref<uint32>(data2, 0) = party->GetPartyID();
    message::send(MSG_PT_RELOAD, data2, sizeof data2, nullptr);
}

void CAlliance::delParty(CParty* party)
{
    // Don't delete parties when there's no party in the alliance
    if (!party->m_PAlliance || party->m_PAlliance->partyList.size() == 0)
    {
        return;
    }

    // Delete the party from the alliance list
    party->m_PAlliance->partyList.erase(
        std::remove_if(party->m_PAlliance->partyList.begin(), party->m_PAlliance->partyList.end(), [=](CParty* entry)
                       { return party == entry; }));

    for (auto* entry : party->m_PAlliance->partyList)
    {
        entry->ReloadParty();
    }

    party->m_PAlliance = nullptr;
    party->SetPartyNumber(0);

    // Remove party members from the alliance treasure pool
    for (auto* entry : party->members)
    {
        auto* member = dynamic_cast<CCharEntity*>(entry);
        if (member != nullptr && member->PTreasurePool != nullptr && member->PTreasurePool->GetPoolType() != TREASUREPOOL_ZONE)
        {
            member->PTreasurePool->DelMember(member);
        }
    }

    // Create a a new treasure pool for whoever is in the server from this party (if anyone)
    if (!party->members.empty())
    {
        auto* PChar = dynamic_cast<CCharEntity*>(party->members.at(0));

        if (!PChar)
        {
            ShowWarning("CAlliance::delParty - Party Member at Position 0 is not of type CCharEntity.");
            return;
        }

        PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_PARTY);
        PChar->PTreasurePool->AddMember(PChar);
        PChar->PTreasurePool->UpdatePool(PChar);

        for (auto& member : party->members)
        {
            auto* PMember = dynamic_cast<CCharEntity*>(member);
            if (PMember && (PChar != PMember))
            {
                PMember->PTreasurePool = PChar->PTreasurePool;
                PChar->PTreasurePool->AddMember(PMember);
                PChar->PTreasurePool->UpdatePool(PMember);
            }
        }
    }
}

void CAlliance::addParty(CParty* party)
{
    party->m_PAlliance = this;
    partyList.push_back(party);

    uint8 newparty = 0;

    int ret = sql->Query("SELECT partyflag & %d FROM accounts_parties WHERE allianceid = %d ORDER BY partyflag & %d ASC;", PARTY_SECOND | PARTY_THIRD,
                         m_AllianceID, PARTY_SECOND | PARTY_THIRD);

    if (ret != SQL_ERROR && sql->NumRows() > 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            if (sql->GetUIntData(0) == newparty)
            {
                newparty++;
            }
        }
    }

    for (std::size_t i = 0; i < party->members.size(); ++i)
    {
        CCharEntity* PChar = static_cast<CCharEntity*>(party->members.at(i));
        party->ReloadTreasurePool(PChar);
        charutils::SaveCharStats(PChar);
        PChar->m_charHistory.joinedAlliances++;
    }
    sql->Query("UPDATE accounts_parties SET allianceid = %u, partyflag = partyflag | %d WHERE partyid = %u;", m_AllianceID, newparty,
               party->GetPartyID());
    party->SetPartyNumber(newparty);

    uint8 data[4]{};
    ref<uint32>(data, 0) = m_AllianceID;
    message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
}

void CAlliance::addParty(uint32 partyid) const
{
    int newparty = 0;

    int ret = sql->Query("SELECT partyflag FROM accounts_parties WHERE allianceid = %d ORDER BY partyflag & %d ASC;", m_AllianceID,
                         PARTY_SECOND | PARTY_THIRD);

    if (ret != SQL_ERROR && sql->NumRows() > 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            uint8 partyflag = sql->GetUIntData(0);
            uint8 oldparty  = partyflag & (PARTY_SECOND | PARTY_THIRD);
            if (oldparty == newparty)
            {
                newparty++;
            }
        }
    }
    sql->Query("UPDATE accounts_parties SET allianceid = %u, partyflag = partyflag | %d WHERE partyid = %u;", m_AllianceID, newparty, partyid);
    uint8 data[8]{};
    ref<uint32>(data, 0) = m_AllianceID;
    ref<uint32>(data, 4) = partyid;
    message::send(MSG_PT_RELOAD, data, sizeof data, nullptr);
}

void CAlliance::pushParty(CParty* PParty, uint8 number)
{
    PParty->m_PAlliance = this;
    partyList.push_back(PParty);
    PParty->SetPartyNumber(number);

    for (std::size_t i = 0; i < PParty->members.size(); ++i)
    {
        PParty->ReloadTreasurePool((CCharEntity*)PParty->members.at(i));
        charutils::SaveCharStats((CCharEntity*)PParty->members.at(i));
    }
}

CParty* CAlliance::getMainParty()
{
    return aLeader;
}

// Assigns a party leader for the party
void CAlliance::setMainParty(CParty* aLeader)
{
    this->aLeader = aLeader;
}

void CAlliance::assignAllianceLeader(const char* name)
{
    int ret = sql->Query(
        "SELECT chars.charid from accounts_sessions JOIN chars USING (charid) JOIN accounts_parties USING (charid) "
        "WHERE charname = '%s' AND allianceid = %d AND partyflag & %d;",
        name, m_AllianceID, PARTY_LEADER);

    if (ret != SQL_ERROR && sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
    {
        int charid = sql->GetUIntData(0);

        sql->Query("UPDATE accounts_parties SET partyflag = partyflag & ~%d WHERE allianceid = %u AND partyflag & %d", ALLIANCE_LEADER, m_AllianceID,
                   ALLIANCE_LEADER);
        sql->Query("UPDATE accounts_parties SET allianceid = %u WHERE allianceid = %u;", charid, m_AllianceID);
        m_AllianceID = charid;

        // in case leader's on another server
        this->aLeader = nullptr;

        for (auto* PParty : partyList)
        {
            if (PParty->GetMemberByName(name))
            {
                this->aLeader = PParty;
                break;
            }
        }

        sql->Query("UPDATE accounts_parties SET partyflag = partyflag | %d WHERE charid = %u", ALLIANCE_LEADER, charid);
    }
}
