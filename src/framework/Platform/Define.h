/*
 * Copyright (C) 2005-2012 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2008 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2008-2015 Hellground <http://hellground.net/>
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

#ifndef HELLGROUND_DEFINE_H
#define HELLGROUND_DEFINE_H

#include <sys/types.h>

#include <ace/Basic_Types.h>
#include <ace/Default_Constants.h>
#include <ace/OS_NS_dlfcn.h>
#include <ace/ACE_export.h>

#include "Platform/CompilerDefs.h"

#define HELLGROUND_LITTLEENDIAN 0
#define HELLGROUND_BIGENDIAN    1

#if !defined(HELLGROUND_ENDIAN)
#  if defined (ACE_BIG_ENDIAN)
#    define HELLGROUND_ENDIAN HELLGROUND_BIGENDIAN
#  else //ACE_BYTE_ORDER != ACE_BIG_ENDIAN
#    define HELLGROUND_ENDIAN HELLGROUND_LITTLEENDIAN
#  endif //ACE_BYTE_ORDER
#endif //HELLGROUND_ENDIAN

#if PLATFORM == PLATFORM_WINDOWS
#  ifndef THIS_IS_SCRIPT_DLL
#    define HELLGROUND_EXPORT __declspec(dllexport)
#  else
#    define HELLGROUND_EXPORT
#  endif
#  define HELLGROUND_IMPORT __cdecl
#  define HELLGROUND_PATH_MAX MAX_PATH
#else //PLATFORM != PLATFORM_WINDOWS
#  define HELLGROUND_EXPORT
#  if defined(__APPLE_CC__) && defined(BIG_ENDIAN)
#    define HELLGROUND_IMPORT __attribute__ ((longcall))
#  elif defined(__x86_64__)
#    define HELLGROUND_IMPORT
#  else
#    define HELLGROUND_IMPORT __attribute__ ((cdecl))
#  endif //__APPLE_CC__ && BIG_ENDIAN
#  define HELLGROUND_PATH_MAX PATH_MAX
#endif //PLATFORM

//
// Use HELLGROUND_IMPORT_EXPORT define to proper export from core/shared/etc to script dll
// While compile core - defined like __declspec(dllexport)
// While compile script dll - defined like __declspec(dllimport)
//
// Use just HELLGROUND_EXPORT for static objects
//
// Make sense only in windows OS
//
#if PLATFORM == PLATFORM_WINDOWS
#  ifndef THIS_IS_SCRIPT_DLL
#    define HELLGROUND_IMPORT_EXPORT  __declspec(dllexport)
#  else
#    define HELLGROUND_IMPORT_EXPORT __declspec(dllimport)
#  endif
#else //PLATFORM != PLATFORM_WINDOWS
#  define HELLGROUND_IMPORT_EXPORT
#  define DECLSPEC_NORETURN
#endif //PLATFORM


#if !defined(DEBUG)
#  define HELLGROUND_INLINE inline
#else //DEBUG
#  if !defined(HELLGROUND_DEBUG)
#    define HELLGROUND_DEBUG
#  endif //HELLGROUND_DEBUG
#  define HELLGROUND_INLINE
#endif //!DEBUG

#if COMPILER == COMPILER_GNU
#  define ATTR_NORETURN __attribute__((noreturn))
#  define ATTR_PRINTF(F,V) __attribute__ ((format (printf, F, V)))
#else //COMPILER != COMPILER_GNU
#  define ATTR_NORETURN
#  define ATTR_PRINTF(F,V)
#endif //COMPILER == COMPILER_GNU

typedef ACE_INT64 int64;
typedef ACE_INT32 int32;
typedef ACE_INT16 int16;
typedef ACE_INT8 int8;
typedef ACE_UINT64 uint64;
typedef ACE_UINT32 uint32;
typedef ACE_UINT16 uint16;
typedef ACE_UINT8 uint8;

#if COMPILER != COMPILER_MICROSOFT
typedef uint16      WORD;
typedef uint32      DWORD;
#endif //COMPILER

typedef uint64 OBJECT_HANDLE;

#endif //HELLGROUND_DEFINE_H

