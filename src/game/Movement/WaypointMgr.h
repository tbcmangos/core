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

#ifndef HELLGROUND_WAYPOINTMGR_H
#define HELLGROUND_WAYPOINTMGR_H

#include <ace/Singleton.h>

#include <vector>
#include <unordered_map>

enum WaypointMoveType
{
    M_WALK = 0,
    M_RUN  = 1,
    M_FLY  = 2
};

struct WaypointData
{
    uint32 id;
    float x,y,z;
    WaypointMoveType moveType;
    uint32 delay;
    uint32 event_id;
    uint8 event_chance;
};

typedef std::vector<WaypointData*> WaypointPath;
typedef std::unordered_map<uint32, WaypointPath*> WaypointPathMap;

class WaypointMgr
{
    friend class ACE_Singleton<WaypointMgr, ACE_Thread_Mutex>;
    // this is on purpose, constructor has to be private :P
    WaypointMgr() {}

    public:
        void UpdatePath(uint32 id);
        void Load();
        void Free();

        WaypointPath* GetPath(uint32 id)
        {
            if (_waypointPathMap.find(id) != _waypointPathMap.end())
                return _waypointPathMap[id];

            return NULL;
        }

        inline uint32 GetRecordsCount() { return records; }

    private:
        int32 records;
        WaypointPathMap _waypointPathMap;
};

#define sWaypointMgr (*ACE_Singleton<WaypointMgr, ACE_Thread_Mutex>::instance())
#endif
