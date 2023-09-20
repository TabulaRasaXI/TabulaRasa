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
#include <cstring>

#include "common/logging.h"
#include "common/mmo.h"
#include "common/settings.h"
#include "common/sql.h"

#include <algorithm>

#include "data_loader.h"
#include "search.h"

CDataLoader::CDataLoader()
: sql(std::make_unique<SqlConnection>())
{
}

CDataLoader::~CDataLoader()
{
}

/************************************************************************
 *                                                                       *
 *  Returns the auction house sale history for a given item.             *
 *                                                                       *
 ************************************************************************/

std::vector<ahHistory*> CDataLoader::GetAHItemHystory(uint16 ItemID, bool stack)
{
    std::vector<ahHistory*> HistoryList;

    const char* fmtQuery = "SELECT sale, sell_date, seller_name, buyer_name "
                           "FROM auction_house "
                           "WHERE itemid = %u AND stack = %u AND buyer_name IS NOT NULL "
                           "ORDER BY sell_date DESC "
                           "LIMIT 10";

    int32 ret = sql->Query(fmtQuery, ItemID, stack);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            ahHistory* PAHHistory = new ahHistory;

            PAHHistory->Price = sql->GetUIntData(0);
            PAHHistory->Data  = sql->GetUIntData(1);

            PAHHistory->Name1 = sql->GetStringData(2);
            PAHHistory->Name2 = sql->GetStringData(3);

            HistoryList.push_back(PAHHistory);
        }
        std::reverse(HistoryList.begin(), HistoryList.end());
    }
    return HistoryList;
}

/************************************************************************
 *                                                                       *
 *  The list of items sold in this category                              *
 *                                                                       *
 ************************************************************************/

std::vector<ahItem*> CDataLoader::GetAHItemsToCategory(uint8 AHCategoryID, int8* OrderByString)
{
    ShowDebug("try find category %u", AHCategoryID);

    std::vector<ahItem*> ItemList;

    const char* fmtQuery = "SELECT item_basic.itemid, item_basic.stackSize, COUNT(*)-SUM(stack), SUM(stack) "
                           "FROM item_basic "
                           "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                           "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                           "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                           "WHERE aH = %u AND auction_house.itemid IS NOT NULL "
                           "GROUP BY item_basic.itemid "
                           "%s";

    int32 ret = sql->Query(fmtQuery, AHCategoryID, OrderByString);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            ahItem* PAHItem = new ahItem;

            PAHItem->ItemID = sql->GetIntData(0);

            PAHItem->SingleAmount = sql->GetIntData(2);
            PAHItem->StackAmount  = sql->GetIntData(3);
            PAHItem->Category     = AHCategoryID;

            if (sql->GetIntData(1) == 1)
            {
                PAHItem->StackAmount = -1;
            }

            ItemList.push_back(PAHItem);
        }
    }

    const char* noQtyQuery = "SELECT item_basic.itemid, item_basic.stackSize "
                             "FROM item_basic "
                             "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid "
                             "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                             "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                             "WHERE aH = %u AND auction_house.itemid IS NOT NULL "
                             "GROUP BY item_basic.itemid "
                             "%s";

    int32 noQtyRet = sql->Query(noQtyQuery, AHCategoryID, OrderByString);

    if (noQtyRet != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            uint16 CurrItemID = sql->GetUIntData(0);
            bool   itemFound  = false;

            for (ahItem* PAHItem : ItemList)
            {
                if (PAHItem->ItemID == CurrItemID)
                {
                    itemFound = true;
                    break;
                }
            }

            if (!itemFound)
            {
                ahItem* PAHItem       = new ahItem;
                PAHItem->ItemID       = CurrItemID;
                PAHItem->SingleAmount = 0;
                PAHItem->StackAmount  = 0;

                if (sql->GetIntData(1) == 1)
                {
                    PAHItem->StackAmount = -1;
                }

                ItemList.push_back(PAHItem);
            }
        }
    }

    return ItemList;
}

// Return single item including category and how many are listed
ahItem CDataLoader::GetAHItemFromItemID(uint16 ItemID)
{
    const char* fmtQuery = "SELECT aH, COUNT(*)-SUM(stack), SUM(stack) "
                           "FROM item_basic "
                           "LEFT JOIN auction_house ON item_basic.itemId = auction_house.itemid AND auction_house.buyer_name IS NULL "
                           "LEFT JOIN item_equipment ON item_basic.itemid = item_equipment.itemid "
                           "LEFT JOIN item_weapon ON item_basic.itemid = item_weapon.itemid "
                           "WHERE item_basic.itemid = %u";

    int32 ret = sql->Query(fmtQuery, ItemID);

    ahItem CAHItem       = {};
    CAHItem.ItemID       = ItemID;
    CAHItem.Category     = 0;
    CAHItem.SingleAmount = 0;
    CAHItem.StackAmount  = 0;

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            CAHItem.Category     = sql->GetIntData(0);
            CAHItem.SingleAmount = sql->GetIntData(1);
            CAHItem.StackAmount  = sql->GetIntData(2);

            if (sql->GetIntData(1) == 1)
            {
                CAHItem.StackAmount = 0;
            }
        }
    }
    return CAHItem;
}

/************************************************************************
 *                                                                       *
 *  Returns the number of active players in the world.                   *
 *                                                                       *
 ************************************************************************/

uint32 CDataLoader::GetPlayersCount(const search_req& sr)
{
    uint8 jobid = sr.jobid;
    if (jobid > 0 && jobid < 21)
    {
        if (sql->Query("SELECT COUNT(*) FROM accounts_sessions LEFT JOIN char_stats USING (charid) WHERE mjob = %u", jobid) != SQL_ERROR &&
            sql->NumRows() != 0)
        {
            if (sql->NextRow() == SQL_SUCCESS)
            {
                return sql->GetUIntData(0);
            }
        }
    }
    else
    {
        if (sql->Query("SELECT COUNT(*) FROM accounts_sessions") != SQL_ERROR && sql->NumRows() != 0)
        {
            if (sql->NextRow() == SQL_SUCCESS)
            {
                return sql->GetUIntData(0);
            }
        }
    }
    return 0;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters found in the world that match the     *
 *  search request.                                                      *
 *          Job ID is 0 for none specified.                              *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPlayersList(search_req sr, int* count)
{
    std::list<SearchEntity*> PlayersList;
    std::string              filterQry;
    if (sr.jobid > 0 && sr.jobid < 21)
    {
        filterQry.append(" AND ");
        filterQry.append(" mjob = ");
        filterQry.append(std::to_string(static_cast<unsigned long long>(sr.jobid)));
    }
    if (sr.zoneid[0] > 0)
    {
        std::string zoneList;
        int         i = 1;
        zoneList.append(std::to_string(static_cast<unsigned long long>(sr.zoneid[0])));
        while (i < 10 && sr.zoneid[i] != 0)
        {
            zoneList.append(", ");
            zoneList.append(std::to_string(static_cast<unsigned long long>(sr.zoneid[i])));
            i++;
        }
        filterQry.append(" AND ");
        filterQry.append("(pos_zone IN (");
        filterQry.append(zoneList);
        filterQry.append(") OR (pos_zone = 0 AND pos_prevzone IN (");
        filterQry.append(zoneList);
        filterQry.append("))) ");
    }

    if (sr.commentType != 0)
    {
        filterQry.append(fmt::sprintf(" AND (seacom_type & 0xF0) = %u", sr.commentType, sr.commentType));
    }

    std::string fmtQuery =
        "SELECT charid, partyid, charname, pos_zone, pos_prevzone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, mlvl, slvl, languages, nnameflags, seacom_type, linkshellid1, linkshellid2 "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING (charid) "
        "LEFT JOIN chars USING (charid) "
        "LEFT JOIN char_look USING (charid) "
        "LEFT JOIN char_stats USING (charid) "
        "LEFT JOIN char_profile USING(charid) "
        "WHERE charname IS NOT NULL ";
    fmtQuery.append(filterQry);
    fmtQuery.append(" ORDER BY charname ASC");

    int32 ret = sql->Query(fmtQuery.c_str());

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        int totalResults   = 0; // gives ALL matching criteria (total)
        int visibleResults = 0; // capped at first 20
        while (sql->NextRow() == SQL_SUCCESS)
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name = sql->GetStringData(2);

            PPlayer->id       = sql->GetUIntData(0);
            PPlayer->zone     = (uint16)sql->GetIntData(3);
            PPlayer->prevzone = (uint16)sql->GetIntData(4);
            PPlayer->nation   = (uint8)sql->GetIntData(5);
            PPlayer->mjob     = (uint8)sql->GetIntData(11);
            PPlayer->sjob     = (uint8)sql->GetIntData(12);
            PPlayer->mlvl     = (uint8)sql->GetIntData(13);
            PPlayer->slvl     = (uint8)sql->GetIntData(14);
            PPlayer->race     = (uint8)sql->GetIntData(9);
            PPlayer->rank     = (uint8)sql->GetIntData(6 + PPlayer->nation);

            PPlayer->zone         = (PPlayer->zone == 0 ? PPlayer->prevzone : PPlayer->zone);
            PPlayer->languages    = (uint8)sql->GetUIntData(15);
            PPlayer->mentor       = sql->GetUIntData(16) & NFLAG_MENTOR;
            PPlayer->seacom_type  = (uint8)sql->GetUIntData(17);
            PPlayer->linkshellid1 = (uint16)sql->GetUIntData(18);
            PPlayer->linkshellid2 = (uint16)sql->GetUIntData(19);

            uint32 partyid  = sql->GetUIntData(1);
            uint32 nameflag = sql->GetUIntData(10);

            if (PPlayer->mentor)
            {
                PPlayer->flags1 |= 0x0001;
            }
            if (partyid == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (PPlayer->seacom_type)
            {
                PPlayer->flags1 |= 0x0010;
            }
            if (nameflag & FLAG_AWAY)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (nameflag & FLAG_DC)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (partyid != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (nameflag & FLAG_ANON)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (nameflag & FLAG_INVITE)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            // dont show anon in results if seraching by job, nation,  race, rank, lvl
            if ((nameflag & FLAG_ANON) && (sr.jobid > 0 || sr.nation != 255 || sr.race != 255 || sr.minRank > 0 || sr.maxRank > 0 || sr.minlvl > 0 || sr.maxlvl > 0))
            {
                continue;
            }

            // filter by job
            if (sr.jobid > 0 && sr.jobid != PPlayer->mjob)
            {
                continue;
            }

            // filter by nation
            if (sr.nation != 255 && sr.nation != PPlayer->nation)
            {
                continue;
            }

            // filter by race
            if (sr.race != 255)
            {
                // hume (male/female)
                if (sr.race == 0 && (PPlayer->race != 1 && PPlayer->race != 2))
                {
                    continue;
                    // elvaan (male/female)
                }
                if (sr.race == 1 && (PPlayer->race != 3 && PPlayer->race != 4))
                {
                    continue;
                    // tarutaru (male/female)
                }
                if (sr.race == 2 && (PPlayer->race != 5 && PPlayer->race != 6))
                {
                    continue;
                    // mithra (female only)
                }
                else if (sr.race == 3 && PPlayer->race != 7)
                {
                    continue;
                    // galka (male only)
                }
                else if (sr.race == 4 && PPlayer->race != 8)
                {
                    continue;
                }
            }

            // filter by rank
            if (sr.minRank > 0 && sr.maxRank >= sr.minRank)
            {
                if (PPlayer->rank < sr.minRank || PPlayer->rank > sr.maxRank)
                {
                    continue;
                }
            }

            // filter by flag (away, seek party etc.)
            if (sr.flags != 0 && !(PPlayer->flags2 & sr.flags))
            {
                continue;
            }

            // filter by level
            if (sr.minlvl > 0 && sr.maxlvl >= sr.minlvl)
            {
                if (PPlayer->mlvl < sr.minlvl || PPlayer->mlvl > sr.maxlvl)
                {
                    continue;
                }
            }

            // filter by name
            if (sr.nameLen > 0)
            {
                std::string dbname;
                dbname.insert(0, PPlayer->name);

                // can't be this name, too long
                if (sr.nameLen > dbname.length())
                {
                    continue;
                }
                bool validName = true;
                for (int i = 0; i < sr.nameLen; i++)
                {
                    // convert to lowercase for both
                    if (tolower(sr.name[i]) != tolower(PPlayer->name[i]))
                    {
                        validName = false;
                        break;
                    }
                }
                if (!validName)
                {
                    continue;
                }
            }

            // filter by linkshell
            if (sr.lsFilter)
            {
                // 0(none equipped) or id doesn't match either linkshell = skip/continue
                if (sr.lsId == 0 || (sr.lsId != PPlayer->linkshellid1 && sr.lsId != PPlayer->linkshellid2))
                {
                    continue;
                }
            }

            // dont show hidden gm
            if (nameflag & FLAG_ANON && nameflag & FLAG_GM)
            {
                continue;
            }
            if (visibleResults < 40)
            {
                PlayersList.push_back(PPlayer);
                visibleResults++;
            }
            totalResults++;
        }
        if (totalResults > 0)
        {
            *count = totalResults;
        }
        ShowInfo("Found %i results, displaying %i. ", totalResults, visibleResults);
    }

    return PlayersList;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters in a given party/alliance group.      *
 *                                                                       *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetPartyList(uint32 PartyID, uint32 AllianceID)
{
    std::list<SearchEntity*> PartyList;

    const char* Query =
        "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, mlvl, slvl, languages, nnameflags, seacom_type "
        "FROM accounts_sessions "
        "LEFT JOIN accounts_parties USING(charid) "
        "LEFT JOIN chars USING(charid) "
        "LEFT JOIN char_look USING(charid) "
        "LEFT JOIN char_stats USING(charid) "
        "LEFT JOIN char_profile USING(charid) "
        "WHERE IF (allianceid <> 0, allianceid IN (SELECT allianceid FROM accounts_parties WHERE charid = %u) , partyid = %u) "
        "ORDER BY charname ASC "
        "LIMIT 64";

    int32 ret = sql->Query(Query, (!AllianceID ? PartyID : AllianceID), (!PartyID ? AllianceID : PartyID));

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name        = sql->GetStringData(2);
            PPlayer->id          = sql->GetUIntData(0);
            PPlayer->zone        = (uint16)sql->GetIntData(3);
            PPlayer->nation      = (uint8)sql->GetIntData(4);
            PPlayer->mjob        = (uint8)sql->GetIntData(10);
            PPlayer->sjob        = (uint8)sql->GetIntData(11);
            PPlayer->mlvl        = (uint8)sql->GetIntData(12);
            PPlayer->slvl        = (uint8)sql->GetIntData(13);
            PPlayer->race        = (uint8)sql->GetIntData(8);
            PPlayer->rank        = (uint8)sql->GetIntData(5 + PPlayer->nation);
            PPlayer->languages   = (uint8)sql->GetUIntData(14);
            PPlayer->mentor      = sql->GetUIntData(15) & NFLAG_MENTOR;
            PPlayer->seacom_type = (uint8)sql->GetUIntData(16);

            uint32 nameflag = sql->GetUIntData(9);

            if (PPlayer->mentor)
            {
                PPlayer->flags1 |= 0x0001;
            }
            if (PartyID == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (PPlayer->seacom_type)
            {
                PPlayer->flags1 |= 0x0010;
            }
            if (nameflag & FLAG_AWAY)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (nameflag & FLAG_DC)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (PartyID != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (nameflag & FLAG_ANON)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (nameflag & FLAG_INVITE)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            PartyList.push_back(PPlayer);
        }
    }
    return PartyList;
}

/************************************************************************
 *                                                                       *
 *  Returns the list of characters in a given linkshell.                 *
 *                                                                       *
 ************************************************************************/

std::list<SearchEntity*> CDataLoader::GetLinkshellList(uint32 LinkshellID)
{
    std::list<SearchEntity*> LinkshellList;
    const char*              fmtQuery = "SELECT charid, partyid, charname, pos_zone, nation, rank_sandoria, rank_bastok, rank_windurst, race, nameflags, mjob, sjob, "
                                        "mlvl, slvl, linkshellid1, linkshellid2, "
                                        "linkshellrank1, linkshellrank2 "
                                        "FROM accounts_sessions "
                                        "LEFT JOIN accounts_parties USING (charid) "
                                        "LEFT JOIN chars USING (charid) "
                                        "LEFT JOIN char_look USING (charid) "
                                        "LEFT JOIN char_stats USING (charid) "
                                        "LEFT JOIN char_profile USING(charid) "
                                        "WHERE linkshellid1 = %u OR linkshellid2 = %u "
                                        "ORDER BY charname ASC "
                                        "LIMIT 18";

    int32 ret = sql->Query(fmtQuery, LinkshellID, LinkshellID);

    if (ret != SQL_ERROR && sql->NumRows() != 0)
    {
        while (sql->NextRow() == SQL_SUCCESS)
        {
            SearchEntity* PPlayer = new SearchEntity();

            PPlayer->name           = sql->GetStringData(2);
            PPlayer->id             = sql->GetUIntData(0);
            PPlayer->zone           = (uint16)sql->GetIntData(3);
            PPlayer->nation         = (uint8)sql->GetIntData(4);
            PPlayer->mjob           = (uint8)sql->GetIntData(10);
            PPlayer->sjob           = (uint8)sql->GetIntData(11);
            PPlayer->mlvl           = (uint8)sql->GetIntData(12);
            PPlayer->slvl           = (uint8)sql->GetIntData(13);
            PPlayer->race           = (uint8)sql->GetIntData(8);
            PPlayer->rank           = (uint8)sql->GetIntData(5 + PPlayer->nation);
            PPlayer->linkshellid1   = sql->GetIntData(14);
            PPlayer->linkshellid2   = sql->GetIntData(15);
            PPlayer->linkshellrank1 = sql->GetIntData(16);
            PPlayer->linkshellrank2 = sql->GetIntData(17);

            uint32 partyid  = sql->GetUIntData(1);
            uint32 nameflag = sql->GetUIntData(9);

            if (partyid == PPlayer->id)
            {
                PPlayer->flags1 |= 0x0008;
            }
            if (nameflag & FLAG_AWAY)
            {
                PPlayer->flags1 |= 0x0100;
            }
            if (nameflag & FLAG_DC)
            {
                PPlayer->flags1 |= 0x0800;
            }
            if (partyid != 0)
            {
                PPlayer->flags1 |= 0x2000;
            }
            if (nameflag & FLAG_ANON)
            {
                PPlayer->flags1 |= 0x4000;
            }
            if (nameflag & FLAG_INVITE)
            {
                PPlayer->flags1 |= 0x8000;
            }

            PPlayer->flags2 = PPlayer->flags1;

            LinkshellList.push_back(PPlayer);
        }
    }

    return LinkshellList;
}

std::string CDataLoader::GetSearchComment(uint32 playerId)
{
    std::string query = "SELECT seacom_message FROM accounts_sessions WHERE charid = %u";

    int32 ret = sql->Query(query.c_str(), playerId);
    if (ret != SQL_SUCCESS || sql->NumRows() == 0 || sql->NextRow() != SQL_SUCCESS)
    {
        return std::string();
    }

    return sql->GetStringData(0);
}

struct ListingToExpire
{
    uint32      saleID     = 0;
    uint32      itemID     = 0;
    uint8       itemStack  = 0;
    uint8       ahStack    = 0;
    uint32      sellerID   = 0;
    std::string sellerName = "?";
};

void CDataLoader::ExpireAHItems(uint16 expireAgeInDays)
{
    ShowInfo(fmt::format("Expiring auction house listings over {} days old", expireAgeInDays).c_str());

    auto sql2 = std::make_unique<SqlConnection>();

    std::vector<ListingToExpire> listingsToExpire;

    std::string qStr = "SELECT T0.id,T0.itemid,T1.stacksize, T0.stack, T0.seller FROM auction_house T0 INNER JOIN item_basic T1 ON \
                            T0.itemid = T1.itemid WHERE datediff(now(),from_unixtime(date)) >= %u AND buyer_name IS NULL;";

    int32 ret             = sql2->Query(qStr.c_str(), expireAgeInDays);
    int64 expiredAuctions = sql2->NumRows();

    if (ret != SQL_ERROR && expiredAuctions > 0)
    {
        while (sql2->NextRow() == SQL_SUCCESS)
        {
            // Collect the items we're going to expire
            uint32 saleID    = sql2->GetUIntData(0);
            uint32 itemID    = sql2->GetUIntData(1);
            uint8  itemStack = (uint8)sql2->GetUIntData(2);
            uint8  ahStack   = (uint8)sql2->GetUIntData(3);
            uint32 sellerID  = sql2->GetUIntData(4);
            // NOTE: seller name left out for now, we'll populate this later

            listingsToExpire.emplace_back(ListingToExpire{ saleID, itemID, itemStack, ahStack, sellerID, "?" });
        }

        for (auto listing : listingsToExpire)
        {
            // Populate name now
            qStr = fmt::format("SELECT charname FROM chars WHERE charid={}", listing.sellerID);
            ret  = sql2->Query(qStr.c_str());
            if (ret != SQL_ERROR && sql2->NumRows() != 0 && sql2->NextRow() == SQL_SUCCESS)
            {
                listing.sellerName = sql2->GetStringData(0);
            }

            qStr = fmt::format("INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, senderid, sender) VALUES "
                               "({}, '{}', 1, {}, 0, {}, 0, 'AH-Jeuno');",
                               listing.sellerID, listing.sellerName, listing.itemID, listing.ahStack == 1 ? listing.itemStack : 1);

            ret = sql2->Query(qStr.c_str());

            if (ret != SQL_ERROR && sql2->AffectedRows() > 0)
            {
                // delete the item from the auction house
                sql2->Query("DELETE FROM auction_house WHERE id=%u", listing.saleID);
            }
        }
    }
    ShowInfo("Sent %u expired auction house listings back to sellers", expiredAuctions);
}
