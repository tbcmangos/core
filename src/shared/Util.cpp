/*
 * Copyright (C) 2005-2008 MaNGOS <http://www.mangosproject.org/>
 *
 * Copyright (C) 2008 Trinity <http://www.trinitycore.org/>
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

#include "Timer.h"
#include "Util.h"

#include "utf8cpp/utf8.h"
#include "mersennetwister/MersenneTwister.h"
#include <ace/TSS_T.h>
#include <ace/OS_NS_arpa_inet.h>

typedef ACE_TSS<MTRand> MTRandTSS;

static MTRandTSS mtRand;

int32 irand(int32 min, int32 max)
{
    return mtRand->randInt (max-min) + min;
}

float frand(float min, float max)
{
    return mtRand->randExc(max - min) + min;
}

uint32 urand(uint32 min, uint32 max)
{
  return mtRand->randInt(max - min) + min;
}

int32 rand32()
{
    return mtRand->randInt();
}

double rand_norm(void)
{
    return mtRand->randExc();
}

double rand_chance(void)
{
    return mtRand->randExc(100.0);
}

static ACE_Time_Value g_SystemTickTime = ACE_OS::gettimeofday();

uint32 WorldTimer::m_iTime = 0;
uint32 WorldTimer::m_iPrevTime = 0;

uint32 WorldTimer::tickTime() { return m_iTime; }
uint32 WorldTimer::tickPrevTime() { return m_iPrevTime; }

uint32 WorldTimer::tick()
{
    // Save previous world tick time
    m_iPrevTime = m_iTime;

    // Get the new one and don't forget to persist current system time in m_SystemTickTime
    m_iTime = WorldTimer::getMSTime_internal(true);

    // return tick diff
    return getMSTimeDiff(m_iPrevTime, m_iTime);
}

uint32 WorldTimer::getMSTime()
{
    return getMSTime_internal();
}

uint32 WorldTimer::getMSTime_internal(bool savetime /*= false*/)
{
    // Get current time
    const ACE_Time_Value currTime = ACE_OS::gettimeofday();
    // calculate time diff between two world ticks
    // special case: curr_time < old_time - we suppose that our time has not ticked at all
    // this should be constant value otherwise it is possible that our time can start ticking backwards until next world tick!!
    uint64 diff = 0;
    (currTime - g_SystemTickTime).msec(diff);

    //lets calculate current world time
    uint32 iRes = uint32(diff % UI64LIT(0x00000000FFFFFFFF));
    return iRes;
}

Tokens StrSplit(const std::string &src, const std::string &sep)
{
    Tokens r;
    std::string s;
    for (std::string::const_iterator i = src.begin(); i != src.end(); i++)
    {
        if (sep.find(*i) != std::string::npos)
        {
            if (s.length()) r.push_back(s);
            s = "";
        }
        else
        {
            s += *i;
        }
    }
    if (s.length()) r.push_back(s);
    return r;
}

void stripLineInvisibleChars(std::string &str)
{
    static std::string invChars = " \t\7";

    size_t wpos = 0;

    bool space = false;
    for(size_t pos = 0; pos < str.size(); ++pos)
    {
        if(invChars.find(str[pos])!=std::string::npos)
        {
            if(!space)
            {
                str[wpos++] = ' ';
                space = true;
            }
        }
        else
        {
            if(wpos!=pos)
                str[wpos++] = str[pos];
            else
                ++wpos;
            space = false;
        }
    }

    if(wpos < str.size())
        str.erase(wpos,str.size());
}

std::string secsToTimeString(uint32 timeInSecs, bool shortText, bool hoursOnly)
{
    uint32 secs    = timeInSecs % MINUTE;
    uint32 minutes = timeInSecs % HOUR / MINUTE;
    uint32 hours   = timeInSecs % DAY  / HOUR;
    uint32 days    = timeInSecs / DAY;

    std::ostringstream ss;
    if(days)
        ss << days << (shortText ? "d" : " Day(s) ");
    if(hours || hoursOnly)
        ss << hours << (shortText ? "h" : " Hour(s) ");
    if(!hoursOnly)
    {
        if(minutes)
            ss << minutes << (shortText ? "m" : " Minute(s) ");
        if(secs || (!days && !hours && !minutes) )
            ss << secs << (shortText ? "s" : " Second(s).");
    }

    return ss.str();
}

uint32 TimeStringToSecs(const std::string& timestring)
{
    uint32 secs       = 0;
    uint32 buffer     = 0;
    uint32 multiplier = 0;

    for(std::string::const_iterator itr = timestring.begin(); itr != timestring.end(); itr++ )
    {
        if(isdigit(*itr))
        {
            std::string str;                                //very complicated typecast char->const char*; is there no better way?
            str += *itr;
            const char* tmp = str.c_str();

            buffer*=10;
            buffer+=atoi(tmp);
        }
        else
        {
            switch(*itr)
            {
                case 'd': multiplier = DAY;     break;
                case 'h': multiplier = HOUR;    break;
                case 'm': multiplier = MINUTE;  break;
                case 's': multiplier = 1;       break;
                default : return 0;                         //bad format
            }
            buffer*=multiplier;
            secs+=buffer;
            buffer=0;
        }
    }

    return secs;
}

std::string TimeToTimestampStr(time_t t)
{
    tm* aTm = localtime(&t);
    //       YYYY   year
    //       MM     month (2 digits 01-12)
    //       DD     day (2 digits 01-31)
    //       HH     hour (2 digits 00-23)
    //       MM     minutes (2 digits 00-59)
    //       SS     seconds (2 digits 00-59)
    char buf[20];
    snprintf(buf,20,"%04d-%02d-%02d %02d:%02d:%02d",aTm->tm_year+1900,aTm->tm_mon+1,aTm->tm_mday,aTm->tm_hour,aTm->tm_min,aTm->tm_sec);
    return std::string(buf);
}

/// Check if the string is a valid ip address representation
bool IsIPAddress(char const* ipaddress)
{
    if(!ipaddress)
        return false;

    // Let the big boys do it.
    // Drawback: all valid ip address formats are recognized e.g.: 12.23,121234,0xABCD)
    return ACE_OS::inet_addr(ipaddress) != INADDR_NONE;
}

/// create PID file
uint32 CreatePIDFile(const std::string& filename)
{
    FILE * pid_file = fopen (filename.c_str(), "w" );
    if (pid_file == NULL)
        return 0;

#ifdef WIN32
    DWORD pid = GetCurrentProcessId();
#else
    pid_t pid = getpid();
#endif

    fprintf(pid_file, "%d", pid );
    fclose(pid_file);

    return (uint32)pid;
}

size_t utf8length(std::string& utf8str)
{
    try
    {
        return utf8::distance(utf8str.c_str(),utf8str.c_str()+utf8str.size());
    }
    catch(std::exception)
    {
        utf8str = "";
        return 0;
    }
}

void utf8truncate(std::string& utf8str,size_t len)
{
    try
    {
        size_t wlen = utf8::distance(utf8str.c_str(),utf8str.c_str()+utf8str.size());
        if(wlen <= len)
            return;

        std::wstring wstr;
        wstr.resize(wlen);
        utf8::utf8to16(utf8str.c_str(),utf8str.c_str()+utf8str.size(),&wstr[0]);
        wstr.resize(len);
        char* oend = utf8::utf16to8(wstr.c_str(),wstr.c_str()+wstr.size(),&utf8str[0]);
        utf8str.resize(oend-(&utf8str[0]));                 // remove unused tail
    }
    catch(std::exception)
    {
        utf8str = "";
    }
}

bool Utf8toWStr(std::string const& utf8str, std::wstring& wstr, size_t max_len)
{
    if (utf8str.empty())
    {
        wstr = std::wstring();
        return true;
    }

    try
    {
        // A UTF8 string can have a maximum of 4 octets per character
        // A 4 octet char can take up to two UTF16 characters (4*8 = 32 / 16 = 2)
        // The UTF8 string may also actually be ASCII, in which case no truncation
        // takes place! The final string length is therefore unknown. Reserve
        // as long as the OG string, and back-insert
        wstr.resize(utf8str.size());

        auto end = utf8::utf8to16(utf8str.cbegin(), utf8str.cend(), wstr.begin());

        if (end != wstr.end())
            wstr.erase(end, wstr.end());

        // truncate to max len
        if (!!max_len && wstr.size() > max_len)
        {
            wstr.resize(max_len);
        }
    }
    catch (std::exception)
    {
        wstr = L"";
        return false;
    }

    return true;
}

bool WStrToUtf8(std::wstring& wstr, std::string& utf8str)
{
    try
    {
        std::string utf8str2;
        utf8str2.resize(wstr.size() * 4);                     // allocate for most long case

        auto end = utf8::utf16to8(wstr.cbegin(), wstr.cend(), utf8str2.begin());
        if (end != utf8str2.end())
            utf8str2.erase(end, utf8str2.end());

        utf8str = utf8str2;
    }
    catch (std::exception)
    {
        utf8str = "";
        return false;
    }

    return true;
}

typedef wchar_t const* const* wstrlist;

std::wstring GetMainPartOfName(std::wstring wname, uint32 declension)
{
    // supported only Cyrillic cases
    if(wname.size() < 1 || !isCyrillicCharacter(wname[0]) || declension > 5)
        return wname;

    // Important: end length must be <= MAX_INTERNAL_PLAYER_NAME-MAX_PLAYER_NAME (3 currently)

    static wchar_t const a_End[]    = { wchar_t(1), wchar_t(0x0430),wchar_t(0x0000)};
    static wchar_t const o_End[]    = { wchar_t(1), wchar_t(0x043E),wchar_t(0x0000)};
    static wchar_t const ya_End[]   = { wchar_t(1), wchar_t(0x044F),wchar_t(0x0000)};
    static wchar_t const ie_End[]   = { wchar_t(1), wchar_t(0x0435),wchar_t(0x0000)};
    static wchar_t const i_End[]    = { wchar_t(1), wchar_t(0x0438),wchar_t(0x0000)};
    static wchar_t const yeru_End[] = { wchar_t(1), wchar_t(0x044B),wchar_t(0x0000)};
    static wchar_t const u_End[]    = { wchar_t(1), wchar_t(0x0443),wchar_t(0x0000)};
    static wchar_t const yu_End[]   = { wchar_t(1), wchar_t(0x044E),wchar_t(0x0000)};
    static wchar_t const oj_End[]   = { wchar_t(2), wchar_t(0x043E),wchar_t(0x0439),wchar_t(0x0000)};
    static wchar_t const ie_j_End[] = { wchar_t(2), wchar_t(0x0435),wchar_t(0x0439),wchar_t(0x0000)};
    static wchar_t const io_j_End[] = { wchar_t(2), wchar_t(0x0451),wchar_t(0x0439),wchar_t(0x0000)};
    static wchar_t const o_m_End[]  = { wchar_t(2), wchar_t(0x043E),wchar_t(0x043C),wchar_t(0x0000)};
    static wchar_t const io_m_End[] = { wchar_t(2), wchar_t(0x0451),wchar_t(0x043C),wchar_t(0x0000)};
    static wchar_t const ie_m_End[] = { wchar_t(2), wchar_t(0x0435),wchar_t(0x043C),wchar_t(0x0000)};
    static wchar_t const soft_End[] = { wchar_t(1), wchar_t(0x044C),wchar_t(0x0000)};
    static wchar_t const j_End[]    = { wchar_t(1), wchar_t(0x0439),wchar_t(0x0000)};

    static wchar_t const* const dropEnds[6][8] = {
        { &a_End[1],  &o_End[1],    &ya_End[1],   &ie_End[1],  &soft_End[1], &j_End[1],    NULL,       NULL },
        { &a_End[1],  &ya_End[1],   &yeru_End[1], &i_End[1],   NULL,         NULL,         NULL,       NULL },
        { &ie_End[1], &u_End[1],    &yu_End[1],   &i_End[1],   NULL,         NULL,         NULL,       NULL },
        { &u_End[1],  &yu_End[1],   &o_End[1],    &ie_End[1],  &soft_End[1], &ya_End[1],   &a_End[1],  NULL },
        { &oj_End[1], &io_j_End[1], &ie_j_End[1], &o_m_End[1], &io_m_End[1], &ie_m_End[1], &yu_End[1], NULL },
        { &ie_End[1], &i_End[1],    NULL,         NULL,        NULL,         NULL,         NULL,       NULL }
    };

    for(wchar_t const * const* itr = &dropEnds[declension][0]; *itr; ++itr)
    {
        size_t len = size_t((*itr)[-1]);                    // get length from string size field

        if(wname.substr(wname.size()-len,len)==*itr)
            return wname.substr(0,wname.size()-len);
    }

    return wname;
}

bool utf8ToConsole(const std::string& utf8str, std::string& conStr)
{
#if PLATFORM == PLATFORM_WINDOWS
    std::wstring wstr;
    if(!Utf8toWStr(utf8str,wstr))
        return false;

    conStr.resize(wstr.size());
    CharToOemBuffW(&wstr[0],&conStr[0],wstr.size());
#else
    // not implemented yet
    conStr = utf8str;
#endif

    return true;
}

bool consoleToUtf8(const std::string& conStr,std::string& utf8str)
{
#if PLATFORM == PLATFORM_WINDOWS
    std::wstring wstr;
    wstr.resize(conStr.size());
    OemToCharBuffW(&conStr[0],&wstr[0],conStr.size());

    return WStrToUtf8(wstr,utf8str);
#else
    // not implemented yet
    utf8str = conStr;
    return true;
#endif
}

bool Utf8FitTo(const std::string& str, std::wstring search)
{
    std::wstring temp;

    if(!Utf8toWStr(str,temp))
        return false;

    // converting to lower case
    wstrToLower( temp );

    if(temp.find(search) == std::wstring::npos)
        return false;

    return true;
}

void utf8printf(FILE *out, const char *str, ...)
{
    va_list ap;
    va_start(ap, str);
    vutf8printf(stdout, str, &ap);
    va_end(ap);
}

void vutf8printf(FILE *out, const char *str, va_list* ap)
{
#if PLATFORM == PLATFORM_WINDOWS
    std::string temp_buf;
    temp_buf.resize(32 * 1024);
    std::wstring wtemp_buf;

    vsnprintf(&temp_buf[0], 32 * 1024, str, *ap);
    temp_buf.resize(strlen(temp_buf.c_str())); // Resize to match the formatted string

    if (!temp_buf.empty())
    {
        Utf8toWStr(temp_buf, wtemp_buf, 32 * 1024);
        wtemp_buf.push_back('\0');

        CharToOemBuffW(&wtemp_buf[0], &temp_buf[0], wtemp_buf.size());
    }
    fprintf(out, "%s", temp_buf.c_str());
#else
    vfprintf(out, str, *ap);
#endif
}

void hexEncodeByteArray(uint8* bytes, uint32 arrayLen, std::string& result)
{
    std::ostringstream ss;
    for (uint32 i = 0; i<arrayLen; ++i)
    {
        for (uint8 j = 0; j<2; ++j)
        {
            unsigned char nibble = 0x0F & (bytes[i] >> ((1 - j) * 4));
            char encodedNibble;
            if (nibble < 0x0A)
                encodedNibble = '0' + nibble;
            else
                encodedNibble = 'A' + nibble - 0x0A;
            ss << encodedNibble;
        }
    }
    result = ss.str();
}

std::string ByteArrayToHexStr(uint8 const* bytes, uint32 arrayLen, bool reverse /* = false */) {
    int32 init = 0;
    int32 end = arrayLen;
    int8 op = 1;

    if (reverse) {
        init = arrayLen - 1;
        end = -1;
        op = -1;
    }

    std::ostringstream ss;
    for (int32 i = init; i != end; i += op) {
        char buffer[4];
        sprintf(buffer, "%02X", bytes[i]);
        ss << buffer;
    }

    return ss.str();
}

void HexStrToByteArray(std::string const& str, uint8* out, bool reverse /*= false*/) {
    // string must have even number of characters
    if (str.length() & 1)
        return;

    int32 init = 0;
    int32 end = str.length();
    int8 op = 1;

    if (reverse) {
        init = str.length() - 2;
        end = -2;
        op = -1;
    }

    uint32 j = 0;
    for (int32 i = init; i != end; i += 2 * op) {
        char buffer[3] = { str[i], str[i + 1], '\0' };
        out[j++] = strtoul(buffer, nullptr, 16);
    }
}