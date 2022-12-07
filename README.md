######################
#   Disclaimer2020   #
######################

[![CI build](https://github.com/tbcmangos/core/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/tbcmangos/core/actions/workflows/c-cpp.yml)

This core is a server emulator for World of Warcraft: The Burning Crusade. The server serves full world content including authentication & scripts support. Compatible with World of Warcraft client 2.4.3(8606).
As you can see it is based on hellgroundcore which had stopped for 4 years. if you dont familar with the background below is the timeframe of each emulator.

* timeline 
* mangos         2005 -------------2010-------------------- now(2020)    , https://github.com/mangos/MaNGOS
* trinity                 2008----------------------------- now(2020)    , https://github.com/trinitycore
* HellGroundCore          2008-----------------2016                      , https://github.com/hellground-tbc
* Looking4Group                                2016--2017                , https://github.com/Looking4Group/L4G_Core
* vMaNGOS        2005->mangos->nostalgia->Elysium->vmangos- now(2020)    , https://github.com/vmangos
* thiscore                2008--HellGroundCore-2016 ....... now(2020)    , https://github.com/tbcmangos/core  

the original hellground pserver was a very good server and was stopped around 2016, Looking4Group pretty much using the same HellgroundCore and adding/fixing a few stuff. 
I was able to merge Looking4Group fixes into HellGroundCore but majority code still HellGroundCore, A lot of the structures are very similar to MaNGOS, as it is based on TrinityCore 2009.

although hellground lived for 8 years, this public source still filled with problems and bad code and should not be used in a production server.
A lot of effort was put into the content, so it may still a good source for dev/learning purpose.

The orignal source has been tested on Ubuntu and compilled with gcc4.8, and with windows2010 project files that you can compile under windows and running smoothly.
The current source has been upgraded to support cmake, and tested under vs2017 to 2019, 
both x86/x64 debug and release build works. it also works for centos7 and ubuntu18, i forgot which ubuntu it works but will update read me.

This is an eductional project for people to learn stuffs like server/communication/c++/cmake/sql/travis. also enjoy the good tbc memory back in the day.
my plan for now is to do below at spare time and maybe later fixing some game content and such.

* - [x] fix cmake for windows
* - [x] merge script system into core 
* - [x] upgrade core to latest compiler 
* - [ ] attempt to learn the framework and compare with latest mangos/trinity functions
* - [ ] interact with travis with multiple build and some more research
* - [ ] fix bugs etc..

# how to compile

### notice for windows
- uncheck ACE_USE_EXTERNAL to compile use dep/acelite
- uncheck TBB_USE_EXTERNAL to compile use dep/tbb
- uncheck USE_STD_MALLOC
- after compile copy libmysql.dll libeay32.dll libssl32.dll tbb.dll tbbmalloc.dll

### notice for linux
- install tbb and ace lib, ACE_USE_EXTERNAL TBB_USE_EXTERNAL is on by default
- however in centos7 it is easier to add -DACE_USE_EXTERNAL=0 to use internal ace
- for ubuntu can just install the libace-dev and use default -DACE_USE_EXTERNAL=1(no need add, it is default on)

tested x86/x64 vs2017 debug and release both works, RelWithDebInfo fails.

######################
#HellGroundCoreLegacy #
######################

HUGE thanks to the Hellground.net team for temporarily going open-source with their project in 2014
* Wiki: http://wiki.hellground.net
* Site: https://hellground.net

If the Wiki is ever down, there is a dump of the entire website zipped into the repository.

# Why use HellGroundCore?
The common cores like MaNGOS and TrinityCore were abandoned in 2009, in favor of developing 3.x emulation.
They were later taken on again by different forks like OregonCore and SkyfireOne. Even MaNGOS eventually resumed development.

However, they mostly received some update to their libraries and not many of the quality code base was taken and backported to those forks.
As a result, the public emulators are in a fairly bad state of playability. 

HellGroundCore was developed by the team behind the server for players expecting no gamebreaking bugs. It is fairly stable and a great base - only if you're starting development from scratch.

That's 5 years of development other servers don't have. Yet you shouldn't expect something mind blowing. A lot of the structures are very similar to MaNGOS, as it is based on TrinityCore 2009.
It comes with some custom systems as well as improved debug handling/logging and GM permissions and other smaller features like Recruit A Friend.

# Downsides
* Old libraries, especially since this fork hasn't been updated for 2 years
* 64 bit compile under Visual Studio currently doesn't work out of the box
* Not necessarily compatible with fixes ported to cMaNGOS-TBC, OregonCore or TrinityCore2 due to being in closed development for so long


#Compile in Windows
If you intend on compiling it in anything but 32 bit, you will need to use CMake as suggested [here](http://wiki.hellground.net/index.php/Building_under_Windows).

### Disclaimer:
If you prefer compiling your own dependencies, they can be fund under dep/include/*. These have the correct versions, so that you don't have to worry about conflicts with precompiled binaries you may be using!

You can find OpenSSL as an installer for Win32/64 [here](https://slproweb.com/products/Win32OpenSSL.html)
You will also need to make your version of Visual Studio [compatible with the 2010 64 Bit Compiler](http://stackoverflow.com/questions/1865069/how-to-compile-a-64-bit-application-using-visual-c-2010-express)

CMake expects ACE, MySQL and TBB (if you want to use the latter) to be under dep/lib/*, if you aren't using external libraries. 
There are already precompiled libraries you can find under dep/lib/precompiled/Release.

Either edit CMakeLists to your liking or provide MySQL or put your MySQL libraries under dep/lib/[x64_release|win32_release]/*.

