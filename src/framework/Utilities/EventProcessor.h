/*
 * Copyright (C) 2005-2008 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2008 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2008-2014 Hellground <http://hellground.net/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#ifndef HELLGROUND_EVENTPROCESSOR_H
#define HELLGROUND_EVENTPROCESSOR_H

#include "Platform/Define.h"

#include <map>
#include <typeinfo>
#include <algorithm>
// Note. All times are in milliseconds here.

class HELLGROUND_IMPORT_EXPORT BasicEvent
{
    public:
        BasicEvent() { to_Abort = false; }
        virtual ~BasicEvent()                               // override destructor to perform some actions on event removal
        {
        };

        // this method executes when the event is triggered
        // return false if event does not want to be deleted
        // e_time is execution time, p_time is update interval
        virtual bool Execute(uint64 /*e_time*/, uint32 /*p_time*/) { return true; }

        virtual bool IsDeletable() const { return true; }   // this event can be safely deleted

        virtual void Abort(uint64 /*e_time*/) {}            // this method executes when the event is aborted

        bool to_Abort;                                      // set by externals when the event is aborted, aborted events don't execute
        // and get Abort call when deleted

        // these can be used for time offset control
        uint64 m_execTime;                                  // planned time of next execution, filled by event handler
};

typedef std::multimap<uint64, BasicEvent*> EventList;

class HELLGROUND_IMPORT_EXPORT EventProcessor
{
    public:
        EventProcessor();
        ~EventProcessor();

        uint32 Update(uint32 p_time);
        void KillAllEvents(bool force);
        void AddEvent(BasicEvent* Event, uint64 e_time, bool set_addtime = true);

        bool HasEventOfType(BasicEvent* type)
        {
            return std::any_of(m_events.begin(), m_events.end(), [&type](std::pair<uint64, BasicEvent*> i) { return typeid(*i.second) == typeid(*type); });
        };

    protected:
        uint64 m_time;
        EventList m_events;
        bool m_aborting;
};

#endif
