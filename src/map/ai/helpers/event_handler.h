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

#ifndef _EVENT_HANDLER
#define _EVENT_HANDLER

#include <functional>
#include <unordered_map>
#include <vector>

#include "../../../common/cbasetypes.h"
#include "../../lua/luautils.h"

struct ai_event_t
{
    std::string   identifier;
    sol::function lua_func;

    ai_event_t(std::string const& _ident, sol::function _lua_func)
    : identifier(_ident)
    , lua_func(_lua_func)
    {
    }
};

class CAIEventHandler
{
public:
    void addListener(std::string const& eventname, sol::function lua_func, std::string const& identifier);
    void removeListener(std::string const& identifier);

    // calls event from core
    template <class... Args>
    void triggerListener(std::string const& eventname, Args&&... args)
    {
        TracyZoneScoped;
        TracyZoneString(eventname);
        if (eventListeners.count(eventname))
        {
            for (auto&& event : eventListeners.at(eventname))
            {
                auto result = event.lua_func(std::forward<Args&&>(args)...);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("Error in listener event %s: %s", eventname, err.what());
                }
            }
        }
    }

private:
    std::unordered_map<std::string, std::vector<ai_event_t>> eventListeners;
};

#endif
