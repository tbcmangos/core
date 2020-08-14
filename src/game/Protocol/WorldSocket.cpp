/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2009-2011 MaNGOSZero <https://github.com/mangos/zero>
 * Copyright (C) 2011-2016 Nostalrius <https://nostalrius.org>
 * Copyright (C) 2016-2017 Elysium Project <https://github.com/elysium-project>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


#include "Auth/AuthCrypt.h"

#include "World.h"
#include "AccountMgr.h"
#include "SharedDefines.h"
#include "WorldSession.h"
#include "WorldSocket.h"
#include "WorldSocketMgr.h"
#include "AddonHandler.h"

#include "Opcodes.h"
#include "MangosSocketImpl.h"

template class MangosSocket<WorldSession, WorldSocket, AuthCrypt>;

int WorldSocket::ProcessIncoming(WorldPacket* new_pct)
{
    MANGOS_ASSERT(new_pct);

    // manage memory ;)
    ACE_Auto_Ptr<WorldPacket> aptr(new_pct);

    const ACE_UINT16 opcode = new_pct->GetOpcode();

    if (opcode >= NUM_MSG_TYPES)
    {
        sLog.outError("SESSION: received nonexistent opcode 0x%.4X", opcode);
        return -1;
    }

    if (closing_)
        return -1;

    new_pct->FillPacketTime(WorldTimer::getMSTime());

    // Dump received packet.
    sLog.outWorldPacketDump(get_handle(), new_pct->GetOpcode(),
                            LookupOpcodeName(new_pct->GetOpcode()), new_pct,
                            true);

    try
    {
        switch (opcode)
        {
            case CMSG_PING:
                return HandlePing(*new_pct);
            case CMSG_AUTH_SESSION:
                if (m_Session)
                {
                    sLog.outError("WorldSocket::ProcessIncoming: Player send CMSG_AUTH_SESSION again");
                    return -1;
                }

                return HandleAuthSession(*new_pct);
            default:
            {
                ACE_GUARD_RETURN(LockType, Guard, m_SessionLock, -1);

                if (m_Session != nullptr)
                {
                    // OK ,give the packet to WorldSession
                    aptr.release();
                    // WARNINIG here we call it with locks held.
                    // Its possible to cause deadlock if QueuePacket calls back
                    m_Session->QueuePacket(new_pct);
                    return 0;
                }
                else
                {
                    sLog.outError("WorldSocket::ProcessIncoming: Client not authed opcode = %u", uint32(opcode));
                    return -1;
                }
            }
        }
    }
    catch (ByteBufferException &)
    {
        sLog.outError("WorldSocket::ProcessIncoming ByteBufferException occured while parsing an instant handled packet (opcode: %u) from client %s, accountid=%i.",
                      opcode, GetRemoteAddress().c_str(), m_Session ? m_Session->GetAccountId() : -1);
        if (sLog.HasLogLevelOrHigher(LOG_LVL_DEBUG))
        {
            DEBUG_LOG("Dumping error-causing packet:");
            new_pct->hexlike();
        }

        if (sLog.HasLogLevelOrHigher(LOG_LVL_DETAIL))
        {
            DETAIL_LOG("Disconnecting session [account id %i / address %s] for badly formatted packet.",
                       m_Session ? m_Session->GetAccountId() : -1, GetRemoteAddress().c_str());

            return -1;
        }
        else
            return 0;
    }

    ACE_NOTREACHED(return 0);
}

int WorldSocket::HandleAuthSession(WorldPacket& recvPacket)
{
    // NOTE: ATM the socket is singlethread, have this in mind ...
    uint8 digest[20];
    uint32 clientSeed;
    uint32 serverId;
    uint32 BuiltNumberClient;
    uint32 id, security;
    uint8 expansion = 0;
    LocaleConstant locale;
    std::string account, os;
    BigNumber v, s, g, N, K;
    WorldPacket packet, SendAddonPacked;

    // Read the content of the packet
    recvPacket >> BuiltNumberClient;
    recvPacket >> serverId;
    recvPacket >> account;

    recvPacket >> clientSeed;
    recvPacket.read(digest, 20);

    DEBUG_LOG("WorldSocket::HandleAuthSession: client %u, serverId %u, account %s, clientseed %u",
              BuiltNumberClient,
              serverId,
              account.c_str(),
              clientSeed);

    // Check the version of client trying to connect
    if (!IsAcceptableClientBuild(BuiltNumberClient))
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_VERSION_MISMATCH);

        SendPacket(packet);

        sLog.outError("WorldSocket::HandleAuthSession: Sent Auth Response (version mismatch).");
        return -1;
    }

    // Get the account information from the realmd database
    std::string safe_account = account; // Duplicate, else will screw the SHA hash verification below
    LoginDatabase.escape_string(safe_account);
    // No SQL injection, username escaped.

    QueryResult* result = LoginDatabase.PQuery("SELECT "
        "a.id, "  //0
        "aa.gmLevel, " //1
        "a.sessionkey, " //2
        "a.last_ip, " //3
        "a.locked, " //4
        "a.v, " //5
        "a.s, " //6
        "a.mutetime, " //7
        "a.locale, " //8
        "a.os, " //9
        "a.flags, " //10
        "a.last_local_ip, "                //11
        "a.expansion, "                //12
        "ab.unbandate > UNIX_TIMESTAMP() OR ab.unbandate = ab.bandate " //13

        "FROM account a LEFT JOIN account_access aa ON a.id = aa.id AND aa.RealmID IN (-1, %u) "
        "LEFT JOIN account_banned ab ON a.id = ab.id AND ab.active = 1 WHERE a.username = '%s' ORDER BY aa.RealmID DESC LIMIT 1", realmID, safe_account.c_str());

    // Stop if the account is not found
    if (!result)
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_UNKNOWN_ACCOUNT);

        SendPacket(packet);

        sLog.outError("WorldSocket::HandleAuthSession: Sent Auth Response (unknown account).");
        return -1;
    }

    Field* fields = result->Fetch();

    std::string lastLocalIp = fields[11].GetString();
    //operatingSystem = fields[11].GetUInt8();
    expansion =((sWorld.getConfig(CONFIG_EXPANSION) > fields[12].GetUInt8()) ? fields[12].GetUInt8() : sWorld.getConfig(CONFIG_EXPANSION));
    N.SetHexStr("894B645E89E1535BBDAD5B8B290650530801B18EBFBF5E8FAB3C82872A3E9BB7");
    g.SetDword(7);

    v.SetHexStr(fields[5].GetString());
    s.SetHexStr(fields[6].GetString());

    char const* sStr = s.AsHexStr();                        //Must be freed by OPENSSL_free()
    char const* vStr = v.AsHexStr();                        //Must be freed by OPENSSL_free()

    DEBUG_LOG("WorldSocket::HandleAuthSession: (s,v) check s: %s v: %s",
              sStr,
              vStr);

    OPENSSL_free((void*) sStr);
    OPENSSL_free((void*) vStr);

    ///- Re-check ip locking (same check as in realmd).
    if (fields[4].GetUInt8() == 1)  // if ip is locked
    {
        if (strcmp(fields[3].GetString(), GetRemoteAddress().c_str()))
        {
            packet.Initialize(SMSG_AUTH_RESPONSE, 1);
            packet << uint8(AUTH_FAILED);
            SendPacket(packet);

            delete result;
            BASIC_LOG("WorldSocket::HandleAuthSession: Sent Auth Response (Account IP differs).");
            return -1;
        }
    }

    id = fields[0].GetUInt32();
    security = AccountMgr::GetPermissions(id); //fields[1].GetUInt16 ();
    if (security > SEC_ADMINISTRATOR)                       // prevent invalid security settings in DB
        security = SEC_ADMINISTRATOR;

    K.SetHexStr(fields[2].GetString());

    //if (K.AsByteArray().empty())
    //{
    //    delete result;
    //    return -1;
    //}

    time_t mutetime = time_t (fields[7].GetUInt64());

    locale = LocaleConstant(fields[8].GetUInt8());
    if (locale >= MAX_LOCALE)
        locale = LOCALE_enUS;
    os = fields[9].GetString();
    uint32 accFlags = fields[10].GetUInt32();
    bool isBanned = fields[13].GetBool();
    delete result;

    
    if (isBanned)
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_BANNED);
        SendPacket(packet);

        sLog.outError("WorldSocket::HandleAuthSession: Sent Auth Response (Account banned).");
        return -1;
    }

    // Check locked state for server
    AccountTypes allowedAccountType = SEC_PLAYER;

    if (allowedAccountType > SEC_PLAYER && AccountTypes(security) < allowedAccountType)
    {
        WorldPacket Packet(SMSG_AUTH_RESPONSE, 1);
        Packet << uint8(AUTH_UNAVAILABLE);

        SendPacket(packet);

        BASIC_LOG("WorldSocket::HandleAuthSession: User tries to login but his security level is not enough");
        return -1;
    }

    // Check that Key and account name are the same on client and server
    Sha1Hash sha;

    uint32 t = 0;
    uint32 seed = m_Seed;

    sha.UpdateData(account);
    sha.UpdateData((uint8 *) & t, 4);
    sha.UpdateData((uint8 *) & clientSeed, 4);
    sha.UpdateData((uint8 *) & seed, 4);
    sha.UpdateBigNumbers(&K, nullptr);
    sha.Finalize();

    if (memcmp(sha.GetDigest(), digest, 20))
    {
        packet.Initialize(SMSG_AUTH_RESPONSE, 1);
        packet << uint8(AUTH_FAILED);

        SendPacket(packet);

        sLog.outError("WorldSocket::HandleAuthSession: Sent Auth Response (authentification failed).");
        return -1;
    }

    std::string address = GetRemoteAddress();

    DEBUG_LOG("WorldSocket::HandleAuthSession: Client '%s' authenticated successfully from %s.",
              account.c_str(),
              address.c_str());

    // Update the last_ip in the database
    // No SQL injection, username escaped.
    static SqlStatementID updAccount;

    SqlStatement stmt = LoginDatabase.CreateStatement(updAccount, "UPDATE account SET last_ip = ? WHERE username = ?");
    stmt.PExecute(address.c_str(), account.c_str());

    uint8 clientOs;
    if (os == "Win")
        clientOs = CLIENT_OS_WIN;
    else if (os == "OSX")
        clientOs = CLIENT_OS_OSX;
    else
    {
        sLog.outError("WorldSocket::HandleAuthSession: Unrecognized OS '%s' for account '%s' from %s", os.c_str(), account.c_str(), address.c_str());
        return -1;
    }

    // NOTE ATM the socket is single-threaded, have this in mind ...
    ACE_NEW_RETURN(m_Session, WorldSession(id, this, AccountTypes(security), expansion, locale, mutetime), -1);

    m_Crypt.SetKey(&K);
    m_Crypt.Init();

    LoginDatabase.escape_string(lastLocalIp);

    LoginDatabase.PExecute("INSERT INTO account_login VALUES ('%u', NOW(), '%s', '%s')", id, address.c_str(), lastLocalIp.c_str());

    // Initialize Warden system only if it is enabled by config
    if (sWorld.getConfig(CONFIG_WARDEN_ENABLED))
        m_Session->InitWarden(&K, clientOs);

    // In case needed sometime the second arg is in microseconds 1 000 000 = 1 sec
    ACE_OS::sleep(ACE_Time_Value(0, 10000));

    sWorld.AddSession(m_Session);

    // Create and send the Addon packet
    if (AddonHandler::BuildAddonPacket(&recvPacket, &SendAddonPacked))
        SendPacket(SendAddonPacked);

    return 0;
}

int WorldSocket::HandlePing(WorldPacket& recvPacket)
{
    uint32 ping;
#if SUPPORTED_CLIENT_BUILD > CLIENT_BUILD_1_8_4
    uint32 latency;
#endif

    // Get the ping packet content
    recvPacket >> ping;
#if SUPPORTED_CLIENT_BUILD > CLIENT_BUILD_1_8_4
    recvPacket >> latency;
#endif

    if (m_LastPingTime == ACE_Time_Value::zero)
        m_LastPingTime = ACE_OS::gettimeofday();  // for 1st ping
    else
    {
        ACE_Time_Value cur_time = ACE_OS::gettimeofday();
        ACE_Time_Value diff_time(cur_time);
        diff_time -= m_LastPingTime;
        m_LastPingTime = cur_time;

        if (diff_time < ACE_Time_Value(27))
        {
            ++m_OverSpeedPings;

            uint32 max_count = 500;

            if (max_count && m_OverSpeedPings > max_count)
            {
                ACE_GUARD_RETURN(LockType, Guard, m_SessionLock, -1);

                if (m_Session && m_Session->GetPermissions() == SEC_PLAYER)
                {
                    sLog.outError("WorldSocket::HandlePing: Player kicked for "
                                  "overspeeded pings address = %s",
                                  GetRemoteAddress().c_str());

                    return -1;
                }
            }
        }
        else
            m_OverSpeedPings = 0;
    }

    // critical section
    {
        ACE_GUARD_RETURN(LockType, Guard, m_SessionLock, -1);

#if SUPPORTED_CLIENT_BUILD > CLIENT_BUILD_1_8_4
        if (m_Session)
            m_Session->SetLatency(latency);
        else
#else
        if (!m_Session)
#endif
        {
            sLog.outError("WorldSocket::HandlePing: peer sent CMSG_PING, "
                          "but is not authenticated or got recently kicked,"
                          " address = %s",
                          GetRemoteAddress().c_str());
            return -1;
        }
    }

    WorldPacket packet(SMSG_PONG, 4);
    packet << ping;
    return SendPacket(packet);
}

int WorldSocket::OnSocketOpen()
{
    return sWorldSocketMgr->OnSocketOpen(this);
}

int WorldSocket::SendStartupPacket()
{
    // Send startup packet.
    WorldPacket packet(SMSG_AUTH_CHALLENGE, 4);
    packet << m_Seed;

    return SendPacket(packet);
}
