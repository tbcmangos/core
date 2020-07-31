/*
 * Copyright (C) 2005-2010 MaNGOS <http://getmangos.com/>
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

#ifndef HELLGROUND_SCRIPTMGR_H
#define HELLGROUND_SCRIPTMGR_H

#include "ace/Singleton.h"

#include "Common.h"

//src/scripts/scriptmgr.h
#include "Platform/CompilerDefs.h"
#include "DBCStructure.h"

class Player;
class Creature;
class CreatureAI;
class InstanceData;
class Quest;
class Object;
class Item;
class GameObject;
class Aura;
class SpellCastTargets;
class Map;
class Unit;
class WorldObject;
struct ItemPrototype;

#define MAX_SCRIPTS         5000                            //72 bytes each (approx 351kb)
#define VISIBLE_RANGE       (166.0f)                        //MAX visible range (size of grid)
#define DEFAULT_TEXT        "<Hellground Script Text Entry Missing!>"

struct Script
{
    Script() :
        pGossipHello(NULL), pGossipSelect(NULL), pGossipSelectGO(NULL),
        pGossipSelectWithCode(NULL), pGossipSelectGOWithCode(NULL),
        pDialogStatusNPC(NULL), pDialogStatusGO(NULL),
        pQuestAcceptNPC(NULL), pQuestAcceptGO(NULL), pQuestAcceptItem(NULL),
        pQuestRewardedNPC(NULL), pQuestRewardedGO(NULL),
        pGOUse(NULL), pItemUse(NULL), pAreaTrigger(NULL), pCompletedCinematic(NULL),
        pProcessEventId(NULL), pReceiveEmote(NULL),
        pEffectDummyNPC(NULL), pEffectDummyGO(NULL), pEffectDummyItem(NULL), pEffectAuraDummy(NULL),
        GetAI(NULL), GetInstanceData(NULL),

        //spell scripts
        pSpellTargetMap(NULL), pSpellHandleEffect(NULL)
    {}

    std::string Name;

    bool (*pGossipHello             )(Player*, Creature*);
    bool (*pGossipSelect            )(Player*, Creature*, uint32, uint32);
    bool (*pGossipSelectGO          )(Player*, GameObject*, uint32, uint32);
    bool (*pGossipSelectWithCode    )(Player*, Creature*, uint32, uint32, const char*);
    bool (*pGossipSelectGOWithCode  )(Player*, GameObject*, uint32, uint32, const char*);
    uint32 (*pDialogStatusNPC       )(Player*, Creature*);
    uint32 (*pDialogStatusGO        )(Player*, GameObject*);
    bool (*pQuestAcceptNPC          )(Player*, Creature*, Quest const*);
    bool (*pQuestAcceptGO           )(Player*, GameObject*, Quest const*);
    bool (*pQuestAcceptItem         )(Player*, Item*, Quest const*);
    bool (*pQuestRewardedNPC        )(Player*, Creature*, Quest const*);
    bool (*pQuestRewardedGO         )(Player*, GameObject*, Quest const*);
    bool (*pGOUse                   )(Player*, GameObject*);
    bool (*pItemUse                 )(Player*, Item*, SpellCastTargets const&);
    bool (*pAreaTrigger             )(Player*, AreaTriggerEntry const*);
    bool (*pCompletedCinematic      )(Player*, CinematicSequencesEntry const*);
    bool (*pProcessEventId          )(uint32, Object*, Object*, bool);
    bool (*pEffectDummyNPC          )(Unit*, uint32, uint32, Creature*);
    bool (*pEffectDummyGO           )(Unit*, uint32, uint32, GameObject*);
    bool (*pEffectDummyItem         )(Unit*, uint32, uint32, Item*);
    bool (*pEffectAuraDummy         )(const Aura*, bool);

    bool (*pReceiveEmote            )(Player*, Creature*, uint32);

    //spell scripts
    bool (*pSpellTargetMap          )(Unit*, std::list<Unit*> &, SpellCastTargets const&, SpellEntry const *, uint32);
    bool (*pSpellHandleEffect       )(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex);

    CreatureAI* (*GetAI             )(Creature*);
    InstanceData* (*GetInstanceData )(Map*);

    void RegisterSelf(bool bReportError = true);
};

//Generic scripting text function
void DoScriptText(int32 textEntry, WorldObject* pSource, Unit* target = NULL, bool withoutPrename = false);
void DoGlobalScriptText(int32 iTextEntry, const char *npcName, Map *map);
void ScriptText(int32 textEntry, Unit* pSource, Unit* target = NULL);

#if COMPILER == COMPILER_GNU
#define FUNC_PTR(name, callconvention, returntype, parameters)    typedef returntype(*name)parameters __attribute__ ((callconvention));
#else
#define FUNC_PTR(name, callconvention, returntype, parameters)    typedef returntype(callconvention *name)parameters;
#endif

#ifdef WIN32
#define HELLGROUND_DLL_EXPORT extern "C" __declspec(dllexport)
#elif defined( __GNUC__ )
#define HELLGROUND_DLL_EXPORT extern "C"
#else
#define HELLGROUND_DLL_EXPORT extern "C" export

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

#define MIN_DB_SCRIPT_STRING_ID        MAX_HELLGROUND_STRING_ID // 'db_script_string'
#define MAX_DB_SCRIPT_STRING_ID        2000010000

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

        void LoadDbScriptStrings();

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
        bool OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Creature* pTarget);
        bool OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, GameObject* pTarget);
        bool OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Item* pTarget);
        bool OnAuraDummy(Aura const* pAura, bool apply);

        bool OnReceiveEmote(Player *pPlayer, Creature *pCreature, uint32 emote);

        // spell scripts
        bool OnSpellSetTargetMap(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const&, SpellEntry const *pSpell, uint32 effectIndex);
        bool OnSpellHandleEffect(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex);

    private:
        void LoadScripts(ScriptMapMap& scripts, const char* tablename);
        void CheckScripts(ScriptMapMap const& scripts,std::set<int32>& ids);

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

        void (* m_pOnInitScriptLibrary)(char const*);
        void (* m_pOnFreeScriptLibrary)();
        const char* (* m_pGetScriptLibraryVersion)();

        CreatureAI* (* m_pGetCreatureAI) (Creature*);
        InstanceData* (* m_pCreateInstanceData) (Map*);

        bool (* m_pOnGossipHello) (Player*, Creature*);
        bool (* m_pOnGossipSelect) (Player*, Creature*, uint32, uint32);
        bool (* m_pOnGOGossipSelect) (Player*, GameObject*, uint32, uint32);
        bool (* m_pOnGossipSelectWithCode) (Player*, Creature*, uint32, uint32, const char*);
        bool (* m_pOnGOGossipSelectWithCode) (Player*, GameObject*, uint32, uint32, const char*);
        bool (* m_pOnQuestAccept) (Player*, Creature*, Quest const*);
        bool (* m_pOnGOQuestAccept) (Player*, GameObject*, Quest const*);
        bool (* m_pOnItemQuestAccept) (Player*, Item*, Quest const*);
        bool (* m_pOnQuestRewarded) (Player*, Creature*, Quest const*);
        bool (* m_pOnGOQuestRewarded) (Player*, GameObject*, Quest const*);
        uint32 (* m_pGetNPCDialogStatus) (Player*, Creature*);
        uint32 (* m_pGetGODialogStatus) (Player*, GameObject*);
        bool (* m_pOnGOUse) (Player*, GameObject*);
        bool (* m_pOnItemUse) (Player*, Item*, SpellCastTargets const&);
        bool (* m_pOnAreaTrigger) (Player*, AreaTriggerEntry const*);
        bool (* m_pOnCompletedCinematic) (Player*, CinematicSequencesEntry const*);
        bool (* m_pOnProcessEvent) (uint32, Object*, Object*, bool);
        bool (* m_pOnEffectDummyCreature) (Unit*, uint32, uint32, Creature*);
        bool (* m_pOnEffectDummyGO) (Unit*, uint32, uint32, GameObject*);
        bool (* m_pOnEffectDummyItem) (Unit*, uint32, uint32, Item*);
        bool (* m_pOnAuraDummy) (Aura const*, bool);

        bool (* m_pOnReceiveEmote) (Player *pPlayer, Creature *pCreature, uint32 emote);

        // spell scripts
        bool (* m_pOnSpellSetTargetMap) (Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const&, SpellEntry const *pSpell, uint32 effectIndex);
        bool (* m_pOnSpellHandleEffect) (Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex);
};

#define sScriptMgr (*ACE_Singleton<ScriptMgr, ACE_Null_Mutex>::instance())

 uint32 GetAreaTriggerScriptId(uint32 triggerId);
 uint32 GetCompletedCinematicScriptId(uint32 triggerId);
 uint32 GetScriptId(const char *name);
 uint32 GetEventIdScriptId(uint32 eventId);
 uint32 GetSpellIdScriptId(uint32 eventId);

#endif
