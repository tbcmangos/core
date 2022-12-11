/*
 * Copyright (C) 2005-2010 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2008-2017 Hellground <http://wow-hellground.com/>
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

#ifndef HELLGROUND_SCRIPTMGR_H
#define HELLGROUND_SCRIPTMGR_H

#include "ace/Singleton.h"

#include "Common.h"

struct AreaTriggerEntry;
struct CinematicSequencesEntry;
class Aura;
class Creature;
class CreatureAI;
class GameObject;
class InstanceData;
class Item;
class Map;
class Object;
class Player;
class Quest;
class SpellCastTargets;
class Unit;
class WorldObject;

struct SpellEntry;

struct ScriptInfo
{
    uint32 id;
    uint32 delay;
    uint32 command;
    uint32 datalong;
    uint32 datalong2;
    int32  dataint;
    float x;
    float y;
    float z;
    float o;
};

typedef std::multimap<uint32, ScriptInfo> ScriptMap;
typedef std::map<uint32, ScriptMap > ScriptMapMap;
extern ScriptMapMap sQuestEndScripts;
extern ScriptMapMap sQuestStartScripts;
extern ScriptMapMap sSpellScripts;
extern ScriptMapMap sGameObjectScripts;
extern ScriptMapMap sEventScripts;
extern ScriptMapMap sWaypointScripts;

class ScriptMgr
{
    friend class ACE_Singleton<ScriptMgr, ACE_Null_Mutex>;
    ScriptMgr();

    typedef std::vector<std::string> ScriptNameMap;

    public:
        ~ScriptMgr();

        void LoadGameObjectScripts();
        void LoadQuestEndScripts();
        void LoadQuestStartScripts();
        void LoadEventScripts();
        void LoadEventIdScripts();
        void LoadSpellIdScripts();
        void LoadSpellScripts();
        void LoadWaypointScripts();

        void LoadScriptNames();
        void LoadAreaTriggerScripts();
        void LoadCompletedCinematicScripts();

        uint32 GetAreaTriggerScriptId(uint32 triggerId) const;
        uint32 GetCompletedCinematicScriptId(uint32 cinematicId) const;
        uint32 GetEventIdScriptId(uint32 eventId) const;
        uint32 GetSpellIdScriptId(uint32 eventId) const;

        ScriptNameMap &GetScriptNames() { return m_scriptNames; }
        const char * GetScriptName(uint32 id) { return id < m_scriptNames.size() ? m_scriptNames[id].c_str() : ""; }
        uint32 GetScriptId(const char *name);

        bool LoadScriptLibrary(const char* libName);
        void UnloadScriptLibrary();

        CreatureAI* GetCreatureAI(Creature* pCreature);
        InstanceData* CreateInstanceData(Map* pMap);

        bool OnGossipHello(Player* pPlayer, Creature* pCreature);
        bool OnGossipHello(Player* pPlayer, GameObject* pGameObject);
        bool OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 action, const char* code);
        bool OnGossipSelect(Player* pPlayer, GameObject* pGameObject, uint32 sender, uint32 action, const char* code);
        bool OnQuestAccept(Player* pPlayer, Creature* pCreature, Quest const* pQuest);
        bool OnQuestAccept(Player* pPlayer, GameObject* pGameObject, Quest const* pQuest);
        bool OnQuestAccept(Player* pPlayer, Item* pItem, Quest const* pQuest);
        bool OnQuestRewarded(Player* pPlayer, Creature* pCreature, Quest const* pQuest);
        bool OnQuestRewarded(Player* pPlayer, GameObject* pGameObject, Quest const* pQuest);
        uint32 GetDialogStatus(Player* pPlayer, Creature* pCreature);
        uint32 GetDialogStatus(Player* pPlayer, GameObject* pGameObject);
        bool OnGameObjectUse(Player* pPlayer, GameObject* pGameObject);
        bool OnItemUse(Player* pPlayer, Item* pItem, SpellCastTargets const& targets);
        bool OnAreaTrigger(Player* pPlayer, AreaTriggerEntry const* atEntry);
        bool OnCompletedCinematic(Player* pPlayer, CinematicSequencesEntry const* cinematic);
        bool OnProcessEvent(uint32 eventId, Object* pSource, Object* pTarget, bool isStart);
        bool OnAuraDummy(Aura const* pAura, bool apply);

        bool OnReceiveEmote(Player *pPlayer, Creature *pCreature, uint32 emote);

        // spell scripts
        bool OnSpellSetTargetMap(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const&, SpellEntry const *pSpell, uint32 effectIndex);
        bool OnSpellHandleEffect(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex);

    private:
        void LoadScripts(ScriptMapMap& scripts, const char* tablename);

        template<class T>
        void GetScriptHookPtr(T& ptr, const char* name)
        {
            ptr = (T)HELLGROUND_GET_PROC_ADDR(m_hScriptLib, name);
        }

        typedef UNORDERED_MAP<uint32, uint32> AreaTriggerScriptMap;
        typedef UNORDERED_MAP<uint32, uint32> CompletedCinematicScriptMap;
        typedef UNORDERED_MAP<uint32, uint32> EventIdScriptMap;
        typedef UNORDERED_MAP<uint32, uint32> SpellIdScriptMap;

        AreaTriggerScriptMap            m_AreaTriggerScripts;
        CompletedCinematicScriptMap     m_CompletedCinematicScripts;
        EventIdScriptMap                m_EventIdScripts;
        SpellIdScriptMap                m_SpellIdScripts;

        ScriptNameMap           m_scriptNames;

        HELLGROUND_LIBRARY_HANDLE   m_hScriptLib;

        void (HELLGROUND_IMPORT* m_pOnInitScriptLibrary)(char const*);
        void (HELLGROUND_IMPORT* m_pOnFreeScriptLibrary)();

        CreatureAI* (HELLGROUND_IMPORT* m_pGetCreatureAI) (Creature*);
        InstanceData* (HELLGROUND_IMPORT* m_pCreateInstanceData) (Map*);

        bool (HELLGROUND_IMPORT* m_pOnGossipHello) (Player*, Creature*);
        bool (HELLGROUND_IMPORT* m_pOnGossipSelect) (Player*, Creature*, uint32, uint32);
        bool (HELLGROUND_IMPORT* m_pOnGOGossipSelect) (Player*, GameObject*, uint32, uint32);
        bool (HELLGROUND_IMPORT* m_pOnGossipSelectWithCode) (Player*, Creature*, uint32, uint32, const char*);
        bool (HELLGROUND_IMPORT* m_pOnGOGossipSelectWithCode) (Player*, GameObject*, uint32, uint32, const char*);
        bool (HELLGROUND_IMPORT* m_pOnQuestAccept) (Player*, Creature*, Quest const*);
        bool (HELLGROUND_IMPORT* m_pOnGOQuestAccept) (Player*, GameObject*, Quest const*);
        bool (HELLGROUND_IMPORT* m_pOnItemQuestAccept) (Player*, Item*, Quest const*);
        bool (HELLGROUND_IMPORT* m_pOnQuestRewarded) (Player*, Creature*, Quest const*);
        bool (HELLGROUND_IMPORT* m_pOnGOQuestRewarded) (Player*, GameObject*, Quest const*);
        uint32 (HELLGROUND_IMPORT* m_pGetNPCDialogStatus) (Player*, Creature*);
        uint32 (HELLGROUND_IMPORT* m_pGetGODialogStatus) (Player*, GameObject*);
        bool (HELLGROUND_IMPORT* m_pOnGOUse) (Player*, GameObject*);
        bool (HELLGROUND_IMPORT* m_pOnItemUse) (Player*, Item*, SpellCastTargets const&);
        bool (HELLGROUND_IMPORT* m_pOnAreaTrigger) (Player*, AreaTriggerEntry const*);
        bool (HELLGROUND_IMPORT* m_pOnCompletedCinematic) (Player*, CinematicSequencesEntry const*);
        bool (HELLGROUND_IMPORT* m_pOnProcessEvent) (uint32, Object*, Object*, bool);
        bool (HELLGROUND_IMPORT* m_pOnAuraDummy) (Aura const*, bool);

        bool (HELLGROUND_IMPORT* m_pOnReceiveEmote) (Player *pPlayer, Creature *pCreature, uint32 emote);

        // spell scripts
        bool (HELLGROUND_IMPORT* m_pOnSpellSetTargetMap) (Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const&, SpellEntry const *pSpell, uint32 effectIndex);
        bool (HELLGROUND_IMPORT* m_pOnSpellHandleEffect) (Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex);
};

#define sScriptMgr (*ACE_Singleton<ScriptMgr, ACE_Null_Mutex>::instance())

HELLGROUND_IMPORT_EXPORT uint32 GetAreaTriggerScriptId(uint32 triggerId);
HELLGROUND_IMPORT_EXPORT uint32 GetCompletedCinematicScriptId(uint32 triggerId);
HELLGROUND_IMPORT_EXPORT uint32 GetScriptId(const char *name);
HELLGROUND_IMPORT_EXPORT uint32 GetEventIdScriptId(uint32 eventId);
HELLGROUND_IMPORT_EXPORT uint32 GetSpellIdScriptId(uint32 eventId);

#endif
