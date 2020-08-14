
set(LIBRARY_NAME scripts)

file(GLOB_RECURSE scripts_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

set(scripts_STAT_SRCS
  ${scripts_STAT_SRCS}
  ../game/AI/ScriptedEscortAI.cpp
  ../game/AI/ScriptedEscortAI.h
  ../game/AI/ScriptedGossip.h
  ../game/ScriptedCreature.cpp
  ../game/ScriptedCreature.h
  ../game/AI/ScriptedFollowerAI.cpp
  ../game/AI/ScriptedFollowerAI.h
  ../game/AI/ScriptedInstance.h
  ../game/ScriptMgr.h
  ../game/ScriptLoader.h
)

if(WIN32)
  list(APPEND scripts_SRCS
    ${scripts_STAT_SRCS}
	${sources_Debugging}
  )
endif()
  list(APPEND scripts_SRCS
    ${scripts_STAT_SRCS}
  )

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_SOURCE_DIR}/dep/include/g3dlite
  ${CMAKE_SOURCE_DIR}/dep/include
  ${CMAKE_SOURCE_DIR}/src/game
  ${CMAKE_SOURCE_DIR}/src/game/AI
  ${CMAKE_SOURCE_DIR}/src/game/Anticheat
  ${CMAKE_SOURCE_DIR}/src/game/Anticheat/WardenAnticheat
  ${CMAKE_SOURCE_DIR}/src/game/AuctionHouse
  ${CMAKE_SOURCE_DIR}/src/game/Battlegrounds
  ${CMAKE_SOURCE_DIR}/src/game/Chat
  ${CMAKE_SOURCE_DIR}/src/game/Commands
  ${CMAKE_SOURCE_DIR}/src/game/Database
  ${CMAKE_SOURCE_DIR}/src/game/Group
  ${CMAKE_SOURCE_DIR}/src/game/Guild
  ${CMAKE_SOURCE_DIR}/src/game/Handlers
  ${CMAKE_SOURCE_DIR}/src/game/LFG
  ${CMAKE_SOURCE_DIR}/src/game/Mail
  ${CMAKE_SOURCE_DIR}/src/game/Maps
  ${CMAKE_SOURCE_DIR}/src/game/Maps/Pool
  ${CMAKE_SOURCE_DIR}/src/game/Movement
  ${CMAKE_SOURCE_DIR}/src/game/Movement/spline
  ${CMAKE_SOURCE_DIR}/src/game/Objects
  ${CMAKE_SOURCE_DIR}/src/game/OutdoorPvP
  ${CMAKE_SOURCE_DIR}/src/game/PlayerBots
  ${CMAKE_SOURCE_DIR}/src/game/Protocol
  ${CMAKE_SOURCE_DIR}/src/game/Spells
  ${CMAKE_SOURCE_DIR}/src/game/Threat
  ${CMAKE_SOURCE_DIR}/src/game/Transports
  ${CMAKE_SOURCE_DIR}/src/game/vmap
  ${CMAKE_SOURCE_DIR}/src/shared
  
  ${CMAKE_SOURCE_DIR}/src/shared/Database
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_SOURCE_DIR}/src/framework/Network
  ${CMAKE_BINARY_DIR}
  ${CMAKE_BINARY_DIR}/src/shared
  ${CMAKE_CURRENT_SOURCE_DIR}/PrecompiledHeaders
  ${TBB_INCLUDE_DIRS}
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}

)

source_group("Scripts"
  REGULAR_EXPRESSION .*
)

source_group("Manager"
  REGULAR_EXPRESSION ScriptMgr
)

source_group("System"
  REGULAR_EXPRESSION ScriptLoader|system|sc_gossip|sc_instance|precompiled
)

source_group("Bosses"
  REGULAR_EXPRESSION boss*
)

source_group("Instances"
  REGULAR_EXPRESSION instance*
)

source_group("Areatrigger"
  REGULAR_EXPRESSION areatrigger*
)

source_group("Creatures and Npcs"
  REGULAR_EXPRESSION mob|npc|npcs|guard
)

source_group("Items"
  REGULAR_EXPRESSION item*
)

source_group("Game Objects"
  REGULAR_EXPRESSION go*
)

source_group("Spells"
  REGULAR_EXPRESSION spell*
)
source_group("AI"
  REGULAR_EXPRESSION escort_ai|follower_ai|simple_ai|sc_creature
)

#add_dependencies(${LIBRARY_NAME} revision.h)


add_library(scripts STATIC ${scripts_SRCS})

add_definitions(-D_TRINITY_SCRIPT_CONFIG='"${CONF_DIR}/mangosd.conf"')

# IF (CMAKE_SYSTEM_NAME MATCHES "Darwin")
#     SET_TARGET_PROPERTIES(trinityscript PROPERTIES LINK_FLAGS "-flat_namespace -undefined suppress")
# ENDIF (CMAKE_SYSTEM_NAME MATCHES "Darwin")

target_link_libraries(scripts)

# set_target_properties(scripts PROPERTIES VERSION 4.2.0 SOVERSION 4)
# install(TARGETS trinityscript DESTINATION lib)

