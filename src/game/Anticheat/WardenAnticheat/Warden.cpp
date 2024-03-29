/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
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

#include "Common.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Log.h"
#include "Opcodes.h"
#include "ByteBuffer.h"
#include <openssl/md5.h>
#include <openssl/sha.h>
#include "World.h"
#include "Player.h"
#include "Util.h"
#include "Warden.h"
#include "WardenWin.h"

WardenBase::WardenBase() : iCrypto(16), oCrypto(16), m_WardenCheckTimer(10000/*10 sec*/), m_WardenKickTimer(0), m_WardenDataSent(false),
    m_initialized(false), m_checkIntervalMin(25000), m_checkIntervalMax(35000), m_maxMemChecks(3), m_maxRandomChecks(5)
{
}

WardenBase::~WardenBase()
{
    if (Module != NULL)
    {
        delete[] Module->CompressedData;
        delete Module;
        Module = NULL;
    }
    m_initialized = false;
}

void WardenBase::Init(WorldSession *pClient, BigNumber *K)
{
    ASSERT(false);
}

ClientWardenModule *WardenBase::GetModuleForClient(WorldSession *session)
{
    ASSERT(false);
    return NULL;
}

void WardenBase::InitializeModule()
{
    ASSERT(false);
}

void WardenBase::RequestHash()
{
    ASSERT(false);
}

void WardenBase::HandleHashResult(ByteBuffer &buff)
{
    ASSERT(false);
}

void WardenBase::RequestData()
{
    ASSERT(false);
}

void WardenBase::HandleData(ByteBuffer &buff)
{
    ASSERT(false);
}

void WardenBase::SendModuleToClient()
{
//    sLog.outWarden("Send module to client");

    // Create packet structure
    WardenModuleTransfer pkt;

    uint32 size_left = Module->CompressedSize;
    uint32 pos = 0;
    uint16 burst_size;
    while (size_left > 0)
    {
        burst_size = size_left < 500 ? size_left : 500;
        pkt.Command = WARDEN_SMSG_MODULE_CACHE;
        pkt.DataSize = burst_size;
        memcpy(pkt.Data, &Module->CompressedData[pos], burst_size);
        size_left -= burst_size;
        pos += burst_size;

        EncryptData((uint8*)&pkt, burst_size + 3);
        WorldPacket pkt1(SMSG_WARDEN_DATA, burst_size + 3);
        pkt1.append((uint8*)&pkt, burst_size + 3);
        Client->SendPacket(&pkt1);
    }
}

void WardenBase::RequestModule()
{
//    sLog.outWarden("Request module");

    // Create packet structure
    WardenModuleUse Request;
    Request.Command = WARDEN_SMSG_MODULE_USE;

    memcpy(Request.Module_Id, Module->ID, 16);
    memcpy(Request.Module_Key, Module->Key, 16);
    Request.Size = Module->CompressedSize;

    // Encrypt with warden RC4 key.
    EncryptData((uint8*)&Request, sizeof(WardenModuleUse));

    WorldPacket pkt(SMSG_WARDEN_DATA, sizeof(WardenModuleUse));
    pkt.append((uint8*)&Request, sizeof(WardenModuleUse));
    Client->SendPacket(&pkt);
    m_WardenDataSent = true;
}

void WardenBase::Update()
{
    if (m_initialized)
    {
        uint32 ticks = WorldTimer::getMSTime();
        uint32 diff = ticks - m_WardenTimer;
        m_WardenTimer = ticks;

        if (m_WardenDataSent)
        {
            // 1.5 minutes after send packet
            if ((m_WardenKickTimer > 90000) && sWorld.getConfig(CONFIG_WARDEN_KICK))
                    Client->KickPlayer();
            else
                m_WardenKickTimer += diff;
        }
        else if (m_WardenCheckTimer > 0)
        {
            if (diff >= m_WardenCheckTimer)
            {
                RequestData();
                m_WardenCheckTimer = urand(m_checkIntervalMin, m_checkIntervalMax);
            }
            else
                m_WardenCheckTimer -= diff;
        }
    }
}

void WardenBase::DecryptData(uint8 *Buffer, uint32 Len)
{
    iCrypto.UpdateData(Len, Buffer);
}

void WardenBase::EncryptData(uint8 *Buffer, uint32 Len)
{
    oCrypto.UpdateData(Len, Buffer);
}

void WardenBase::PrintHexArray(const char *Before, const uint8 *Buffer, uint32 Len, bool BreakWithNewline)
{
    printf(Before);
    for (uint32 i = 0; i < Len; ++i)
        printf("%02X ", Buffer[i]);
    if (BreakWithNewline)
        printf("\n");
}

bool WardenBase::IsValidCheckSum(uint32 checksum, const uint8 *Data, const uint16 Length, uint32 acc)
{
    uint32 newchecksum = BuildChecksum(Data, Length);

    if (checksum != newchecksum)
    {
        
        sLog.outWarden("CHECKSUM IS NOT VALID account %u checksum: %u | newchecksum: %u", acc, checksum, newchecksum);
        return false;
    }
    else
    {
//        sLog.outWarden("CHECKSUM IS VALID");
        return true;
    }
}

struct keyData {
    union
    {
        struct
        {
            uint8 bytes[20];
        } bytes;

        struct
        {
            uint32 ints[5];
        } ints;
    };
};

uint32 WardenBase::BuildChecksum(const uint8* data, uint32 dataLen)
{
    keyData hash;
    SHA1(data, dataLen, hash.bytes.bytes);
    uint32 checkSum = 0;
    for (uint8 i = 0; i < 5; ++i)
        checkSum = checkSum ^ hash.ints.ints[i];
    return checkSum;
}

void WorldSession::HandleWardenDataOpcode(WorldPacket & recv_data)
{
    if (!m_Warden || recv_data.empty())
        return;

    m_Warden->DecryptData(const_cast<uint8*>(recv_data.contents()), recv_data.size());
    uint8 Opcode;
    recv_data >> Opcode;
//    sLog.outWarden("Got packet, opcode %02X, size %u", Opcode, recv_data.size());
    recv_data.hexlike();

    switch(Opcode)
    {
        case WARDEN_CMSG_MODULE_MISSING:
            m_Warden->SendModuleToClient();
            break;
        case WARDEN_CMSG_MODULE_OK:
            m_Warden->RequestHash();
            break;
        case WARDEN_CMSG_CHEAT_CHECKS_RESULT:
            m_Warden->HandleData(recv_data);
            break;
        case WARDEN_CMSG_MEM_CHECKS_RESULT:
            sLog.outWarden("NYI WARDEN_CMSG_MEM_CHECKS_RESULT received! account %u", GetAccountId());
            break;
        case WARDEN_CMSG_HASH_RESULT:
            m_Warden->HandleHashResult(recv_data);
            m_Warden->InitializeModule();
            break;
        case WARDEN_CMSG_MODULE_FAILED:
            sLog.outWarden("NYI WARDEN_CMSG_MODULE_FAILED received! account %u", GetAccountId());
            break;
        default:
            sLog.outWarden("Got unknown warden opcode %02X of size %u. account %u", Opcode, recv_data.size() - 1, GetAccountId());
            break;
    }
}
