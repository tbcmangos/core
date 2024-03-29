# Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
# Copyright (C) 2009-2011 MaNGOSZero <https://github.com/mangos/zero>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

set(EXECUTABLE_NAME realmd)
file(GLOB_RECURSE EXECUTABLE_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

if(WIN32)
  list(APPEND EXECUTABLE_SRCS
    realmd.rc
  )
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /D__ACE_INLINE__")
endif()

include_directories(
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_BINARY_DIR}
  ${CMAKE_BINARY_DIR}/src/shared
  ${MYSQL_INCLUDE_DIR}
  ${ACE_INCLUDE_DIR}
  ${OPENSSL_INCLUDE_DIR}
)

if(WIN32)
  include_directories(
    ${CMAKE_SOURCE_DIR}/dep/windows/include
  )
endif()

add_executable(${EXECUTABLE_NAME}
  ${EXECUTABLE_SRCS}
)

target_link_libraries(${EXECUTABLE_NAME}
  shared
  framework
  ${ACE_LIBRARIES}
  ${OPENSSL_LIBRARIES}
  ${TBB_LIBRARIES}
)

if(WIN32)
  target_link_libraries(${EXECUTABLE_NAME}
    optimized ${MYSQL_LIBRARY}
    optimized ${OPENSSL_LIBRARIES}
    debug ${MYSQL_DEBUG_LIBRARY}
    debug ${OPENSSL_DEBUG_LIBRARIES}
  )
  if(MINGW)
    target_link_libraries(${EXECUTABLE_NAME}
      -lws2_32
    )
  endif()
  if(PLATFORM MATCHES X86)
    target_link_libraries(${EXECUTABLE_NAME})
  endif()
endif()

if(UNIX)
  target_link_libraries(${EXECUTABLE_NAME}
    ${MYSQL_LIBRARY}
    ${OPENSSL_LIBRARIES}
    ${OPENSSL_EXTRA_LIBRARIES}
  )
endif()

if (USE_LIBCURL)
  target_link_libraries(${EXECUTABLE_NAME} curl)
endif()

set(EXECUTABLE_LINK_FLAGS "")

if(UNIX)
  set(EXECUTABLE_LINK_FLAGS "-pthread ${EXECUTABLE_LINK_FLAGS}")
endif()

if(APPLE)
  set(EXECUTABLE_LINK_FLAGS "-framework Carbon ${EXECUTABLE_LINK_FLAGS}")
endif()

set_target_properties(${EXECUTABLE_NAME} PROPERTIES LINK_FLAGS
  "${EXECUTABLE_LINK_FLAGS}"
)

install(TARGETS ${EXECUTABLE_NAME} DESTINATION ${BIN_DIR})
install(FILES realmd.conf.dist.in DESTINATION ${CONF_DIR} RENAME realmd.conf.dist)

if(WIN32 AND MSVC)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/\${BUILD_TYPE}/${EXECUTABLE_NAME}.pdb DESTINATION ${BIN_DIR} CONFIGURATIONS Debug)
endif()
