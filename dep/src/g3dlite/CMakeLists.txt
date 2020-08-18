# This file is part of the OregonCore Project. See AUTHORS file for Copyright information
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


set(g3dlite_SRCS
  AABox.cpp
  Any.cpp
  BinaryFormat.cpp
  BinaryInput.cpp
  BinaryOutput.cpp
  Box.cpp
  Capsule.cpp
  CollisionDetection.cpp
  CoordinateFrame.cpp
  Crypto.cpp
  Cylinder.cpp
  debugAssert.cpp
  FileSystem.cpp
  fileutils.cpp
  format.cpp
  g3dfnmatch.cpp
  g3dmath.cpp
  Line.cpp
  LineSegment.cpp
  Log.cpp
  Matrix3.cpp
  Matrix4.cpp
  MemoryManager.cpp
  PhysicsFrame.cpp
  Plane.cpp
  prompt.cpp
  Quat.cpp
  Random.cpp
  Ray.cpp
  ReferenceCount.cpp
  RegistryUtil.cpp
  Sphere.cpp
  stringutils.cpp
  System.cpp
  TextInput.cpp
  TextOutput.cpp
  Triangle.cpp
  uint128.cpp
  UprightFrame.cpp
  Vector2.cpp
  Vector3.cpp
  Vector4.cpp
)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_SOURCE_DIR}/dep/include
  ${CMAKE_SOURCE_DIR}/dep/include/g3dlite
  ${CMAKE_SOURCE_DIR}/dep/src/libseh
)

add_library(g3dlite STATIC
  ${g3dlite_SRCS}
)

SET_TARGET_PROPERTIES (g3dlite PROPERTIES FOLDER "3rd Party")

if(WIN32)
  include_directories(${CMAKE_SOURCE_DIR}/dep/windows/include/zlib)
  if(MINGW)
    target_link_libraries(g3dlite zlib libseh)
  else()
    target_link_libraries(g3dlite zlib)
  endif()
else()
  find_package(ZLIB REQUIRED)
  if(ZLIB_FOUND)
    include_directories(${ZLIB_INCLUDE_DIRS})
    target_link_libraries(g3dlite ${ZLIB_LIBRARIES})
  endif(ZLIB_FOUND)
endif(WIN32)