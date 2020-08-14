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

#include "ScriptMgr.h"
#include "Log.h"
#include "ProgressBar.h"
#include "ObjectMgr.h"
#include "WaypointMgr.h"
#include "World.h"
#include "LuaEngine/HookMgr.h"

#include "../shared/Config/Config.h"


//src/scripts/scriptmgr.cpp
#include "ScriptedPch.h"
#include "Database/DatabaseEnv.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "ProgressBar.h"
#include "ScriptLoader.h"
#include "ScriptSystem.h"

#include "ScriptMgr.h"

#define _FULLVERSION "HellgroundScript"

#ifndef _HELLGROUND_SCRIPT_CONFIG
# define _HELLGROUND_SCRIPT_CONFIG  "mangosd.conf"
#endif // _HELLGROUND_SCRIPT_CONFIG

int num_sc_scripts;
Script *m_scripts[MAX_SCRIPTS];

void FillSpellSummary();

// -------------------
void ScriptMgr::LoadDatabase()
{
    pSystemMgr.LoadVersion();
    pSystemMgr.LoadScriptTexts();
    pSystemMgr.LoadScriptTextsCustom();
    pSystemMgr.LoadScriptWaypoints(); //[TZERO] to implement
}

struct TSpellSummary
{
    uint8 Targets;                                          // set of enum SelectTarget
    uint8 Effects;                                          // set of enum SelectEffect
} extern *SpellSummary;

ScriptMgr::ScriptMgr()
{
}

ScriptMgr::~ScriptMgr()
{
    // Free Spell Summary
    delete [] SpellSummary;

    // Free resources before library unload
    for(uint16 i =0; i < MAX_SCRIPTS; ++i)
        delete m_scripts[i];

    num_sc_scripts = 0;
}


void ScriptMgr::InitScriptLibrary()
{
    //Hellground Script startup
    outstring_log(" _   _      _ _ _____                           _ ");
    outstring_log("| | | |    | | |  __ \\                         | |");
    outstring_log("| |_| | ___| | | |  \\/_ __ ___  _   _ _ __   __| |");
    outstring_log("|  _  |/ _ \\ | | | __| '__/ _ \\| | | | '_ \\ / _` |");
    outstring_log("| | | |  __/ | | |_\\ \\ | | (_) | |_| | | | | (_| |");
    outstring_log("\\_| |_/\\___|_|_|\\____/_|  \\___/ \\__,_|_| |_|\\__,_|");
    outstring_log("http://hellground.net based on http://TrinityCore.org");
    outstring_log("Hellground Script initializing %s", _FULLVERSION);

    //Load database (must be called after TScriptConfig.SetSource). In case it failed, no need to even try load.
    LoadDatabase();

    outstring_log("TSCR: Loading C++ scripts");
    BarGoLink bar(1);
    bar.step();
    outstring_log("");

    for(uint16 i = 0; i < MAX_SCRIPTS; ++i)
        m_scripts[i] = NULL;

    FillSpellSummary();

    AddScripts();

    outstring_log(">> Loaded %i C++ Scripts.", num_sc_scripts);
}

//*********************************
//*** Functions used globally ***

void DoScriptText(int32 iTextEntry, WorldObject* pSource, Unit* pTarget, bool withoutPrename)
{
    if (!iTextEntry)
        return;

    if (!pSource)
    {
        error_log("TSCR: DoScriptText entry %i, invalid Source pointer.", iTextEntry);
        return;
    }

    if (iTextEntry > 0)
    {
        error_log("TSCR: DoScriptText with source entry %u (TypeId=%u, guid=%u) attempts to process text entry %i, but text entry must be negative.", pSource->GetEntry(), pSource->GetTypeId(), pSource->GetGUIDLow(), iTextEntry);
        return;
    }

    const StringTextData* pData = pSystemMgr.GetTextData(iTextEntry);

    if (!pData)
    {
        error_log("TSCR: DoScriptText with source entry %u (TypeId=%u, guid=%u) could not find text entry %i.", pSource->GetEntry(), pSource->GetTypeId(), pSource->GetGUIDLow(), iTextEntry);
        return;
    }

    debug_log("TSCR: DoScriptText: text entry=%i, Sound=%u, Type=%u, Language=%u, Emote=%u", iTextEntry, pData->uiSoundId, pData->uiType, pData->uiLanguage, pData->uiEmote);

    if (pData->uiSoundId)
    {
        if (GetSoundEntriesStore()->LookupEntry(pData->uiSoundId))
            pSource->SendPlaySound(pData->uiSoundId, false);
        else
            error_log("TSCR: DoScriptText entry %i tried to process invalid sound id %u.", iTextEntry, pData->uiSoundId);
    }

    if (pData->uiEmote)
    {
        if (pSource->GetTypeId() == TYPEID_UNIT || pSource->GetTypeId() == TYPEID_PLAYER)
            ((Unit*)pSource)->HandleEmoteCommand(pData->uiEmote);
        else
            error_log("TSCR: DoScriptText entry %i tried to process emote for invalid TypeId (%u).", iTextEntry, pSource->GetTypeId());
    }

    switch(pData->uiType)
    {
        case CHAT_TYPE_SAY:
            pSource->MonsterSay(iTextEntry, pData->uiLanguage, pTarget ? pTarget->GetGUID() : 0);
            break;
        case CHAT_TYPE_YELL:
            pSource->MonsterYell(iTextEntry, pData->uiLanguage, pTarget ? pTarget->GetGUID() : 0);
            break;
        case CHAT_TYPE_TEXT_EMOTE:
            pSource->MonsterTextEmote(iTextEntry, pTarget ? pTarget->GetGUID() : 0, false, withoutPrename);
            break;
        case CHAT_TYPE_BOSS_EMOTE:
            pSource->MonsterTextEmote(iTextEntry, pTarget ? pTarget->GetGUID() : 0, true, withoutPrename);
            break;
        case CHAT_TYPE_WHISPER:
        {
            if (pTarget && pTarget->GetTypeId() == TYPEID_PLAYER)
                pSource->MonsterWhisper(iTextEntry, pTarget->GetGUID());
            else
                error_log("TSCR: DoScriptText entry %i cannot whisper without target unit (TYPEID_PLAYER).", iTextEntry);

            break;
        }
        case CHAT_TYPE_BOSS_WHISPER:
        {
            if (pTarget && pTarget->GetTypeId() == TYPEID_PLAYER)
                pSource->MonsterWhisper(iTextEntry, pTarget->GetGUID(), true);
            else
                error_log("TSCR: DoScriptText entry %i cannot whisper without target unit (TYPEID_PLAYER).", iTextEntry);

            break;
        }
        case CHAT_TYPE_ZONE_YELL:
            pSource->MonsterYellToZone(iTextEntry, pData->uiLanguage, pTarget ? pTarget->GetGUID() : 0);
            break;
        case CHAT_TYPE_ZONE_BOSS_EMOTE:
            pSource->MonsterTextEmoteToZone(iTextEntry, pTarget ? pTarget->GetGUID() : 0, true, withoutPrename);
            break;
    }

    if (pTarget && pTarget->GetTypeId() == TYPEID_UNIT)
        ((Creature*)pTarget)->AI()->ReceiveScriptText(pSource, iTextEntry);
}

void DoGlobalScriptText(int32 iTextEntry, const char *npcName, Map *map)
{
    if (iTextEntry >= 0)
    {
        error_log("TSCR: DoGlobalScriptText with npc name %s attempts to process text entry %i, but text entry must be negative.", npcName, iTextEntry);
        return;
    }

    const StringTextData* pData = pSystemMgr.GetTextData(iTextEntry);

    if (!pData)
    {
        error_log("TSCR: DoGlobalScriptText with npc name %s could not find text entry %i.", npcName, iTextEntry);
        return;
    }

    bool playSound = pData->uiSoundId && GetSoundEntriesStore()->LookupEntry(pData->uiSoundId);
    uint32 textType = 0;
    switch(pData->uiType)
    {
        case CHAT_TYPE_SAY:
            textType = CHAT_MSG_MONSTER_SAY;
            break;
        case CHAT_TYPE_YELL:
        case CHAT_TYPE_ZONE_YELL:
            textType = CHAT_MSG_MONSTER_YELL;
            break;
        case CHAT_TYPE_TEXT_EMOTE:
            textType = CHAT_MSG_MONSTER_EMOTE;
            break;
        case CHAT_TYPE_BOSS_EMOTE:
            textType = CHAT_MSG_RAID_BOSS_EMOTE;
            break;
        case CHAT_TYPE_WHISPER:
            textType = CHAT_MSG_MONSTER_WHISPER;
            break;
        case CHAT_TYPE_BOSS_WHISPER:
            textType = CHAT_MSG_RAID_BOSS_WHISPER;
            break;
    }

    Map::PlayerList const &players = map->GetPlayers();
    for(Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
    {
        if(Player *player = i->getSource())
        {
            WorldPacket data(SMSG_MESSAGECHAT, 200);
            player->BuildMonsterChat(&data,textType,iTextEntry,LANG_UNIVERSAL,npcName,player->GetGUID());
            player->GetSession()->SendPacket(&data);
            if(playSound)
                (*i).getSource()->SendPlaySound(pData->uiSoundId, true);
        }
    }
}

//*********************************
//*** Functions used internally ***

void Script::RegisterSelf(bool bReportError)
{
    if (uint32 id = GetScriptId(Name.c_str()))
    {
        m_scripts[id] = this;
        ++num_sc_scripts;
    }
    else
    {
        if (bReportError)
            error_log("SD2: Script registering but ScriptName %s is not assigned in database. Script will not be used.", Name.c_str());

        delete this;
    }
}

//********************************
//*** Functions to be Exported ***


char const* GetScriptLibraryVersion()
{
    return "Default Hellground scripting library";
}


bool ScriptMgr::OnChat(Player* pPlayer, uint32 type, uint32 lang, std::string& msg)
{
    /*Script* pTempScript = m_scripts["OnChat"];

    return pTempScript->pOnChat(pPlayer, type, lang, msg);*/
	return false;
}


bool ScriptMgr::OnGossipSelect(Player* pPlayer, Item* pItem, uint32 uiSender, uint32 uiAction)
{
	debug_log("SD2: GO Gossip selection, sender: %u, action: %u", uiSender, uiAction);

	Script* pTempScript = m_scripts[pItem->GetProto()->ScriptId];

	if (!pTempScript || !pTempScript->pGossipSelectITEM)
		return false;

	pPlayer->PlayerTalkClass->ClearMenus();

	return pTempScript->pGossipSelectITEM(pPlayer, pItem, uiSender, uiAction);
}


bool ScriptMgr::OnPVPKill( Player *pKiller, Player *pKilled )
{

	Script *tmpscript = m_scripts[GetScriptId("OnPVPKill")];
	if (!tmpscript || !tmpscript->pPVPKill) return false;
	return tmpscript->pPVPKill(pKiller, pKilled);
}


bool ScriptMgr::OnCreatureKill( Player *pKiller, Creature *cKilled )
{
	Script *tmpscript = m_scripts[GetScriptId("OnCreatureKill")];
	if (!tmpscript || !tmpscript->pCreatureKill) return false;
	return tmpscript->pCreatureKill(pKiller, cKilled);
}


bool ScriptMgr::OnGossipSelectCode(Player* pPlayer, Item* pItem, uint32 uiSender, uint32 uiAction, const char* sCode)
{
	debug_log("SD2: ITEM Gossip selection with code, sender: %u, action: %u", uiSender, uiAction);

	Script* pTempScript = m_scripts[pItem->GetProto()->ScriptId];

	if (!pTempScript || !pTempScript->pGossipSelectITEMWithCode)
		return false;

	pPlayer->PlayerTalkClass->ClearMenus();

	return pTempScript->pGossipSelectITEMWithCode(pPlayer, pItem, uiSender, uiAction, sCode);
}


bool ScriptMgr::OnGossipHello(Player* pPlayer, Creature* pCreature)
{
    // used by eluna
    if (sHookMgr->OnGossipHello(pPlayer, pCreature))
        return true;

    Script* pTempScript = m_scripts[pCreature->GetScriptId()];

    if (!pTempScript || !pTempScript->pGossipHello)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pGossipHello(pPlayer, pCreature);
}

bool ScriptMgr::OnGossipHello(Player* pPlayer, GameObject* pGo)
{
    // used by eluna
    if (sHookMgr->OnGossipHello(pPlayer, pGo))
        return true;

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pGossipHello)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pGossipHelloGO(pPlayer, pGo);
}


bool ScriptMgr::OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
    debug_log("SD2: Gossip selection, sender: %u, action: %u", uiSender, uiAction);

    // used by eluna
    if (sHookMgr->OnGossipSelect(pPlayer, pCreature, uiSender, uiAction))
        return true;

    Script* pTempScript = m_scripts[pCreature->GetScriptId()];

    if (!pTempScript || !pTempScript->pGossipSelect)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pGossipSelect(pPlayer, pCreature, uiSender, uiAction);
}


bool ScriptMgr::OnGossipSelect(Player* pPlayer, GameObject* pGo, uint32 uiSender, uint32 uiAction)
{
    debug_log("SD2: GO Gossip selection, sender: %u, action: %u", uiSender, uiAction);

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pGossipSelectGO)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pGossipSelectGO(pPlayer, pGo, uiSender, uiAction);
}


bool ScriptMgr::OnGossipSelectCode(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction, const char* sCode)
{
    debug_log("SD2: Gossip selection with code, sender: %u, action: %u", uiSender, uiAction);

    // used by eluna
    if (sHookMgr->OnGossipSelectCode(pPlayer, pCreature, uiSender, uiAction, sCode))
        return true;

    Script* pTempScript = m_scripts[pCreature->GetScriptId()];

    if (!pTempScript || !pTempScript->pGossipSelectWithCode)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pGossipSelectWithCode(pPlayer, pCreature, uiSender, uiAction, sCode);
}


bool ScriptMgr::OnGossipSelectCode(Player* pPlayer, GameObject* pGo, uint32 uiSender, uint32 uiAction, const char* sCode)
{
    debug_log("SD2: GO Gossip selection with code, sender: %u, action: %u", uiSender, uiAction);

    // used by eluna
    if (sHookMgr->OnGossipSelectCode(pPlayer, pGo, uiSender, uiAction, sCode))
        return true;

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pGossipSelectGOWithCode)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pGossipSelectGOWithCode(pPlayer, pGo, uiSender, uiAction, sCode);
}


bool ScriptMgr::OnQuestAccept(Player* pPlayer, Creature* pCreature, const Quest* pQuest)
{

    // used by eluna
    if (sHookMgr->OnQuestAccept(pPlayer, pCreature, pQuest))
        return true;

    Script* pTempScript = m_scripts[pCreature->GetScriptId()];

    if (!pTempScript || !pTempScript->pQuestAcceptNPC)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pQuestAcceptNPC(pPlayer, pCreature, pQuest);
}


bool ScriptMgr::OnQuestRewarded(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
{

    // used by eluna
    if (sHookMgr->OnQuestReward(pPlayer, pCreature, pQuest))
        return true;

    Script* pTempScript = m_scripts[pCreature->GetScriptId()];

    if (!pTempScript || !pTempScript->pQuestRewardedNPC)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pQuestRewardedNPC(pPlayer, pCreature, pQuest);
}


uint32 ScriptMgr::GetDialogStatus(Player* pPlayer, Creature* pCreature)
{
    // used by eluna
    if (uint32 dialogId = sHookMgr->GetDialogStatus(pPlayer, pCreature))
        return dialogId;

    Script* pTempScript = m_scripts[pCreature->GetScriptId()];

    if (!pTempScript || !pTempScript->pDialogStatusNPC)
        return 100;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pDialogStatusNPC(pPlayer, pCreature);
}


uint32 ScriptMgr::GetDialogStatus(Player* pPlayer, GameObject* pGo)
{
    // used by eluna
    if (uint32 dialogId = sHookMgr->GetDialogStatus(pPlayer, pGo))
        return dialogId;

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pDialogStatusGO)
        return 100;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pDialogStatusGO(pPlayer, pGo);
}


bool ScriptMgr::OnQuestAccept(Player* pPlayer, Item* pItem, Quest const* pQuest)
{

    // used by eluna
    if (sHookMgr->OnQuestAccept(pPlayer, pItem, pQuest))
        return true;

    Script* pTempScript = m_scripts[pItem->GetProto()->ScriptId];

    if (!pTempScript || !pTempScript->pQuestAcceptItem)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pQuestAcceptItem(pPlayer, pItem, pQuest);
}


bool ScriptMgr::OnGameObjectUse(Player* pPlayer, GameObject* pGo)
{
    // used by eluna
    if (sHookMgr->OnGameObjectUse(pPlayer, pGo))
        return true;

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pGOUse)
        return false;

    return pTempScript->pGOUse(pPlayer, pGo);
}


bool ScriptMgr::OnQuestAccept(Player* pPlayer, GameObject* pGo, const Quest* pQuest)
{

    // used by eluna
    if (sHookMgr->OnQuestAccept(pPlayer, pGo, pQuest))
        return true;

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pQuestAcceptGO)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pQuestAcceptGO(pPlayer, pGo, pQuest);
}


bool ScriptMgr::OnQuestRewarded(Player* pPlayer, GameObject* pGo, Quest const* pQuest)
{
    // used by eluna
    if (sHookMgr->OnQuestReward(pPlayer, pGo, pQuest))
        return true;

    Script* pTempScript = m_scripts[pGo->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pQuestRewardedGO)
        return false;

    pPlayer->PlayerTalkClass->ClearMenus();

    return pTempScript->pQuestRewardedGO(pPlayer, pGo, pQuest);
}


bool ScriptMgr::OnAreaTrigger(Player* pPlayer, AreaTriggerEntry const* atEntry)
{

    // used by eluna
    if (sHookMgr->OnAreaTrigger(pPlayer, atEntry))
        return true;


    Script* pTempScript = m_scripts[GetAreaTriggerScriptId(atEntry->id)];

    if (!pTempScript || !pTempScript->pAreaTrigger)
        return false;

    return pTempScript->pAreaTrigger(pPlayer, atEntry);
}


bool ScriptMgr::OnCompletedCinematic(Player* pPlayer, CinematicSequencesEntry const* cinematic)
{
    Script* pTempScript = m_scripts[GetCompletedCinematicScriptId(cinematic->Id)];

    if (!pTempScript || !pTempScript->pCompletedCinematic)
        return false;

    return pTempScript->pCompletedCinematic(pPlayer, cinematic);
}


bool ScriptMgr::OnProcessEvent(uint32 uiEventId, Object* pSource, Object* pTarget, bool bIsStart)
{
    Script* pTempScript = m_scripts[GetEventIdScriptId(uiEventId)];

    if (!pTempScript || !pTempScript->pProcessEventId)
        return false;

    // bIsStart may be false, when event is from taxi node events (arrival=false, departure=true)
    return pTempScript->pProcessEventId(uiEventId, pSource, pTarget, bIsStart);
}

bool ScriptMgr::OnItemUse(Player* pPlayer, Item* pItem, SpellCastTargets const& targets)
{
    // used by eluna
    if (sHookMgr->OnUse(pPlayer, pItem, targets))
        return true;

    Script* pTempScript = m_scripts[pItem->GetProto()->ScriptId];

    if (!pTempScript || !pTempScript->pItemUse)
        return false;

    return pTempScript->pItemUse(pPlayer, pItem, targets);
}


bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Creature* pTarget)
{
    // used by eluna
    if (sHookMgr->OnDummyEffect(pCaster, spellId, effIndex, pTarget))
        return true;

    Script* pTempScript = m_scripts[pTarget->GetScriptId()];

    if (!pTempScript || !pTempScript->pEffectDummyNPC)
        return false;

    return pTempScript->pEffectDummyNPC(pCaster, spellId, effIndex, pTarget);
}


bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, GameObject* pTarget)
{
    // used by eluna
    if (sHookMgr->OnDummyEffect(pCaster, spellId, effIndex, pTarget))
        return true;

    Script* pTempScript = m_scripts[pTarget->GetGOInfo()->ScriptId];

    if (!pTempScript || !pTempScript->pEffectDummyGO)
        return false;

    return pTempScript->pEffectDummyGO(pCaster, spellId, effIndex, pTarget);
}


bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Item* pTarget)
{
    // used by eluna
    if (sHookMgr->OnDummyEffect(pCaster, spellId, effIndex, pTarget))
        return true;

    Script* pTempScript = m_scripts[pTarget->GetProto()->ScriptId];

    if (!pTempScript || !pTempScript->pEffectDummyItem)
        return false;

    return pTempScript->pEffectDummyItem(pCaster, spellId, effIndex, pTarget);
}


bool ScriptMgr::OnAuraDummy(Aura const* pAura, bool bApply)
{
    Script* pTempScript = m_scripts[((Creature*)pAura->GetTarget())->GetScriptId()];

    if (!pTempScript || !pTempScript->pEffectAuraDummy)
        return false;

    return pTempScript->pEffectAuraDummy(pAura, bApply);
}


bool ScriptMgr::OnReceiveEmote( Player *player, Creature *_Creature, uint32 emote )
{
    Script *tmpscript = m_scripts[_Creature->GetScriptId()];
    if (!tmpscript || !tmpscript->pReceiveEmote) return false;

    return tmpscript->pReceiveEmote(player, _Creature, emote);
}



InstanceData* ScriptMgr::CreateInstanceData(Map* pMap)
{
    if (!pMap->IsDungeon())
        return NULL;
    Script* pTempScript = m_scripts[((InstanceMap*)pMap)->GetScriptId()];

    if (!pTempScript || !pTempScript->GetInstanceData)
        return NULL;

    return pTempScript->GetInstanceData(pMap);
}


bool ScriptMgr::OnSpellSetTargetMap(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const& targets, SpellEntry const *pSpell, uint32 effectIndex)
{
    Script* pTempScript = m_scripts[GetSpellIdScriptId(pSpell->Id)];

    if (!pTempScript || !pTempScript->pSpellTargetMap)
        return false;

    return pTempScript->pSpellTargetMap(pCaster, unitList, targets, pSpell, effectIndex);
}


bool ScriptMgr::OnSpellHandleEffect(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
{
    Script* pTempScript = m_scripts[GetSpellIdScriptId(pSpell->Id)];

    if (!pTempScript || !pTempScript->pSpellHandleEffect)
        return false;

    return pTempScript->pSpellHandleEffect(pCaster, pUnit, pItem, pGameObject, pSpell, effectIndex);
}


//src/game/scriptmgr.cpp

ScriptMapMap sQuestEndScripts;
ScriptMapMap sQuestStartScripts;
ScriptMapMap sSpellScripts;
ScriptMapMap sGameObjectScripts;
ScriptMapMap sEventScripts;
ScriptMapMap sGossipScripts;
ScriptMapMap sWaypointScripts;

//ScriptMgr::ScriptMgr() :
//    m_hScriptLib(NULL),
//    m_pOnInitScriptLibrary(NULL),
//    m_pOnFreeScriptLibrary(NULL),
//    m_pGetScriptLibraryVersion(NULL),
//    m_pGetCreatureAI(NULL),
//    m_pCreateInstanceData(NULL),
//
//	m_pOnChat(NULL),
//    m_pOnGossipHello(NULL),
//    m_pOnGossipSelect(NULL),
//    m_pOnGOGossipSelect(NULL),
//	m_pOnITEMGossipSelect(NULL),
//    m_pOnGossipSelectWithCode(NULL),
//    m_pOnGOGossipSelectWithCode(NULL),
//	m_pOnITEMGossipSelectWithCode(NULL),
//    m_pOnQuestAccept(NULL),
//    m_pOnGOQuestAccept(NULL),
//    m_pOnItemQuestAccept(NULL),
//    m_pOnQuestRewarded(NULL),
//    m_pOnGOQuestRewarded(NULL),
//    m_pGetNPCDialogStatus(NULL),
//    m_pGetGODialogStatus(NULL),
//    m_pOnGOUse(NULL),
//    m_pOnItemUse(NULL),
//    m_pOnAreaTrigger(NULL),
//    m_pOnCompletedCinematic(NULL),
//    m_pOnProcessEvent(NULL),
//    m_pOnEffectDummyCreature(NULL),
//    m_pOnEffectDummyGO(NULL),
//    m_pOnEffectDummyItem(NULL),
//    m_pOnAuraDummy(NULL),
//    m_pOnReceiveEmote(NULL),
//	m_pOnPVPKill(NULL),
//	m_pOnCreatureKill(NULL),
//    // spell scripts
//    m_pOnSpellSetTargetMap(NULL),
//    m_pOnSpellHandleEffect(NULL)
//{
//}
//
//ScriptMgr::~ScriptMgr()
//{
//    UnloadScriptLibrary();
//}

void ScriptMgr::LoadScripts(ScriptMapMap& scripts, char const* tablename)
{
    if (sWorld.IsScriptScheduled())                          // function don't must be called in time scripts use.
        return;

    sLog.outString("%s :", tablename);

    scripts.clear();                                        // need for reload support

    QueryResult* result = GameDataDatabase.PQuery("SELECT id,delay,command,datalong,datalong2,dataint, x, y, z, o FROM %s", tablename);

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u script definitions", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        bar.step();

        Field *fields = result->Fetch();
        ScriptInfo tmp;
        tmp.id        = fields[0].GetUInt32();
        tmp.delay     = fields[1].GetUInt32();
        tmp.command   = fields[2].GetUInt32();
        tmp.datalong  = fields[3].GetUInt32();
        tmp.datalong2 = fields[4].GetUInt32();
        tmp.dataint   = fields[5].GetInt32();
        tmp.x         = fields[6].GetFloat();
        tmp.y         = fields[7].GetFloat();
        tmp.z         = fields[8].GetFloat();
        tmp.o         = fields[9].GetFloat();

        // generic command args check
        switch (tmp.command)
        {
            case SCRIPT_COMMAND_TALK:
            {
                if (tmp.datalong > 3)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid talk type (datalong = %u) in SCRIPT_COMMAND_TALK for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                if (tmp.dataint==0)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid talk text id (dataint = %i) in SCRIPT_COMMAND_TALK for script id %u",tablename,tmp.dataint,tmp.id);
                    continue;
                }

                if (tmp.dataint < MIN_DB_SCRIPT_STRING_ID || tmp.dataint >= MAX_DB_SCRIPT_STRING_ID)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has out of range text id (dataint = %i expected %u-%u) in SCRIPT_COMMAND_TALK for script id %u",tablename,tmp.dataint,MIN_DB_SCRIPT_STRING_ID,MAX_DB_SCRIPT_STRING_ID,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_EMOTE:
            {
                if (!sEmotesStore.LookupEntry(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid emote id (datalong = %u) in SCRIPT_COMMAND_EMOTE for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_TELEPORT_TO:
            {
                if (!sMapStore.LookupEntry(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid map (Id: %u) in SCRIPT_COMMAND_TELEPORT_TO for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                if (!MaNGOS::IsValidMapCoord(tmp.x,tmp.y,tmp.z,tmp.o))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid coordinates (X: %f Y: %f) in SCRIPT_COMMAND_TELEPORT_TO for script id %u",tablename,tmp.x,tmp.y,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_TEMP_SUMMON_CREATURE:
            {
                if (!MaNGOS::IsValidMapCoord(tmp.x,tmp.y,tmp.z,tmp.o))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid coordinates (X: %f Y: %f) in SCRIPT_COMMAND_TEMP_SUMMON_CREATURE for script id %u",tablename,tmp.x,tmp.y,tmp.id);
                    continue;
                }

                if (!sObjectMgr.GetCreatureTemplate(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid creature (Entry: %u) in SCRIPT_COMMAND_TEMP_SUMMON_CREATURE for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }
                break;
            }

            case SCRIPT_COMMAND_RESPAWN_GAMEOBJECT:
            {
                GameObjectData const* data = sObjectMgr.GetGOData(tmp.datalong);
                if (!data)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid gameobject (GUID: %u) in SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                GameObjectInfo const* info = GetGameObjectInfo(data->id);
                if (!info)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has gameobject with invalid entry (GUID: %u Entry: %u) in SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id %u",tablename,tmp.datalong,data->id,tmp.id);
                    continue;
                }

                if (info->type==GAMEOBJECT_TYPE_FISHINGNODE ||
                    info->type==GAMEOBJECT_TYPE_FISHINGHOLE ||
                    info->type==GAMEOBJECT_TYPE_DOOR        ||
                    info->type==GAMEOBJECT_TYPE_BUTTON      ||
                    info->type==GAMEOBJECT_TYPE_TRAP)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` have gameobject type (%u) unsupported by command SCRIPT_COMMAND_RESPAWN_GAMEOBJECT for script id %u",tablename,info->id,tmp.id);
                    continue;
                }
                break;
            }
            case SCRIPT_COMMAND_OPEN_DOOR:
            case SCRIPT_COMMAND_CLOSE_DOOR:
            {
                GameObjectData const* data = sObjectMgr.GetGOData(tmp.datalong);
                if (!data)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid gameobject (GUID: %u) in %s for script id %u",tablename,tmp.datalong,(tmp.command==SCRIPT_COMMAND_OPEN_DOOR ? "SCRIPT_COMMAND_OPEN_DOOR" : "SCRIPT_COMMAND_CLOSE_DOOR"),tmp.id);
                    continue;
                }

                GameObjectInfo const* info = GetGameObjectInfo(data->id);
                if (!info)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has gameobject with invalid entry (GUID: %u Entry: %u) in %s for script id %u",tablename,tmp.datalong,data->id,(tmp.command==SCRIPT_COMMAND_OPEN_DOOR ? "SCRIPT_COMMAND_OPEN_DOOR" : "SCRIPT_COMMAND_CLOSE_DOOR"),tmp.id);
                    continue;
                }

                if (info->type!=GAMEOBJECT_TYPE_DOOR)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has gameobject type (%u) non supported by command %s for script id %u",tablename,info->id,(tmp.command==SCRIPT_COMMAND_OPEN_DOOR ? "SCRIPT_COMMAND_OPEN_DOOR" : "SCRIPT_COMMAND_CLOSE_DOOR"),tmp.id);
                    continue;
                }
                break;
            }
            case SCRIPT_COMMAND_QUEST_EXPLORED:
            {
                Quest const* quest = sObjectMgr.GetQuestTemplate(tmp.datalong);
                if (!quest)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has invalid quest (ID: %u) in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u",tablename,tmp.datalong,tmp.id);
                    continue;
                }

                if (!quest->HasFlag(QUEST_HELLGROUND_FLAGS_EXPLORATION_OR_EVENT))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has quest (ID: %u) in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u, but quest not have flag QUEST_HELLGROUND_FLAGS_EXPLORATION_OR_EVENT in quest flags. Script command or quest flags wrong. Quest modified to require objective.",tablename,tmp.datalong,tmp.id);

                    // this will prevent quest completing without objective
                    const_cast<Quest*>(quest)->SetFlag(QUEST_HELLGROUND_FLAGS_EXPLORATION_OR_EVENT);

                    // continue; - quest objective requirement set and command can be allowed
                }

                if (float(tmp.datalong2) > DEFAULT_VISIBILITY_DISTANCE)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has too large distance (%u) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u",
                        tablename,tmp.datalong2,tmp.id);
                    continue;
                }

                if (tmp.datalong2 && float(tmp.datalong2) > DEFAULT_VISIBILITY_DISTANCE)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has too large distance (%u) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u, max distance is %f or 0 for disable distance check",
                        tablename,tmp.datalong2,tmp.id,DEFAULT_VISIBILITY_DISTANCE);
                    continue;
                }

                if (tmp.datalong2 && float(tmp.datalong2) < INTERACTION_DISTANCE)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has too small distance (%u) for exploring objective complete in `datalong2` in SCRIPT_COMMAND_QUEST_EXPLORED in `datalong` for script id %u, min distance is %f or 0 for disable distance check",
                        tablename,tmp.datalong2,tmp.id,INTERACTION_DISTANCE);
                    continue;
                }

                break;
            }

            case SCRIPT_COMMAND_REMOVE_AURA:
            case SCRIPT_COMMAND_CAST_SPELL:
            {
                if (!sSpellStore.LookupEntry(tmp.datalong))
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` using non-existent spell (id: %u) in SCRIPT_COMMAND_REMOVE_AURA or SCRIPT_COMMAND_CAST_SPELL for script id %u",
                        tablename,tmp.datalong,tmp.id);
                    continue;
                }
                break;
            }
            case SCRIPT_COMMAND_SET_INST_DATA:
            {
                if (tmp.datalong2 < 0 || tmp.datalong2 > 5)
                {
                    sLog.outLog(LOG_DB_ERR, "Table `%s` has wrong value (%u) for instance data in `datalong2` in SCRIPT_COMMAND_SET_INST_DATA in `datalong2` for script id %u",
                        tablename,tmp.datalong2,tmp.id);
                    continue;
                }
                break;
            }
        }

        if (scripts.find(tmp.id) == scripts.end())
        {
            ScriptMap emptyMap;
            scripts[tmp.id] = emptyMap;
        }
        scripts[tmp.id].insert(std::pair<uint32, ScriptInfo>(tmp.delay, tmp));

        ++count;
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u script definitions", count);
}

void ScriptMgr::CheckScripts(ScriptMapMap const& scripts,std::set<int32>& ids)
{
    for (ScriptMapMap::const_iterator itrMM = scripts.begin(); itrMM != scripts.end(); ++itrMM)
    {
        for (ScriptMap::const_iterator itrM = itrMM->second.begin(); itrM != itrMM->second.end(); ++itrM)
        {
            if (itrM->second.dataint)
            {
                if (!sObjectMgr.GetHellgroundStringLocale (itrM->second.dataint))
                    sLog.outLog(LOG_DB_ERR, "Table `db_script_string` has not existed string id  %u", itrM->first);

                if (ids.count(itrM->second.dataint))
                    ids.erase(itrM->second.dataint);
            }
        }
    }
}

void ScriptMgr::LoadGameObjectScripts()
{
    LoadScripts(sGameObjectScripts, "gameobject_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sGameObjectScripts.begin(); itr != sGameObjectScripts.end(); ++itr)
    {
        if (!sObjectMgr.GetGOData(itr->first))
            sLog.outLog(LOG_DB_ERR, "Table `gameobject_scripts` has not existing gameobject (GUID: %u) as script id", itr->first);
    }
}

void ScriptMgr::LoadQuestEndScripts()
{
    LoadScripts(sQuestEndScripts, "quest_end_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sQuestEndScripts.begin(); itr != sQuestEndScripts.end(); ++itr)
    {
        if (!sObjectMgr.GetQuestTemplate(itr->first))
            sLog.outLog(LOG_DB_ERR, "Table `quest_end_scripts` has not existing quest (Id: %u) as script id", itr->first);
    }
}

void ScriptMgr::LoadQuestStartScripts()
{
    LoadScripts(sQuestStartScripts,"quest_start_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sQuestStartScripts.begin(); itr != sQuestStartScripts.end(); ++itr)
    {
        if (!sObjectMgr.GetQuestTemplate(itr->first))
            sLog.outLog(LOG_DB_ERR, "Table `quest_start_scripts` has not existing quest (Id: %u) as script id", itr->first);
    }
}

void ScriptMgr::LoadSpellScripts()
{
    LoadScripts(sSpellScripts, "spell_scripts");

    // check ids
    for (ScriptMapMap::const_iterator itr = sSpellScripts.begin(); itr != sSpellScripts.end(); ++itr)
    {
        SpellEntry const* spellInfo = sSpellStore.LookupEntry(itr->first);
        if (!spellInfo)
        {
            sLog.outLog(LOG_DB_ERR, "Table `spell_scripts` has not existing spell (Id: %u) as script id", itr->first);
            continue;
        }

        //check for correct spellEffect
        bool found = false;
        for (int i=0; i<3; ++i)
        {
            // skip empty effects
            if (!spellInfo->Effect[i])
                continue;

            if (spellInfo->Effect[i] == SPELL_EFFECT_SCRIPT_EFFECT)
            {
                found =  true;
                break;
            }
        }

        if (!found)
            sLog.outLog(LOG_DB_ERR, "Table `spell_scripts` has unsupported spell (Id: %u) without SPELL_EFFECT_SCRIPT_EFFECT (%u) spell effect",itr->first,SPELL_EFFECT_SCRIPT_EFFECT);
    }
}

void ScriptMgr::LoadEventScripts()
{
    LoadScripts(sEventScripts, "event_scripts");

    std::set<uint32> evt_scripts;
    // Load all possible script entries from gameobjects
    for (uint32 i = 1; i < sGOStorage.MaxEntry; ++i)
    {
        if (GameObjectInfo const * goInfo = sGOStorage.LookupEntry<GameObjectInfo>(i))
            if (uint32 eventId = goInfo->GetEventScriptId())
                evt_scripts.insert(eventId);
    }

    // Load all possible script entries from spells
    for (uint32 i = 1; i < sSpellStore.GetNumRows(); ++i)
    {
        SpellEntry const * spell = sSpellStore.LookupEntry(i);
        if (spell)
        {
            for (int j=0; j<3; ++j)
            {
                if (spell->Effect[j] == SPELL_EFFECT_SEND_EVENT)
                {
                    if (spell->EffectMiscValue[j])
                        evt_scripts.insert(spell->EffectMiscValue[j]);
                }
            }
        }
    }

    for (size_t path_idx = 0; path_idx < sTaxiPathNodesByPath.size(); ++path_idx)
    {
        for (size_t node_idx = 0; node_idx < sTaxiPathNodesByPath[path_idx].size(); ++node_idx)
        {
            TaxiPathNodeEntry const& node = sTaxiPathNodesByPath[path_idx][node_idx];

            if (node.arrivalEventID)
                evt_scripts.insert(node.arrivalEventID);

            if (node.departureEventID)
                evt_scripts.insert(node.departureEventID);
        }
    }

    // Then check if all scripts are in above list of possible script entries
    for (ScriptMapMap::const_iterator itr = sEventScripts.begin(); itr != sEventScripts.end(); ++itr)
    {
        std::set<uint32>::const_iterator itr2 = evt_scripts.find(itr->first);
        if (itr2 == evt_scripts.end())
            sLog.outLog(LOG_DB_ERR, "Table `event_scripts` has script (Id: %u) not referring to any gameobject_template type 10 data2 field or type 3 data6 field or any spell effect %u", itr->first, SPELL_EFFECT_SEND_EVENT);
    }
}

void ScriptMgr::LoadEventIdScripts()
{
    m_EventIdScripts.clear();                           // need for reload case
    QueryResult* result = GameDataDatabase.Query("SELECT id, ScriptName FROM scripted_event_id");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u scripted event id", count);
        return;
    }

    BarGoLink bar((int)result->GetRowCount());

    // TODO: remove duplicate code below, same way to collect event id's used in LoadEventScripts()
    std::set<uint32> evt_scripts;

    // Load all possible event entries from gameobjects
    for(uint32 i = 1; i < sGOStorage.MaxEntry; ++i)
        if (GameObjectInfo const* goInfo = sGOStorage.LookupEntry<GameObjectInfo>(i))
            if (uint32 eventId = goInfo->GetEventScriptId())
                evt_scripts.insert(eventId);

    // Load all possible event entries from spells
    for(uint32 i = 1; i < sSpellStore.GetNumRows(); ++i)
    {
        SpellEntry const* spell = sSpellStore.LookupEntry(i);
        if (spell)
        {
            for(int j = 0; j < 3; ++j)
            {
                if (spell->Effect[j] == SPELL_EFFECT_SEND_EVENT)
                {
                    if (spell->EffectMiscValue[j])
                        evt_scripts.insert(spell->EffectMiscValue[j]);
                }
            }
        }
    }

    // Load all possible event entries from taxi path nodes
    for(size_t path_idx = 0; path_idx < sTaxiPathNodesByPath.size(); ++path_idx)
    {
        for(size_t node_idx = 0; node_idx < sTaxiPathNodesByPath[path_idx].size(); ++node_idx)
        {
            TaxiPathNodeEntry const& node = sTaxiPathNodesByPath[path_idx][node_idx];

            if (node.arrivalEventID)
                evt_scripts.insert(node.arrivalEventID);

            if (node.departureEventID)
                evt_scripts.insert(node.departureEventID);
        }
    }

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 eventId          = fields[0].GetUInt32();
        const char *scriptName  = fields[1].GetString();

        std::set<uint32>::const_iterator itr = evt_scripts.find(eventId);
        if (itr == evt_scripts.end())
            sLog.outLog(LOG_DB_ERR, "Table `scripted_event_id` has id %u not referring to any gameobject_template type 10 data2 field, type 3 data6 field, type 13 data 2 field or any spell effect %u or path taxi node data",
                eventId, SPELL_EFFECT_SEND_EVENT);

        m_EventIdScripts[eventId] = GetScriptId(scriptName);
    } while(result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u scripted event id", count);
}

void ScriptMgr::LoadSpellIdScripts()
{
    m_SpellIdScripts.clear();                           // need for reload case
    QueryResult* result = GameDataDatabase.Query("SELECT id, ScriptName FROM scripted_spell_id");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u scripted spell id", count);
        return;
    }

    BarGoLink bar(int(result->GetRowCount()));

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 spellId          = fields[0].GetUInt32();
        const char *scriptName  = fields[1].GetString();

        SpellEntry const *pSpell = GetSpellStore()->LookupEntry(spellId);
        if (!pSpell)
            sLog.outLog(LOG_DB_ERR, "Table `scripted_spell_id` has id %u referring to non-existing spell", spellId);

        m_SpellIdScripts[spellId] = GetScriptId(scriptName);
    }
    while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u scripted spell id", count);
}

//Load WP Scripts
void ScriptMgr::LoadWaypointScripts()
{
    LoadScripts(sWaypointScripts, "waypoint_scripts");

    for (ScriptMapMap::const_iterator itr = sWaypointScripts.begin(); itr != sWaypointScripts.end(); ++itr)
    {
        QueryResult* query = GameDataDatabase.PQuery("SELECT * FROM `waypoint_scripts` WHERE `id` = %u", itr->first);
        if (!query || !query->GetRowCount())
            sLog.outLog(LOG_DB_ERR, "There is no waypoint which links to the waypoint script %u", itr->first);
    }
}

void ScriptMgr::LoadDbScriptStrings()
{
    LoadHellgroundStrings(GameDataDatabase,"db_script_string",MIN_DB_SCRIPT_STRING_ID,MAX_DB_SCRIPT_STRING_ID);

    std::set<int32> ids;

    for (int32 i = MIN_DB_SCRIPT_STRING_ID; i < MAX_DB_SCRIPT_STRING_ID; ++i)
        if (sObjectMgr.GetHellgroundStringLocale(i))
            ids.insert(i);

    CheckScripts(sQuestEndScripts,ids);
    CheckScripts(sQuestStartScripts,ids);
    CheckScripts(sSpellScripts,ids);
    CheckScripts(sGameObjectScripts,ids);
    CheckScripts(sEventScripts,ids);

    CheckScripts(sWaypointScripts,ids);

    for (std::set<int32>::const_iterator itr = ids.begin(); itr != ids.end(); ++itr)
        sLog.outLog(LOG_DB_ERR, "Table `db_script_string` has unused string id  %u", *itr);
}

void ScriptMgr::LoadScriptNames()
{
    m_scriptNames.push_back("");
    QueryResult* result = GameDataDatabase.Query(
      "SELECT DISTINCT(ScriptName) FROM creature_template WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM gameobject_template WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM item_template WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM areatrigger_scripts WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM completed_cinematic_scripts WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM scripted_event_id WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(ScriptName) FROM scripted_spell_id WHERE ScriptName <> '' "
      "UNION "
      "SELECT DISTINCT(script) FROM instance_template WHERE script <> ''");
    if (result)
    {
        do
        {
            m_scriptNames.push_back((*result)[0].GetString());
        } while (result->NextRow());
    }
	m_scriptNames.push_back("OnPVPKill");
	m_scriptNames.push_back("OnCreatureKill");
    std::sort(m_scriptNames.begin(), m_scriptNames.end());
}

void ScriptMgr::LoadAreaTriggerScripts()
{
    m_AreaTriggerScripts.clear();                            // need for reload case
    QueryResult* result = GameDataDatabase.Query("SELECT entry, ScriptName FROM areatrigger_scripts");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u areatrigger scripts", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 Trigger_ID      = fields[0].GetUInt32();
        const char *scriptName = fields[1].GetString();

        AreaTriggerEntry const* atEntry = sAreaTriggerStore.LookupEntry(Trigger_ID);
        if (!atEntry)
        {
            sLog.outLog(LOG_DB_ERR, "Area trigger (ID:%u) does not exist in `AreaTrigger.dbc`.",Trigger_ID);
            continue;
        }
        m_AreaTriggerScripts[Trigger_ID] = GetScriptId(scriptName);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u areatrigger scripts", count);
}

void ScriptMgr::LoadCompletedCinematicScripts()
{
    m_CompletedCinematicScripts.clear();                            // need for reload case
    QueryResult* result = GameDataDatabase.Query("SELECT entry, ScriptName FROM completed_cinematic_scripts");

    uint32 count = 0;

    if (!result)
    {
        BarGoLink bar(1);
        bar.step();

        sLog.outString();
        sLog.outString(">> Loaded %u after completed cinematic scripts", count);
        return;
    }

    BarGoLink bar(result->GetRowCount());

    do
    {
        ++count;
        bar.step();

        Field *fields = result->Fetch();

        uint32 Cinematic_ID    = fields[0].GetUInt32();
        const char *scriptName = fields[1].GetString();

        CinematicSequencesEntry const* cinematic = sCinematicSequencesStore.LookupEntry(Cinematic_ID);
        if (!cinematic)
        {
            sLog.outLog(LOG_DB_ERR, "Cinematic sequence (ID:%u) does not exist in `CinematicSequeces.dbc`.",Cinematic_ID);
            continue;
        }
        m_CompletedCinematicScripts[Cinematic_ID] = GetScriptId(scriptName);
    } while (result->NextRow());

    sLog.outString();
    sLog.outString(">> Loaded %u after completed cinematic scripts", count);
}


CreatureAI* ScriptMgr::GetAI(Creature* pCreature)
{
    // used by eluna
    if (CreatureAI* luaAI = sHookMgr->GetAI(pCreature))
        return luaAI;

    Script* tmpscript = m_scripts[pCreature->GetScriptId()];
    if (!tmpscript || !tmpscript->GetAI) return NULL;

    return tmpscript->GetAI(pCreature);

}


//bool ScriptMgr::OnChat(Player* pPlayer, uint32 type, uint32 lang, std::string& msg)
//{
//	return m_pOnChat != NULL && m_pOnChat(pPlayer, type, lang, msg);
//}

//bool ScriptMgr::OnGossipHello(Player* pPlayer, Creature* pCreature)
//{
//    // used by eluna
//    if (sHookMgr->OnGossipHello(pPlayer, pCreature))
//        return true;
//
//    return m_pOnGossipHello != NULL && m_pOnGossipHello(pPlayer, pCreature);
//}

//bool ScriptMgr::OnGossipSelect(Player* pPlayer, Creature* pCreature, uint32 sender, uint32 action, const char* code)
//{
//    if (code)
//    {
//        // used by eluna
//        if (sHookMgr->OnGossipSelectCode(pPlayer, pCreature, sender, action, code))
//            return true;
//    }
//    else
//        // used by eluna
//        if (sHookMgr->OnGossipSelect(pPlayer, pCreature, sender, action))
//            return true;
//
//    if (code)
//        return m_pOnGossipSelectWithCode != NULL && m_pOnGossipSelectWithCode(pPlayer, pCreature, sender, action, code);
//    else
//        return m_pOnGossipSelect != NULL && m_pOnGossipSelect(pPlayer, pCreature, sender, action);
//}
//
//bool ScriptMgr::OnGossipSelect(Player* pPlayer, GameObject* pGameObject, uint32 sender, uint32 action, const char* code)
//{
//    if (code)
//    {
//        // used by eluna
//        if (sHookMgr->OnGossipSelectCode(pPlayer, pGameObject, sender, action, code))
//            return true;
//    }
//    else
//        // used by eluna
//        if (sHookMgr->OnGossipSelect(pPlayer, pGameObject, sender, action))
//            return true;
//
//    if (code)
//        return m_pOnGOGossipSelectWithCode != NULL && m_pOnGOGossipSelectWithCode(pPlayer, pGameObject, sender, action, code);
//    else
//        return m_pOnGOGossipSelect != NULL && m_pOnGOGossipSelect(pPlayer, pGameObject, sender, action);
//}
//
//
//bool ScriptMgr::OnGossipSelect(Player* pPlayer, Item* pItem, uint32 sender, uint32 action, const char* code)
//{
//	if (code)
//		return m_pOnITEMGossipSelectWithCode != NULL && m_pOnITEMGossipSelectWithCode(pPlayer, pItem, sender, action, code);
//	else
//		return m_pOnITEMGossipSelect != NULL && m_pOnITEMGossipSelect(pPlayer, pItem, sender, action);
//}

//bool ScriptMgr::OnQuestAccept(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
//{
//    // used by eluna
//    if (sHookMgr->OnQuestAccept(pPlayer, pCreature, pQuest))
//        return true;
//
//    return m_pOnQuestAccept != NULL && m_pOnQuestAccept(pPlayer, pCreature, pQuest);
//}
//
//bool ScriptMgr::OnQuestAccept(Player* pPlayer, GameObject* pGameObject, Quest const* pQuest)
//{
//    if (sHookMgr->OnQuestAccept(pPlayer, pGameObject, pQuest))
//        return true;
//
//    return m_pOnGOQuestAccept != NULL && m_pOnGOQuestAccept(pPlayer, pGameObject, pQuest);
//}
//
//bool ScriptMgr::OnQuestAccept(Player* pPlayer, Item* pItem, Quest const* pQuest)
//{
//    // used by eluna
//    if(sHookMgr->OnQuestAccept(pPlayer, pItem, pQuest))
//        return true;
//
//    return m_pOnItemQuestAccept != NULL && m_pOnItemQuestAccept(pPlayer, pItem, pQuest);
//}

//bool ScriptMgr::OnQuestRewarded(Player* pPlayer, Creature* pCreature, Quest const* pQuest)
//{
//    // used by eluna
//    if (sHookMgr->OnQuestReward(pPlayer, pCreature, pQuest))
//        return true;
//
//    return m_pOnQuestRewarded != NULL && m_pOnQuestRewarded(pPlayer, pCreature, pQuest);
//}
//
//bool ScriptMgr::OnQuestRewarded(Player* pPlayer, GameObject* pGameObject, Quest const* pQuest)
//{
//    // used by eluna
//    if (sHookMgr->OnQuestReward(pPlayer, pGameObject, pQuest))
//        return true;
//
//    return m_pOnGOQuestRewarded != NULL && m_pOnGOQuestRewarded(pPlayer, pGameObject, pQuest);
//}

//uint32 ScriptMgr::GetDialogStatus(Player* pPlayer, Creature* pCreature)
//{
//    // used by eluna
//    if (uint32 dialogId = sHookMgr->GetDialogStatus(pPlayer, pCreature))
//        return dialogId;
//
//    if (!m_pGetNPCDialogStatus)
//        return 100;
//
//    return m_pGetNPCDialogStatus(pPlayer, pCreature);
//}
//
//uint32 ScriptMgr::GetDialogStatus(Player* pPlayer, GameObject* pGameObject)
//{
//    // used by eluna
//    if (uint32 dialogId = sHookMgr->GetDialogStatus(pPlayer, pGameObject))
//        return dialogId;
//
//    if (!m_pGetGODialogStatus)
//        return 100;
//
//    return m_pGetGODialogStatus(pPlayer, pGameObject);
//}

//bool ScriptMgr::OnGameObjectUse(Player* pPlayer, GameObject* pGameObject)
//{
//    // used by eluna
//    if (sHookMgr->OnGameObjectUse(pPlayer, pGameObject))
//        return true;
//
//    return m_pOnGOUse != NULL && m_pOnGOUse(pPlayer, pGameObject);
//}

//bool ScriptMgr::OnItemUse(Player* pPlayer, Item* pItem, SpellCastTargets const& targets)
//{
//    // used by eluna
//    if(sHookMgr->OnUse(pPlayer, pItem, targets))
//        return true;
//
//    return m_pOnItemUse != NULL && m_pOnItemUse(pPlayer, pItem, targets);
//}

//bool ScriptMgr::OnAreaTrigger(Player* pPlayer, AreaTriggerEntry const* atEntry)
//{
//    // used by eluna
//    if(sHookMgr->OnAreaTrigger(pPlayer, atEntry))
//        return true;
//
//    return m_pOnAreaTrigger != NULL && m_pOnAreaTrigger(pPlayer, atEntry);
//}
//
//bool ScriptMgr::OnCompletedCinematic(Player* pPlayer, CinematicSequencesEntry const* cinematic)
//{
//    return m_pOnCompletedCinematic != NULL && m_pOnCompletedCinematic(pPlayer, cinematic);
//}
//
//bool ScriptMgr::OnProcessEvent(uint32 eventId, Object* pSource, Object* pTarget, bool isStart)
//{
//    return m_pOnProcessEvent != NULL && m_pOnProcessEvent(eventId, pSource, pTarget, isStart);
//}

//bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Creature* pTarget)
//{
//    // used by eluna
//    if(sHookMgr->OnDummyEffect(pCaster, spellId, effIndex, pTarget))
//        return true;
//
//    return m_pOnEffectDummyCreature != NULL && m_pOnEffectDummyCreature(pCaster, spellId, effIndex, pTarget);
//}
//
//bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, GameObject* pTarget)
//{
//    // used by eluna
//    if(sHookMgr->OnDummyEffect(pCaster, spellId, effIndex, pTarget))
//        return true;
//
//    return m_pOnEffectDummyGO != NULL && m_pOnEffectDummyGO(pCaster, spellId, effIndex, pTarget);
//}
//
//bool ScriptMgr::OnEffectDummy(Unit* pCaster, uint32 spellId, uint32 effIndex, Item* pTarget)
//{
//    // used by eluna
//    if(sHookMgr->OnDummyEffect(pCaster, spellId, effIndex, pTarget))
//        return true;
//
//    return m_pOnEffectDummyItem != NULL && m_pOnEffectDummyItem(pCaster, spellId, effIndex, pTarget);
//}
//
//bool ScriptMgr::OnAuraDummy(Aura const* pAura, bool apply)
//{
//    return m_pOnAuraDummy != NULL && m_pOnAuraDummy(pAura, apply);
//}
//
//bool ScriptMgr::OnReceiveEmote(Player *pPlayer, Creature *pCreature, uint32 emote)
//{
//    return m_pOnReceiveEmote != NULL && m_pOnReceiveEmote(pPlayer, pCreature, emote);
//}
//
//bool ScriptMgr::OnPVPKill(Player *pKiller, Player *pKilled)
//{
//	return m_pOnPVPKill != NULL && m_pOnPVPKill(pKiller, pKilled);
//}
//
//bool ScriptMgr::OnCreatureKill(Player *pKiller, Creature *cKilled)
//{
//
//	return m_pOnCreatureKill != NULL && m_pOnCreatureKill(pKiller, cKilled);
//}
//
//// spell scripts
//bool ScriptMgr::OnSpellSetTargetMap(Unit* pCaster, std::list<Unit*> &unitList, SpellCastTargets const& targets, SpellEntry const *pSpell, uint32 effectIndex)
//{
//    return m_pOnSpellSetTargetMap != NULL && m_pOnSpellSetTargetMap(pCaster, unitList, targets, pSpell, effectIndex);
//}
//
//bool ScriptMgr::OnSpellHandleEffect(Unit *pCaster, Unit* pUnit, Item* pItem, GameObject* pGameObject, SpellEntry const *pSpell, uint32 effectIndex)
//{
//    return m_pOnSpellHandleEffect != NULL && m_pOnSpellHandleEffect(pCaster, pUnit, pItem, pGameObject, pSpell, effectIndex);
//}

//bool ScriptMgr::LoadScriptLibrary(const char* libName)
//{
//    UnloadScriptLibrary();
//
//    std::string name = libName;
//    name = LOOKING4GROUP_SCRIPT_PREFIX + name + LOOKING4GROUP_SCRIPT_SUFFIX;
//
//    m_hScriptLib = LOOKING4GROUP_LOAD_LIBRARY(name.c_str());
//
//    if (!m_hScriptLib)
//        return false;
//
//    GetScriptHookPtr(m_pOnInitScriptLibrary,        "InitScriptLibrary");
//    GetScriptHookPtr(m_pOnFreeScriptLibrary,        "FreeScriptLibrary");
//    GetScriptHookPtr(m_pGetScriptLibraryVersion,    "GetScriptLibraryVersion");
//
//    GetScriptHookPtr(m_pGetCreatureAI,              "GetCreatureAI");
//    GetScriptHookPtr(m_pCreateInstanceData,         "CreateInstanceData");
//
//	GetScriptHookPtr(m_pOnChat,                     "OnChat");	
//    GetScriptHookPtr(m_pOnGossipHello,              "GossipHello");
//    GetScriptHookPtr(m_pOnGossipSelect,             "GossipSelect");
//    GetScriptHookPtr(m_pOnGOGossipSelect,           "GOGossipSelect");
//	GetScriptHookPtr(m_pOnITEMGossipSelect,         "ITEMGossipSelect");
//    GetScriptHookPtr(m_pOnGossipSelectWithCode,     "GossipSelectWithCode");
//    GetScriptHookPtr(m_pOnGOGossipSelectWithCode,   "GOGossipSelectWithCode");
//	GetScriptHookPtr(m_pOnITEMGossipSelectWithCode, "ITEMGossipSelectWithCode");
//    GetScriptHookPtr(m_pOnQuestAccept,              "QuestAccept");
//    GetScriptHookPtr(m_pOnGOQuestAccept,            "GOQuestAccept");
//    GetScriptHookPtr(m_pOnItemQuestAccept,          "ItemQuestAccept");
//    GetScriptHookPtr(m_pOnQuestRewarded,            "QuestRewarded");
//    GetScriptHookPtr(m_pOnGOQuestRewarded,          "GOQuestRewarded");
//    GetScriptHookPtr(m_pGetNPCDialogStatus,         "GetNPCDialogStatus");
//    GetScriptHookPtr(m_pGetGODialogStatus,          "GetGODialogStatus");
//    GetScriptHookPtr(m_pOnGOUse,                    "GOUse");
//    GetScriptHookPtr(m_pOnItemUse,                  "ItemUse");
//    GetScriptHookPtr(m_pOnAreaTrigger,              "AreaTrigger");
//    GetScriptHookPtr(m_pOnCompletedCinematic,       "CompletedCinematic");
//    GetScriptHookPtr(m_pOnProcessEvent,             "ProcessEvent");
//    GetScriptHookPtr(m_pOnEffectDummyCreature,      "EffectDummyCreature");
//    GetScriptHookPtr(m_pOnEffectDummyGO,            "EffectDummyGameObject");
//    GetScriptHookPtr(m_pOnEffectDummyItem,          "EffectDummyItem");
//    GetScriptHookPtr(m_pOnAuraDummy,                "AuraDummy");
//
//    GetScriptHookPtr(m_pOnReceiveEmote,             "ReceiveEmote");
//	GetScriptHookPtr(m_pOnPVPKill,                  "PVPKill");
//	GetScriptHookPtr(m_pOnCreatureKill,             "CreatureKill");
//    // spell scripts
//    GetScriptHookPtr(m_pOnSpellSetTargetMap,         "SpellSetTargetMap");
//    GetScriptHookPtr(m_pOnSpellHandleEffect,         "SpellHandleEffect");
//
//
//    if (m_pOnInitScriptLibrary)
//        m_pOnInitScriptLibrary(sConfig.GetFilename().c_str());
//
//    if (m_pGetScriptLibraryVersion)
//        sWorld.SetScriptsVersion(m_pGetScriptLibraryVersion());
//
//    return true;
//}
//
//void ScriptMgr::UnloadScriptLibrary()
//{
//    if (!m_hScriptLib)
//        return;
//
//    if (m_pOnFreeScriptLibrary)
//        m_pOnFreeScriptLibrary();
//
//    LOOKING4GROUP_CLOSE_LIBRARY(m_hScriptLib);
//    m_hScriptLib = NULL;
//
//    m_pOnInitScriptLibrary      = NULL;
//    m_pOnFreeScriptLibrary      = NULL;
//    m_pGetScriptLibraryVersion  = NULL;
//
//    m_pGetCreatureAI            = NULL;
//    m_pCreateInstanceData       = NULL;
//
//	m_pOnChat                   = NULL;
//    m_pOnGossipHello            = NULL;
//    m_pOnGossipSelect           = NULL;
//    m_pOnGOGossipSelect         = NULL;
//	m_pOnITEMGossipSelect       = NULL;
//    m_pOnGossipSelectWithCode   = NULL;
//    m_pOnGOGossipSelectWithCode = NULL;
//	m_pOnITEMGossipSelectWithCode = NULL;
//    m_pOnQuestAccept            = NULL;
//    m_pOnGOQuestAccept          = NULL;
//    m_pOnItemQuestAccept        = NULL;
//    m_pOnQuestRewarded          = NULL;
//    m_pOnGOQuestRewarded        = NULL;
//    m_pGetNPCDialogStatus       = NULL;
//    m_pGetGODialogStatus        = NULL;
//    m_pOnGOUse                  = NULL;
//    m_pOnItemUse                = NULL;
//    m_pOnAreaTrigger            = NULL;
//    m_pOnCompletedCinematic     = NULL;
//    m_pOnProcessEvent           = NULL;
//    m_pOnEffectDummyCreature    = NULL;
//    m_pOnEffectDummyGO          = NULL;
//    m_pOnEffectDummyItem        = NULL;
//    m_pOnAuraDummy              = NULL;
//	m_pOnPVPKill                = NULL;
//	m_pOnCreatureKill           = NULL;
//}

uint32 ScriptMgr::GetEventIdScriptId(uint32 eventId) const
{
    EventIdScriptMap::const_iterator itr = m_EventIdScripts.find(eventId);
    if (itr != m_EventIdScripts.end())
        return itr->second;

    return 0;
}

uint32 ScriptMgr::GetSpellIdScriptId(uint32 eventId) const
{
    SpellIdScriptMap::const_iterator itr = m_SpellIdScripts.find(eventId);
    if (itr != m_SpellIdScripts.end())
        return itr->second;

    return 0;
}

uint32 ScriptMgr::GetScriptId(const char *name)
{
    // use binary search to find the script name in the sorted vector
    // assume "" is the first element
    if (!name) return 0;
    ScriptNameMap::const_iterator itr =
        std::lower_bound(m_scriptNames.begin(), m_scriptNames.end(), name);
    if (itr == m_scriptNames.end() || *itr != name) return 0;
    return itr - m_scriptNames.begin();
}

uint32 ScriptMgr::GetAreaTriggerScriptId(uint32 trigger_id) const
{
    AreaTriggerScriptMap::const_iterator i = m_AreaTriggerScripts.find(trigger_id);
    if (i!= m_AreaTriggerScripts.end())
        return i->second;
    return 0;
}

uint32 ScriptMgr::GetCompletedCinematicScriptId(uint32 cinematic_id) const
{
    CompletedCinematicScriptMap::const_iterator i = m_CompletedCinematicScripts.find(cinematic_id);
    if (i!= m_CompletedCinematicScripts.end())
        return i->second;
    return 0;
}

uint32 GetEventIdScriptId(uint32 eventId)
{
    return sScriptMgr.GetEventIdScriptId(eventId);
}

uint32 GetSpellIdScriptId(uint32 eventId)
{
    return sScriptMgr.GetSpellIdScriptId(eventId);
}

// Functions for scripting access
uint32 GetAreaTriggerScriptId(uint32 trigger_id)
{
    return sScriptMgr.GetAreaTriggerScriptId(trigger_id);
}

uint32 GetCompletedCinematicScriptId(uint32 cinematic_id)
{
    return sScriptMgr.GetCompletedCinematicScriptId(cinematic_id);
}

uint32 GetScriptId(const char *name)
{
    return sScriptMgr.GetScriptId(name);
}
