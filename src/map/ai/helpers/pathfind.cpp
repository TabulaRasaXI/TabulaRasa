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

#include "pathfind.h"
#include "../../../common/utils.h"
#include "../../entities/baseentity.h"
#include "../../entities/mobentity.h"
#include "../../mob_modifier.h"
#include "../../zone.h"
#include "../ai_container.h"
#include "lua/luautils.h"

namespace
{
    bool arePositionsClose(const position_t& a, const position_t& b)
    {
        return distance(a, b) < 1.0f;
    }
} // namespace

CPathFind::CPathFind(CBaseEntity* PTarget)
: m_POwner(PTarget)
, m_pathFlags(0)
, m_patrolFlags(0)
, m_carefulPathing(false)
{
    m_originalPoint.x        = 0.f;
    m_originalPoint.y        = 0.f;
    m_originalPoint.z        = 0.f;
    m_originalPoint.moving   = 0;
    m_originalPoint.rotation = 0;

    Clear();
}

CPathFind::~CPathFind()
{
    m_POwner = nullptr;
    Clear();
}

bool CPathFind::RoamAround(const position_t& point, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;
    Clear();

    m_roamFlags = roamFlags;

    if (isNavMeshEnabled())
    {
        if (FindRandomPath(point, maxRadius, maxTurns, roamFlags))
        {
            return true;
        }
        else
        {
            Clear();
            return false;
        }
    }
    else
    {
        // no point worm roaming cause it'll move one inch
        if (m_roamFlags & ROAMFLAG_WORM)
        {
            Clear();
            return false;
        }

        m_points.push_back({ { point.x - 1 + rand() % 2, point.y, point.z - 1 + rand() % 2, 0, 0 }, 0 });
    }

    return true;
}

bool CPathFind::PathTo(const position_t& point, uint8 pathFlags, bool clear)
{
    TracyZoneScoped;
    // don't follow a new path if the current path has script flag and new path doesn't
    if (IsFollowingPath() && (m_pathFlags & PATHFLAG_SCRIPT) && !(pathFlags & PATHFLAG_SCRIPT))
    {
        return false;
    }

    if (clear)
    {
        Clear();
    }

    m_pathFlags = pathFlags;

    if (isNavMeshEnabled())
    {
        bool result = false;

        if (m_pathFlags & PATHFLAG_WALLHACK)
        {
            result = FindClosestPath(m_POwner->loc.p, point);
        }
        else
        {
            result = FindPath(m_POwner->loc.p, point);
        }

        if (!result)
        {
            Clear();
        }

        return result;
    }
    else
    {
        if (clear)
        {
            Clear();
        }

        m_points.push_back({ point, 0 });
    }

    return true;
}

bool CPathFind::PathInRange(const position_t& point, float range, uint8 pathFlags /*= 0*/, bool clear /*= true*/)
{
    TracyZoneScoped;
    if (clear)
    {
        Clear();
    }

    m_distanceFromPoint = range;

    bool result = PathTo(point, pathFlags, false);

    if (m_POwner->objtype == TYPE_MOB && !m_POwner->loc.zone->m_updatedNavmesh) // Target is too high.
    {
        auto PMob = static_cast<CMobEntity*>(m_POwner);

        if (point.y - m_POwner->loc.p.y < -6 && !PMob->PAI->IsRoaming()) // Target is over 6 yalms above me, I should process disengage if needed.
        {
            auto disengageMod = PMob->getMobMod(MOBMOD_DISENGAGE_NO_PATH);

            if (PMob->m_pathFindDisengage >= 1)
            {
                result = false;
            }
            else if ((PMob->m_pathFindDisengage >= (disengageMod > 0 ? disengageMod : 2)) ||
                     (PMob->health.hp != PMob->health.maxhp && !PMob->PAI->IsRoaming())) // This is just to stop players from abusing the disengage. Adjustable via mobmod.
            {
                result = false; // Make me go up.
            }
            else if (PMob->PAI->IsEngaged())
            {
                PMob->m_pathFindDisengage += 1;
                PMob->PAI->Disengage();
            }
            else
            {
                result = false;
            }
        }
        else // I'm probably stuck on a rock or something dumb.
        {
            result = false; // Make me go down or up.
        }
    }

    if (m_POwner->objtype == TYPE_MOB &&
        m_POwner->loc.zone->m_updatedNavmesh)
    {
        auto PEntity = dynamic_cast<CBattleEntity*>(m_POwner)->GetBattleTarget();

        if (PEntity && !m_POwner->m_ignoreWallhack)
        {
            result           = abs(m_POwner->loc.p.y - PEntity->loc.p.y) < m_POwner->loc.zone->m_navMesh->GetVerticalLimit() ? ValidPosition(PEntity->loc.p) : true;
            m_carefulPathing = result ? true : false;
        }
    }

    if (!result && !m_POwner->m_ignoreWallhack) // If I failed to path successfully, then I should wallhack to reach my destination.
    {
        pathFlags |= PATHFLAG_WALLHACK;
        PathTo(point, pathFlags, false);
    }

    return result;
}

bool CPathFind::PathAround(const position_t& point, float distanceFromPoint, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();

    // save for sliding logic
    m_originalPoint     = point;
    m_distanceFromPoint = distanceFromPoint;

    // Don't clear path so
    // original point / distance are kept
    return PathTo(point, pathFlags, false);
}

bool CPathFind::PathThrough(std::vector<pathpoint_t>&& points, uint8 pathFlags)
{
    TracyZoneScoped;
    Clear();

    m_pathFlags = pathFlags;

    AddPoints(std::move(points), m_pathFlags & PATHFLAG_REVERSE);

    return true;
}

bool CPathFind::WarpTo(const position_t& point, float maxDistance)
{
    TracyZoneScoped;
    Clear();

    position_t newPoint = nearPosition(point, maxDistance, (float)M_PI);

    m_POwner->loc.p.x      = newPoint.x;
    m_POwner->loc.p.y      = newPoint.y;
    m_POwner->loc.p.z      = newPoint.z;
    m_POwner->loc.p.moving = 0;

    LookAt(point);
    m_POwner->updatemask |= UPDATE_POS;

    return true;
}

void CPathFind::ResumePatrol()
{
    if (m_patrolFlags & PATHFLAG_PATROL)
    {
        m_pathFlags        = m_patrolFlags;
        m_points           = m_patrol;
        m_currentPoint     = 0;
        float closestPoint = FLT_MAX;
        for (size_t i = 0; i < m_points.size(); ++i)
        {
            float distance = distanceSquared(m_POwner->loc.p, m_points[i].position);
            if (distance < closestPoint)
            {
                m_currentPoint = (int16)i;
                closestPoint   = distance;
            }
        }
    }
}

bool CPathFind::isNavMeshEnabled()
{
    return m_POwner->loc.zone && m_POwner->loc.zone->m_navMesh != nullptr;
}

bool CPathFind::ValidPosition(const position_t& pos)
{
    TracyZoneScoped;
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->validPosition(pos);
    }
    else
    {
        return true;
    }
}

void CPathFind::LimitDistance(float maxLength)
{
    m_maxDistance = maxLength;
}

void CPathFind::PrunePathWithin(float within)
{
    TracyZoneScoped;

    if (!IsFollowingPath())
    {
        return;
    }

    position_t targetPoint = m_points.back().position;

    while (m_points.size() > 1)
    {
        position_t secondLastPoint = m_points[m_points.size() - 2].position;

        if (distance(targetPoint, secondLastPoint) > within)
        {
            break;
        }
        m_points.erase(m_points.end() - 2);
    }
}

void CPathFind::FollowPath(time_point tick)
{
    TracyZoneScoped;
    if (!IsFollowingPath())
    {
        return;
    }

    if (m_timeAtPoint.time_since_epoch().count() != 0)
    {
        // Continue to wait until full wait time has elapsed
        if (tick >= m_timeAtPoint)
        {
            m_timeAtPoint = {};
            ++m_currentPoint;
            luautils::OnPathPoint(m_POwner);
            if (m_currentPoint >= (int16)m_points.size())
            {
                luautils::OnPathComplete(m_POwner);
                FinishedPath();
            }
        }
        return;
    }

    m_onPoint = false;

    pathpoint_t targetPoint = m_points[m_currentPoint];

    if ((isNavMeshEnabled() && m_carefulPathing) || (isNavMeshEnabled() && m_POwner->loc.zone->m_zoneCarefulPathing))
    {
        m_POwner->loc.zone->m_navMesh->snapToValidPosition(m_POwner->loc.p, targetPoint.position.y, false);
    }

    if (m_maxDistance && m_distanceMoved >= m_maxDistance)
    {
        // if I have a max distance, check to stop me
        Clear();
        m_onPoint = true;
        return;
    }

    // Iterate over points in the current path and find the first point
    // that we haven't successfully arrived at already.
    while (m_currentPoint < (int16)m_points.size())
    {
        targetPoint = m_points[m_currentPoint];

        if (AtPoint(targetPoint.position))
        {
            m_onPoint = true;
            if (targetPoint.setRotation)
            {
                m_POwner->loc.p.rotation = targetPoint.position.rotation;
                m_POwner->updatemask |= UPDATE_POS;
            }
            if (targetPoint.wait != 0 && m_timeAtPoint.time_since_epoch().count() == 0)
            {
                m_timeAtPoint = tick + std::chrono::milliseconds(targetPoint.wait);
                return;
            }

            luautils::OnPathPoint(m_POwner);
            m_currentPoint++;
        }
        else
        {
            break;
        }
    }

    StepTo(targetPoint.position, m_pathFlags & PATHFLAG_RUN);

    if (m_currentPoint >= (int16)m_points.size())
    {
        luautils::OnPathComplete(m_POwner);
        FinishedPath();
        m_onPoint = true;
    }
}

void CPathFind::StepTo(const position_t& pos, bool run)
{
    TracyZoneScoped;
    float speed = GetRealSpeed();

    int8 mode = 2;

    if (!run)
    {
        mode = 1;
        speed /= 2;
    }

    float stepDistance = (speed / 10) / 2;
    float distanceTo   = distance(m_POwner->loc.p, pos);

    // face point mob is moving towards
    LookAt(pos);

    if (distanceTo <= m_distanceFromPoint + stepDistance)
    {
        m_distanceMoved += distanceTo - m_distanceFromPoint;

        if (m_distanceFromPoint == 0)
        {
            m_POwner->loc.p.x = pos.x;
            m_POwner->loc.p.y = pos.y;
            m_POwner->loc.p.z = pos.z;
        }
        else
        {
            float radians = (1 - (float)m_POwner->loc.p.rotation / 256) * 2 * (float)M_PI;

            m_POwner->loc.p.x += cosf(radians) * (distanceTo - m_distanceFromPoint);
            m_POwner->loc.p.y = pos.y;
            m_POwner->loc.p.z += sinf(radians) * (distanceTo - m_distanceFromPoint);
        }
    }
    else
    {
        m_distanceMoved += stepDistance;
        // take a step towards target point
        float radians = (1 - (float)m_POwner->loc.p.rotation / 256) * 2 * (float)M_PI;

        m_POwner->loc.p.x += cosf(radians) * stepDistance;
        m_POwner->loc.p.y = pos.y;
        m_POwner->loc.p.z += sinf(radians) * stepDistance;
    }

    m_POwner->loc.p.moving += (uint16)((0x36 * ((float)m_POwner->speed / 0x28)) - (0x14 * (mode - 1)));

    if (m_POwner->loc.p.moving > 0x2fff)
    {
        m_POwner->loc.p.moving = 0;
    }

    m_POwner->updatemask |= UPDATE_POS;
}

bool CPathFind::FindPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (arePositionsClose(start, end))
    {
        return false;
    }

    if (!isNavMeshEnabled())
    {
        return false;
    }

    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;

    if (m_points.empty())
    {
        DebugNavmesh("CPathFind::FindPath Entity (%s - %d) could not find path", m_POwner->GetName(), m_POwner->id);
        return false;
    }

    return true;
}

bool CPathFind::FindRandomPath(const position_t& start, float maxRadius, uint8 maxTurns, uint16 roamFlags)
{
    TracyZoneScoped;

    if (!isNavMeshEnabled())
    {
        return false;
    }

    auto m_turnLength = xirand::GetRandomNumber((int)maxTurns) + 1;

    position_t startPosition = start;

    // find end points for turns
    for (int i = 0; i < m_turnLength; i++)
    {
        // look for new point centered around the last point
        auto status = m_POwner->loc.zone->m_navMesh->findRandomPosition(startPosition, maxRadius);

        // couldn't find one point so just break out
        if (status.first != 0)
        {
            return false;
        }

        m_turnPoints.push_back(status.second);
        startPosition = m_turnPoints[i];
    }
    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, m_turnPoints[0]);
    m_currentPoint = 0;

    return !m_points.empty();
}

bool CPathFind::FindClosestPath(const position_t& start, const position_t& end)
{
    TracyZoneScoped;

    if (arePositionsClose(start, end))
    {
        return false;
    }

    if (!isNavMeshEnabled())
    {
        return false;
    }

    m_points       = m_POwner->loc.zone->m_navMesh->findPath(start, end);
    m_currentPoint = 0;
    m_points.push_back({ end, 0 }); // this prevents exploits with navmesh / impassible terrain

    /* this check requirement is never met as intended since m_points are never empty when mob has a path
    if (m_points.empty())
    {
        // this is a trick to make mobs go up / down impassible terrain
        m_points.push_back(end);
    }
*/

    return true;
}

void CPathFind::LookAt(const position_t& point)
{
    // Avoid unpredictable results if we're too close.
    if (!distanceWithin(m_POwner->loc.p, point, 0.1f, true))
    {
        m_POwner->loc.p.rotation = worldAngle(m_POwner->loc.p, point);
        m_POwner->updatemask |= UPDATE_POS;
    }
}

bool CPathFind::OnPoint() const
{
    return m_onPoint;
}

float CPathFind::GetRealSpeed()
{
    uint8 realSpeed = m_POwner->speed;

    // 'GetSpeed()' factors in movement bonuses such as map confs and modifiers.
    if (m_POwner->objtype != TYPE_NPC)
    {
        realSpeed = ((CBattleEntity*)m_POwner)->GetSpeed();
    }

    // Lets not check mob things on non mobs
    if (m_POwner->objtype == TYPE_MOB)
    {
        if (realSpeed == 0 && (m_roamFlags & ROAMFLAG_WORM))
        {
            realSpeed = 20;
        }
        else if (m_POwner->animation == ANIMATION_ATTACK)
        {
            realSpeed = realSpeed + settings::get<int8>("map.MOB_SPEED_MOD");
        }
    }

    return realSpeed;
}

bool CPathFind::IsFollowingPath()
{
    return !m_points.empty();
}

bool CPathFind::IsFollowingScriptedPath()
{
    return IsFollowingPath() && m_pathFlags & PATHFLAG_SCRIPT;
}

bool CPathFind::IsPatrolling()
{
    return m_patrolFlags & PATHFLAG_PATROL;
}

bool CPathFind::AtPoint(const position_t& pos)
{
    if (m_distanceFromPoint == 0)
    {
        return distanceWithin(m_POwner->loc.p, pos, 0.1f);
    }
    else
    {
        return distanceWithin(m_POwner->loc.p, pos, m_distanceFromPoint + 0.2f);
    }
}

bool CPathFind::InWater()
{
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->inWater(m_POwner->loc.p);
    }

    return false;
}

bool CPathFind::CanSeePoint(const position_t& point, bool lookOffMesh)
{
    if (isNavMeshEnabled())
    {
        return m_POwner->loc.zone->m_navMesh->raycast(m_POwner->loc.p, point, lookOffMesh);
    }

    return true;
}

const position_t& CPathFind::GetDestination() const
{
    return m_points.back().position;
}

void CPathFind::SetCarefulPathing(bool careful)
{
    m_carefulPathing = careful;
}

void CPathFind::Clear()
{
    m_distanceFromPoint = 0;
    m_pathFlags         = 0;
    m_roamFlags         = 0;
    m_points.clear();
    m_timeAtPoint = {};

    m_currentPoint  = 0;
    m_maxDistance   = 0;
    m_distanceMoved = 0;

    m_onPoint = true;

    m_currentTurn = 0;
    m_turnPoints.clear();
}

void CPathFind::AddPoints(std::vector<pathpoint_t>&& points, bool reverse)
{
    if (points.size() > MAX_PATH_POINTS && (m_pathFlags & PATHFLAG_PATROL) == 0)
    {
        ShowWarning("CPathFind::AddPoints Given too many points (%d). Limiting to max (%d)", points.size(), MAX_PATH_POINTS);
        points.resize(MAX_PATH_POINTS);
    }

    m_points = std::move(points);

    if (reverse)
    {
        std::reverse(m_points.begin(), m_points.end());
    }

    if (m_pathFlags & PATHFLAG_PATROL)
    {
        m_patrol      = m_points;
        m_patrolFlags = m_pathFlags;
    }
    else
    {
        m_patrol.clear();
        m_patrolFlags = 0;
    }
}

void CPathFind::FinishedPath()
{
    m_currentTurn++;

    // turning is only available to navmeshed maps
    if (m_currentTurn < m_turnPoints.size() && isNavMeshEnabled())
    {
        // move on to next turn
        position_t& nextTurn = m_turnPoints[m_currentTurn];

        bool result = FindPath(m_POwner->loc.p, nextTurn);

        if (!result)
        {
            Clear();
        }
    }
    else if (IsPatrolling() && m_POwner->PAI->IsRoaming())
    {
        m_currentPoint = 0;
        m_currentTurn  = 0;
    }
    else
    {
        Clear();
    }
}
