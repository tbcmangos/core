/*
* Copyright (C) 2010 - 2014 Eluna Lua Engine <http://emudevs.com/>
* This program is free software licensed under GPL version 3
* Please see the included DOCS/LICENSE.TXT for more information
*/

#ifndef UNITMETHODS_H
#define UNITMETHODS_H

namespace LuaUnit
{
    int Attack(lua_State* L, Unit* unit)
    {
        Unit* who = sEluna->CHECKOBJ<Unit>(L, 2);
        bool meleeAttack = sEluna->CHECKVAL<bool>(L, 3, false);

        sEluna->Push(L, unit->Attack(who, meleeAttack));
        return 1;
    }

    int ClearThreatList(lua_State* L, Unit* unit)
    {
        unit->getThreatManager().clearReferences();
        return 0;
    }

    int SetOwnerGUID(lua_State* L, Unit* unit)
    {
        uint64 guid = sEluna->CHECKVAL<uint64>(L, 2);

        unit->SetOwnerGUID(uint64(guid));
        return 0;
    }

    int GetOwner(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetOwner());
        return 1;
    }

    int GetOwnerGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetOwnerGUID());
        return 1;
    }

    int GetMap(lua_State* L, Unit* unit)
    {
        Map* map = unit->GetMap();
        sEluna->Push(L, map);
        return 1;
    }

    int Mount(lua_State* L, Unit* unit)
    {
        uint32 displayId = sEluna->CHECKVAL<uint32>(L, 2);

        unit->Mount(displayId);
        return 0;
    }

    int Dismount(lua_State* L, Unit* unit)
    {
        if (unit->IsMounted())
        {
            unit->Unmount();
            unit->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);
        }

        return 0;
    }

    int IsMounted(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsMounted());
        return 1;
    }

    int IsWithinLoS(lua_State* L, Unit* unit)
    {
        float x = sEluna->CHECKVAL<float>(L, 2);
        float y = sEluna->CHECKVAL<float>(L, 3);
        float z = sEluna->CHECKVAL<float>(L, 4);

        sEluna->Push(L, unit->IsWithinLOS(x, y, z));
        return 1;
    }

    int IsRooted(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isInRoots() || unit->hasUnitState(UNIT_STAT_ROOT));
        return 1;
    }

    int IsFullHealth(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetHealth() == unit->GetMaxHealth());
        return 1;
    }

    int IsWithinDistInMap(lua_State* L, Unit* unit)
    {
        WorldObject* obj = sEluna->CHECKOBJ<WorldObject>(L, 2);
        float radius = sEluna->CHECKVAL<float>(L, 3);

        sEluna->Push(L, unit->IsWithinDistInMap(obj, radius));
        return 1;
    }

    int IsInAccessiblePlaceFor(lua_State* L, Unit* unit)
    {
        Creature* creature = sEluna->CHECKOBJ<Creature>(L, 2);

        sEluna->Push(L, unit->isInAccessiblePlacefor(creature));
        return 1;
    }

    int GetMountId(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetMountID());
        return 1;
    }

    int GetDistance(lua_State* L, Unit* unit)
    {
        WorldObject* obj = sEluna->CHECKOBJ<WorldObject>(L, 2, false);
        if (obj && obj->IsInWorld())
            sEluna->Push(L, unit->GetDistance(obj));
        else
        {
            float X = sEluna->CHECKVAL<float>(L, 2);
            float Y = sEluna->CHECKVAL<float>(L, 3);
            float Z = sEluna->CHECKVAL<float>(L, 4);
            sEluna->Push(L, unit->GetDistance(X, Y, Z));
        }
        return 1;
    }

    int GetCreatorGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCreatorGUID());
        return 1;
    }

    int GetMinionGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetPetGUID());
        return 1;
    }

    int GetCharmerGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCharmerGUID());
        return 1;
    }

    int GetCharmGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCharmGUID());
        return 1;
    }

    int GetPetGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetPetGUID());
        return 1;
    }

    int GetControllerGUID(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCharmerOrOwnerGUID());
        return 1;
    }

    int GetControllerGUIDS(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCharmerOrOwnerOrOwnGUID());
        return 1;
    }

    int GetStat(lua_State* L, Unit* unit)
    {
        uint32 stat = sEluna->CHECKVAL<uint32>(L, 2);

        if (stat >= MAX_STATS)
            return 0;

        sEluna->Push(L, unit->GetStat((Stats)stat));
        return 1;
    }

    int GetBaseSpellPower(lua_State* L, Unit* unit)
    {
        uint32 spellschool = sEluna->CHECKVAL<uint32>(L, 2);

        if (spellschool >= MAX_SPELL_SCHOOL)
            return 0;

        sEluna->Push(L, unit->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + spellschool));
        return 1;
    }

    int SetPvP(lua_State* L, Unit* unit)
    {
        bool apply = sEluna->CHECKVAL<bool>(L, 2, true);

        unit->SetPvP(apply);
        return 0;
    }

    int IsAuctioneer(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isAuctioner());
        return 1;
    }

    int IsGuildMaster(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isGuildMaster());
        return 1;
    }

    int IsInnkeeper(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isInnkeeper());
        return 1;
    }

    int IsTrainer(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isTrainer());
        return 1;
    }

    int IsGossip(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isGossip());
        return 1;
    }

    int IsTaxi(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isTaxi());
        return 1;
    }

    int IsSpiritHealer(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isSpiritHealer());
        return 1;
    }

    int IsSpiritGuide(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isSpiritGuide());
        return 1;
    }

    int IsTabardDesigner(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isTabardDesigner());
        return 1;
    }

    int IsServiceProvider(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isServiceProvider());
        return 1;
    }

    int IsSpiritService(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isSpiritService());
        return 1;
    }

    int HealthBelowPct(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->HealthBelowPct(sEluna->CHECKVAL<int32>(L, 2)));
        return 1;
    }

    int HealthAbovePct(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, !unit->HealthBelowPct(sEluna->CHECKVAL<int32>(L, 2)));
        return 1;
    }

    int Emote(lua_State* L, Unit* unit)
    {
        unit->HandleEmoteCommand(sEluna->CHECKVAL<uint32>(L, 2));
        return 0;
    }

    int IsUnderWater(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsUnderWater());
        return 1;
    }

    int IsInWater(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsInWater());
        return 1;
    }

    int GetVictim(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getVictim());
        return 1;
    }

    int SendChatMessageToPlayer(lua_State* L, Unit* unit)
    {
        uint8 type = sEluna->CHECKVAL<uint8>(L, 2);
        uint32 lang = sEluna->CHECKVAL<uint32>(L, 3);
        const char* msg = sEluna->CHECKVAL<const char*>(L, 4);
        Player* target = sEluna->CHECKOBJ<Player>(L, 5);
        if (type == CHAT_MSG_CHANNEL)
            return 0;

        WorldPacket* data = new WorldPacket();
        uint32 messageLength = (uint32)strlen(msg) + 1;
        data->Initialize(SMSG_MESSAGECHAT, 100);
        *data << (uint8)type;
        *data << lang;
        *data << unit->GetGUIDLow();
        *data << uint32(0);
        *data << unit->GetGUIDLow();
        *data << messageLength;
        *data << msg;
        if (unit->ToPlayer() && type != CHAT_MSG_WHISPER_INFORM && type != CHAT_MSG_DND && type != CHAT_MSG_AFK)
            *data << uint8(unit->ToPlayer()->chatTag());
        else
            *data << uint8(0);
        target->GetSession()->SendPacket(data);
        return 0;
    }

    int GetCurrentSpell(lua_State* L, Unit* unit)
    {
        uint32 type = sEluna->CHECKVAL<uint32>(L, 2);
        if (type >= CURRENT_MAX_SPELL)
            return luaL_argerror(L, 2, "valid CurrentSpellTypes expected");
        sEluna->Push(L, unit->GetCurrentSpell(CurrentSpellTypes(type)));
        return 1;
    }

    int GetStandState(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getStandState());
        return 0;
    }

    static void PrepareMove(Unit* unit)
    {
        unit->GetMotionMaster()->MovementExpired(); // Chase
        unit->StopMoving(); // Some
        unit->GetMotionMaster()->Clear(); // all
    }

    int MoveStop(lua_State* L, Unit* unit)
    {
        unit->StopMoving();
        return 0;
    }

    int MoveExpire(lua_State* L, Unit* unit)
    {
        bool reset = sEluna->CHECKVAL<bool>(L, 2, true);
        unit->GetMotionMaster()->MovementExpired(reset);
        return 0;
    }

    int MoveClear(lua_State* L, Unit* unit)
    {
        bool reset = sEluna->CHECKVAL<bool>(L, 2, true);
        unit->GetMotionMaster()->Clear(reset);
        return 0;
    }

    int MoveIdle(lua_State* L, Unit* unit)
    {
        // PrepareMove(unit);
        unit->GetMotionMaster()->MoveIdle();
        return 0;
    }

    int MoveRandom(lua_State* L, Unit* unit)
    {
        float radius = sEluna->CHECKVAL<float>(L, 2);
        // PrepareMove(unit);
        float x, y, z;
        unit->GetPosition(x, y, z);
        unit->GetMotionMaster()->MoveRandom(radius);
        return 0;
    }

    int MoveHome(lua_State* L, Unit* unit)
    {
        // PrepareMove(unit);
        unit->GetMotionMaster()->MoveTargetedHome();
        return 0;
    }

    int MoveFollow(lua_State* L, Unit* unit)
    {
        Unit* target = sEluna->CHECKOBJ<Unit>(L, 2);
        float dist = sEluna->CHECKVAL<float>(L, 3, 0.0f);
        float angle = sEluna->CHECKVAL<float>(L, 4, 0.0f);
        // PrepareMove(unit);
        unit->GetMotionMaster()->MoveFollow(target, dist, angle);
        return 0;
    }

    int MoveChase(lua_State* L, Unit* unit)
    {
        Unit* target = sEluna->CHECKOBJ<Unit>(L, 2);
        float dist = sEluna->CHECKVAL<float>(L, 3, 0.0f);
        float angle = sEluna->CHECKVAL<float>(L, 4, 0.0f);
        // PrepareMove(unit);
        unit->GetMotionMaster()->MoveChase(target, dist, angle);
        return 0;
    }

    int MoveConfused(lua_State* L, Unit* unit)
    {
        // PrepareMove(unit);
        unit->GetMotionMaster()->MoveConfused();
        return 0;
    }

    int MoveFleeing(lua_State* L, Unit* unit)
    {
        Unit* target = sEluna->CHECKOBJ<Unit>(L, 2);
        uint32 time = sEluna->CHECKVAL<uint32>(L, 3, 0);
        // PrepareMove(unit);
        unit->GetMotionMaster()->MoveFleeing(target, time);
        return 0;
    }

    int MoveTo(lua_State* L, Unit* unit)
    {
        uint32 id = sEluna->CHECKVAL<uint32>(L, 2);
        float x = sEluna->CHECKVAL<float>(L, 3);
        float y = sEluna->CHECKVAL<float>(L, 4);
        float z = sEluna->CHECKVAL<float>(L, 5);
        bool genPath = sEluna->CHECKVAL<bool>(L, 6, true);
        // PrepareMove(unit);
        unit->GetMotionMaster()->MovePoint(id, x, y, z, genPath);
        return 0;
    }

    int SetName(lua_State* L, Unit* unit)
    {
        const char* name = sEluna->CHECKVAL<const char*>(L, 2);
        if (std::string(name).length() > 0)
            unit->SetName(name);
        return 0;
    }

    int SetStunned(lua_State* L, Unit* unit)
    {
        bool apply = sEluna->CHECKVAL<bool>(L, 2, true);
        
        unit->SetStunned(apply);
        return 0;
    }

    int SetRooted(lua_State* L, Unit* unit)
    {
        bool apply = sEluna->CHECKVAL<bool>(L, 2, true);
        unit->SetRooted(apply);
        return 0;
    }

    int SetConfused(lua_State* L, Unit* unit)
    {
        bool apply = sEluna->CHECKVAL<bool>(L, 2, true);
        unit->SetConfused(apply);
        return 0;
    }

    int SetFeared(lua_State* L, Unit* unit)
    {
        bool apply = sEluna->CHECKVAL<bool>(L, 2, true);
        unit->SetFeared(apply, nullptr);
        return 0;
    }

    int SetSpeed(lua_State* L, Unit* unit)
    {
        uint32 type = sEluna->CHECKVAL<uint32>(L, 2);
        float rate = sEluna->CHECKVAL<float>(L, 3);
        bool forced = sEluna->CHECKVAL<bool>(L, 4, false);
        if (type >= MAX_MOVE_TYPE)
            return luaL_argerror(L, 2, "valid UnitMoveType expected");
        unit->SetSpeed((UnitMoveType)type, rate, forced);
        return 0;
    }

    int GetDisplayId(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetDisplayId());
        return 1;
    }

    int GetNativeDisplayId(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetNativeDisplayId());
        return 1;
    }

    int GetLevel(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getLevel());
        return 1;
    }

    int GetHealth(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetHealth());
        return 1;
    }

    int GetPower(lua_State* L, Unit* unit)
    {
        int type = sEluna->CHECKVAL<int>(L, 2, -1);
        if (type == -1)
        {

            switch (unit->getClass())
            {
            case 1:
                type = POWER_RAGE;
                break;
            case 4:
                type = POWER_ENERGY;
                break;
            case 2:
            case 3:
            case 5:
            case 7:
            case 8:
            case 9:
            case 11:
                type = POWER_MANA;
                break;
            default:
                type = POWER_MANA;
            }
        }
        else if (type < 0 || type >= 12)
            return luaL_argerror(L, 2, "valid Powers expected");

        sEluna->Push(L, unit->GetPower((Powers) type));
        return 1;
    }

    int GetMaxPower(lua_State* L, Unit* unit)
    {
        int type = sEluna->CHECKVAL<int>(L, 2, -1);
        if (type == -1)
        {

            switch (unit->getClass())
            {
            case 1:
                type = POWER_RAGE;
                break;
            case 4:
                type = POWER_ENERGY;
                break;
            case 2:
            case 3:
            case 5:
            case 7:
            case 8:
            case 9:
            case 11:
                type = POWER_MANA;
                break;
            default:
                type = POWER_MANA;
            }
        }
        else if (type < 0 || type >= 12)
            return luaL_argerror(L, 2, "valid Powers expected");

        sEluna->Push(L, unit->GetMaxPower((Powers) type));
        return 1;
    }

    int GetPowerType(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getPowerType());
        return 1;
    }

    int GetMaxHealth(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetMaxHealth());
        return 1;
    }

    int GetHealthPct(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetHealth()/unit->GetMaxHealth() * 100.0f);
        return 1;
    }

    int GetPowerPct(lua_State* L, Unit* unit)
    {
        float percent = (unit->GetPower(unit->getPowerType()) / unit->GetMaxPower(unit->getPowerType())) * 100;
        sEluna->Push(L, percent);
        return 1;
    }

    int GetGender(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getGender());
        return 1;
    }

    int GetRace(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getRace());
        return 1;
    }

    int GetClass(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getClass());
        return 1;
    }

    int GetCreatureType(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCreatureType());
        return 1;
    }

    int GetClassAsString(lua_State* L, Unit* unit)
    {
        const char* str = NULL;
        switch (unit->getClass())
        {
        case 1:
            str = "Warrior";
            break;
        case 2:
            str = "Paladin";
            break;
        case 3:
            str = "Hunter";
            break;
        case 4:
            str = "Rogue";
            break;
        case 5:
            str = "Priest";
            break;
        case 7:
            str = "Shaman";
            break;
        case 8:
            str = "Mage";
            break;
        case 9:
            str = "Warlock";
            break;
        case 11:
            str = "Druid";
            break;
        default:
            str = NULL;
            break;
        }

        sEluna->Push(L, str);
        return 1;
    }

    int GetFaction(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->getFaction());
        return 1;
    }

    int SetFaction(lua_State* L, Unit* unit)
    {
        uint32 factionId = sEluna->CHECKVAL<uint32>(L, 2);
        unit->setFaction(factionId);
        return 0;
    }

    int SetLevel(lua_State* L, Unit* unit)
    {
        uint32 newLevel = sEluna->CHECKVAL<uint32>(L, 2);
        unit->SetLevel(newLevel);
        return 0;
    }

    int SetHealth(lua_State* L, Unit* unit)
    {
        uint32 amt = sEluna->CHECKVAL<uint32>(L, 2);
        unit->SetHealth(amt);
        return 0;
    }

    int SetMaxHealth(lua_State* L, Unit* unit)
    {
        uint32 amt = sEluna->CHECKVAL<uint32>(L, 2);
        unit->SetMaxHealth(amt);
        return 0;
    }

    int SetPower(lua_State* L, Unit* unit)
    {
        int type = sEluna->CHECKVAL<int>(L, 2);
        uint32 amt = sEluna->CHECKVAL<uint32>(L, 3);

        switch (type)
        {
        case POWER_MANA:
            unit->SetPower(POWER_MANA, amt);
            break;
        case POWER_RAGE:
            unit->SetPower(POWER_RAGE, amt);
            break;
        case POWER_ENERGY:
            unit->SetPower(POWER_ENERGY, amt);
            break;
        default:
            return luaL_argerror(L, 2, "valid Powers expected");
            break;
        }
        return 0;
    }

    int SetMaxPower(lua_State* L, Unit* unit)
    {
        int type = sEluna->CHECKVAL<int>(L, 2);
        uint32 amt = sEluna->CHECKVAL<uint32>(L, 3);

        switch (type)
        {
        case POWER_MANA:
            unit->SetMaxPower(POWER_MANA, amt);
            break;
        case POWER_RAGE:
            unit->SetMaxPower(POWER_RAGE, amt);
            break;
        case POWER_ENERGY:
            unit->SetMaxPower(POWER_ENERGY, amt);
            break;
        default:
            return luaL_argerror(L, 2, "valid Powers expected");
            break;
        }
        return 0;
    }

    int SetDisplayId(lua_State* L, Unit* unit)
    {
        uint32 model = sEluna->CHECKVAL<uint32>(L, 2);
        unit->SetDisplayId(model);
        return 0;
    }

    int SetNativeDisplayId(lua_State* L, Unit* unit)
    {
        uint32 model = sEluna->CHECKVAL<uint32>(L, 2);
        unit->SetNativeDisplayId(model);
        return 0;
    }

    int SetFacing(lua_State* L, Unit* unit)
    {
        float o = sEluna->CHECKVAL<float>(L, 2);
        unit->SetFacingTo(o);
        return 0;
    }

    int SetFacingToObject(lua_State* L, Unit* unit)
    {
        WorldObject* obj = sEluna->CHECKOBJ<WorldObject>(L, 2);
        unit->SetFacingToObject(obj);
        return 0;
    }

    int SetCreatorGUID(lua_State* L, Unit* unit)
    {
        uint64 guid = sEluna->CHECKVAL<uint64>(L, 2);
        unit->SetOwnerGUID(uint64(guid));
        return 0;
    }

    int SetCharmerGUID(lua_State* L, Unit* unit)
    {
        uint64 guid = sEluna->CHECKVAL<uint64>(L, 2);
        unit->SetCharmerGUID(uint64(guid));
        return 0;
    }

    int SetStandState(lua_State* L, Unit* unit)
    {
        uint8 state = sEluna->CHECKVAL<uint8>(L, 2);
        unit->SetStandState(state);
        return 0;
    }

    int IsAlive(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isAlive());
        return 1;
    }

    int IsDead(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isDead());
        return 1;
    }

    int IsDying(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isDying());
        return 1;
    }

    int IsBanker(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isBanker());
        return 1;
    }

    int IsVendor(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isVendor());
        return 1;
    }

    int IsBattleMaster(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isBattleMaster());
        return 1;
    }

    int IsCharmed(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isCharmed());
        return 1;
    }

    int IsArmorer(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isArmorer());
        return 1;
    }

    int IsAttackingPlayer(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isAttackingPlayer());
        return 1;
    }

    int IsInWorld(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsInWorld());
        return 1;
    }

    int IsPvPFlagged(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsPvP());
        return 1;
    }

    int IsInCombat(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isInCombat());
        return 1;
    }

    int SendUnitWhisper(lua_State* L, Unit* unit)
    {
        const char* msg = sEluna->CHECKVAL<const char*>(L, 2);
        Player* receiver = sEluna->CHECKOBJ<Player>(L, 3);
        bool bossWhisper = sEluna->CHECKVAL<bool>(L, 4, false);
        if (std::string(msg).length() > 0)
            unit->MonsterWhisper(msg, receiver->GetGUID(), bossWhisper);
        return 0;
    }

    int SendUnitEmote(lua_State* L, Unit* unit)
    {
        const char* msg = sEluna->CHECKVAL<const char*>(L, 2);
        Unit* receiver = sEluna->CHECKOBJ<Unit>(L, 3, false);
        bool bossEmote = sEluna->CHECKVAL<bool>(L, 4, false);
        if (std::string(msg).length() > 0)
            unit->MonsterTextEmote(msg, receiver->GetGUID(), bossEmote);
        return 0;
    }

    int SendUnitSay(lua_State* L, Unit* unit)
    {
        const char* msg = sEluna->CHECKVAL<const char*>(L, 2);
        uint32 language = sEluna->CHECKVAL<uint32>(L, 3);
        if (std::string(msg).length() > 0)
            unit->MonsterSay(msg, language, unit->GetGUID());
        return 0;
    }

    int SendUnitYell(lua_State* L, Unit* unit)
    {
        const char* msg = sEluna->CHECKVAL<const char*>(L, 2);
        uint32 language = sEluna->CHECKVAL<uint32>(L, 3);
        if (std::string(msg).length() > 0)
            unit->MonsterYell(msg, language, unit->GetGUID());
        return 0;
    }

    int DeMorph(lua_State* L, Unit* unit)
    {
        unit->DeMorph();
        return 0;
    }

    int CastSpell(lua_State* L, Unit* unit)
    {
        Unit* target = sEluna->CHECKOBJ<Unit>(L, 2);
        uint32 spell = sEluna->CHECKVAL<uint32>(L, 3);
        bool triggered = sEluna->CHECKVAL<bool>(L, 4, false);
        SpellEntry const* spellEntry = sSpellStore.LookupEntry(spell);
        if (!spellEntry)
            return 0;

        unit->CastSpell(target, spell, triggered);
        return 0;
    }

    int CastSpellAoF(lua_State* L, Unit* unit)
    {
        float _x = sEluna->CHECKVAL<float>(L, 2);
        float _y = sEluna->CHECKVAL<float>(L, 3);
        float _z = sEluna->CHECKVAL<float>(L, 4);
        uint32 spell = sEluna->CHECKVAL<uint32>(L, 5);
        bool triggered = sEluna->CHECKVAL<bool>(L, 6, true);
        unit->CastSpell(_x, _y, _z, spell, triggered);
        return 0;
    }

    int GetAura(lua_State* L, Unit* unit)
    {
        uint32 spellID = sEluna->CHECKVAL<uint32>(L, 2);
        sEluna->Push(L, unit->GetAura(spellID, 0));
        return 1;
    }

    int GetCombatTime(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->GetCombatTimer());
        return 1;
    }

    int ClearInCombat(lua_State* L, Unit* unit)
    {
        unit->ClearInCombat();
        return 0;
    }

    int StopSpellCast(lua_State* L, Unit* unit)
    {
        uint32 spellId = sEluna->CHECKVAL<uint32>(L, 2, 0);
        unit->CastStop(spellId);
        return 0;
    }

    int InterruptSpell(lua_State* L, Unit* unit)
    {
        int spellType = sEluna->CHECKVAL<int>(L, 2);
        bool delayed = sEluna->CHECKVAL<bool>(L, 3, true);
        switch (spellType)
        {
        case 0:
            spellType = CURRENT_MELEE_SPELL;
            break;
        case 1:
            spellType = CURRENT_GENERIC_SPELL;
            break;
        case 2:
            spellType = CURRENT_CHANNELED_SPELL;
            break;
        case 3:
            spellType = CURRENT_AUTOREPEAT_SPELL;
            break;
        }
        unit->InterruptSpell((CurrentSpellTypes)spellType, delayed);
        return 0;
    }

    int AddAura(lua_State* L, Unit* unit)
    {
        uint32 spellId = sEluna->CHECKVAL<uint32>(L, 2);
        Unit* target = sEluna->CHECKOBJ<Unit>(L, 3);
        SpellEntry const* spellInfo = sSpellStore.LookupEntry(spellId);
        if (!spellInfo)
            return 0;

        unit->AddAura(spellId, target);
        return 0;
    }

    int HasAura(lua_State* L, Unit* unit)
    {
        uint32 spell = sEluna->CHECKVAL<uint32>(L, 2);

        sEluna->Push(L, unit->HasAura(spell));
        return 1;
    }

    int IsStandState(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsStandState());
        return 1;
    }

    int RemoveAura(lua_State* L, Unit* unit)
    {
        uint32 spellId = sEluna->CHECKVAL<uint32>(L, 2);
        unit->RemoveAurasDueToSpell(spellId);
        return 0;
    }

    int RemoveAllAuras(lua_State* L, Unit* unit)
    {
        unit->RemoveAllAuras();
        return 0;
    }

    int PlayDirectSound(lua_State* L, Unit* unit)
    {
        uint32 soundId = sEluna->CHECKVAL<uint32>(L, 2);
        Player* player = sEluna->CHECKOBJ<Player>(L, 3, false);
        if (!sSoundEntriesStore.LookupEntry(soundId))
            return 0;

        if (player)
            unit->PlayDirectSound(soundId, player);
        else
            unit->PlayDirectSound(soundId);
        return 0;
    }

    int PlayDistanceSound(lua_State* L, Unit* unit)
    {
        uint32 soundId = sEluna->CHECKVAL<uint32>(L, 2);
        Player* player = sEluna->CHECKOBJ<Player>(L, 3, false);
        if (!sSoundEntriesStore.LookupEntry(soundId))
            return 0;

        if (player)
            unit->PlayDistanceSound(soundId, player);
        else
            unit->PlayDistanceSound(soundId);
        return 0;
    }

    int Kill(lua_State* L, Unit* unit)
    {
        Unit* target = sEluna->CHECKOBJ<Unit>(L, 2);
        bool durLoss = sEluna->CHECKVAL<bool>(L, 3, true);
        unit->Kill(target, durLoss);
        return 0;
    }

    int RegisterEvent(lua_State* L, Unit* unit)
    {
        luaL_checktype(L, 2, LUA_TFUNCTION);
        uint32 delay = sEluna->CHECKVAL<uint32>(L, 3);
        uint32 repeats = sEluna->CHECKVAL<uint32>(L, 4);

        lua_settop(L, 2);
        int functionRef = lua_ref(L, true);
        functionRef = sEluna->m_EventMgr.AddEvent(&unit->m_Events, functionRef, delay, repeats, unit);
        if (functionRef)
            sEluna->Push(L, functionRef);
        else
            sEluna->Push(L);
        return 1;
    }

    int RemoveEventById(lua_State* L, Unit* unit)
    {
        int eventId = sEluna->CHECKVAL<int>(L, 2);
        sEluna->m_EventMgr.RemoveEvent(&unit->m_Events, eventId);
        return 0;
    }

    int RemoveEvents(lua_State* L, Unit* unit)
    {
        sEluna->m_EventMgr.RemoveEvents(&unit->m_Events);
        return 0;
    }

    int GetFriendlyUnitsInRange(lua_State* L, Unit* unit)
    {
        float range = sEluna->CHECKVAL<float>(L, 2, SIZE_OF_GRIDS);

        std::list<Unit*> list;

        MaNGOS::AnyFriendlyUnitInObjectRangeCheck checker(unit, unit, range);
        MaNGOS::UnitListSearcher<MaNGOS::AnyFriendlyUnitInObjectRangeCheck> searcher(list, checker);
        Cell::VisitAllObjects(unit, searcher, range);

        Eluna::ObjectGUIDCheck guidCheck(unit->GetGUID());
        list.remove_if(guidCheck);

        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (std::list<Unit*>::const_iterator it = list.begin(); it != list.end(); ++it)
        {
            sEluna->Push(L, ++i);
            sEluna->Push(L, *it);
            lua_settable(L, tbl);
        }

        lua_settop(L, tbl);
        return 1;
    }

    int GetUnfriendlyUnitsInRange(lua_State* L, Unit* unit)
    {
        float range = sEluna->CHECKVAL<float>(L, 2, SIZE_OF_GRIDS);

        std::list<Unit*> list;

        MaNGOS::AnyUnfriendlyUnitInObjectRangeCheck checker(unit, unit, range);
        MaNGOS::UnitListSearcher<MaNGOS::AnyUnfriendlyUnitInObjectRangeCheck> searcher(list, checker);
         Cell::VisitAllObjects(unit, searcher, range);

        Eluna::ObjectGUIDCheck guidCheck(unit->GetGUID());
        list.remove_if(guidCheck);

        lua_newtable(L);
        int tbl = lua_gettop(L);
        uint32 i = 0;

        for (std::list<Unit*>::const_iterator it = list.begin(); it != list.end(); ++it)
        {
            sEluna->Push(L, ++i);
            sEluna->Push(L, *it);
            lua_settable(L, tbl);
        }

        lua_settop(L, tbl);
        return 1;
    }

    int AttackStop(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->AttackStop());
        return 1;
    }

    /*int SetCanFly(lua_State* L, Unit* unit)
    {
    bool apply = sEluna->CHECKVAL<bool>(L, 2, true);
    unit->SetCanFly(apply);
    return 0;
    }*/

    /*int SetVisible(lua_State* L, Unit* unit)
    {
    bool x = sEluna->CHECKVAL<bool>(L, 2, true);
    unit->SetVisible(x);
    return 0;
    }*/

    /*int IsVisible(lua_State* L, Unit* unit)
    {
    sEluna->Push(L, unit->IsVisible());
    return 1;
    }*/

    /*int IsMoving(lua_State* L, Unit* unit)
    {
    sEluna->Push(L, unit->isMoving());
    return 1;
    }*/

    /*int IsFlying(lua_State* L, Unit* unit)
    {
    sEluna->Push(L, unit->IsFlying());
    return 1;
    }*/

    int IsStopped(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->IsStopped());
        return 1;
    }

    int IsQuestGiver(lua_State* L, Unit* unit)
    {
        sEluna->Push(L, unit->isQuestGiver());
        return 1;
    }

    /*int RestoreDisplayId(lua_State* L, Unit* unit)
    {
    unit->RestoreDisplayId();
    return 0;
    }*/

    /*int RestoreFaction(lua_State* L, Unit* unit)
    {
    unit->RestoreFaction();
    return 0;
    }*/

    /*int RemoveBindSightAuras(lua_State* L, Unit* unit)
    {
    unit->RemoveBindSightAuras();
    return 0;
    }*/

    /*int RemoveCharmAuras(lua_State* L, Unit* unit)
    {
    unit->RemoveCharmAuras();
    return 0;
    }*/

    int AddUnitState(lua_State* L, Unit* unit)
    {
        uint32 state = sEluna->CHECKVAL<uint32>(L, 2);

        unit->addUnitState(state);
        return 0;
    }

    int ClearUnitState(lua_State* L, Unit* unit)
    {
        uint32 state = sEluna->CHECKVAL<uint32>(L, 2);
        
        unit->clearUnitState(state);
        return 0;
    }

    int HasUnitState(lua_State* L, Unit* unit)
    {
        uint32 state = sEluna->CHECKVAL<uint32>(L, 2);
        
        sEluna->Push(L, unit->hasUnitState(state));
        return 1;
    }

    int NearTeleport(lua_State* L, Unit* unit)
    {
        float x = sEluna->CHECKVAL<float>(L, 2);
        float y = sEluna->CHECKVAL<float>(L, 3);
        float z = sEluna->CHECKVAL<float>(L, 4);
        float o = sEluna->CHECKVAL<float>(L, 5);

        unit->NearTeleportTo(x, y, z, o);
        return 1;
    }

    /*int DisableMelee(lua_State* L, Unit* unit)
    {
    bool apply = sEluna->CHECKVAL<bool>(L, 2, true);

    if (apply)
    unit->AddUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
    else
    unit->ClearUnitState(UNIT_STATE_CANNOT_AUTOATTACK);
    return 0;
    }*/

    /*int SummonGuardian(lua_State* L, Unit* unit)
    {
    uint32 entry = sEluna->CHECKVAL<uint32>(L, 2);
    float x = sEluna->CHECKVAL<float>(L, 3);
    float y = sEluna->CHECKVAL<float>(L, 4);
    float z = sEluna->CHECKVAL<float>(L, 5);
    float o = sEluna->CHECKVAL<float>(L, 6);
    uint32 desp = sEluna->CHECKVAL<uint32>(L, 7, 0);

    SummonPropertiesEntry const* properties = sSummonPropertiesStore.LookupEntry(61);
    if (!properties)
    return 0;
    Position pos;
    pos.Relocate(x,y,z,o);
    TemporarySummon* summon = unit->GetMap()->SummonCreature(entry, pos, properties, desp, unit);

    if (!summon)
    return 0;

    if (summon->HasUnitTypeMask(UNIT_MASK_GUARDIAN))
    ((Guardian*)summon)->InitStatsForLevel(unit->getLevel());

    if (properties && properties->Category == SUMMON_CATEGORY_ALLY)
    summon->setFaction(unit->getFaction());
    if (summon->GetEntry() == 27893)
    {
    if (uint32 weapon = unit->GetUInt32Value(PLAYER_VISIBLE_ITEM_16_ENTRYID))
    {
    summon->SetDisplayId(11686);
    summon->SetUInt32Value(UNIT_VIRTUAL_ITEM_SLOT_ID, weapon);
    }
    else
    summon->SetDisplayId(1126);
    }
    summon->AI()->EnterEvadeMode();

    sEluna->Push(L, summon);
    return 1;
    }*/

};
#endif
