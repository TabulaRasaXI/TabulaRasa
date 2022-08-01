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

#include "controller.h"

#ifndef _PLAYERCONTROLLER_H
#define _PLAYERCONTROLLER_H

class CCharEntity;
class CWeaponSkill;

class CPlayerController : public CController
{
public:
    CPlayerController(CCharEntity*);
    virtual ~CPlayerController()
    {
    }

    virtual void Tick(time_point) override;

    virtual bool Cast(uint16 targid, SpellID spellid) override;
    virtual bool Engage(uint16 targid) override;
    virtual bool ChangeTarget(uint16 targid) override;
    virtual bool Disengage() override;
    virtual bool WeaponSkill(uint16 targid, uint16 wsid) override;

    virtual bool Ability(uint16 targid, uint16 abilityid) override;
    virtual bool RangedAttack(uint16 targid);
    virtual bool UseItem(uint16 targid, uint8 loc, uint8 slotid);

    time_point getLastAttackTime();
    void       setLastAttackTime(time_point);
    time_point getLastRangedAttackTime();
    void       setLastRangedAttackTime(time_point);

    void       setLastErrMsgTime(time_point);
    time_point getLastErrMsgTime();

    CWeaponSkill* getLastWeaponSkill();

    bool CanUseAbility(uint16 targid, uint16 abilityid);

protected:
    time_point    m_lastAttackTime{ server_clock::now() };
    time_point    m_lastRangedAttackTime{ server_clock::now() };
    time_point    m_errMsgTime{ server_clock::now() };
    CWeaponSkill* m_lastWeaponSkill{ nullptr };
};

#endif // _PLAYERCONTROLLER
