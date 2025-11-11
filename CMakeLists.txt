#-------------------------------------------------------------------------------------------
# Copyright (c) 2025 Dmitry Krutskikh
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and / or sell copies of the Software, and to permit
# persons to whom the Software is furnished to do so, subject to the following conditions :
#
# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#-------------------------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.31.0 FATAL_ERROR)

project(BubbleDizzyRedux LANGUAGES CXX VERSION 0.0.0 HOMEPAGE_URL https://github.com/dkrutskikh/bubble-dizzy-redux)

# To distinguish between debug and release builds
set(CMAKE_DEBUG_POSTFIX "d")
set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")

# Disable regeneration of build system files by IDEs
set(CMAKE_SUPPRESS_REGENERATION TRUE)

# Enable projects folders
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

#-------------------------------------------------------------------------------------------
# User-provided options
#-------------------------------------------------------------------------------------------

# Setup configuration types
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)

# Make default 'Release' build
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif (NOT CMAKE_BUILD_TYPE)

#-------------------------------------------------------------------------------------------
# Compile and linking options
#-------------------------------------------------------------------------------------------

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/engine/cmake")

include(ConfigureEngine)
include(ConfigureCompiler)

add_subdirectory(engine)

set_target_properties(toygine PROPERTIES FOLDER "Engine")

#-------------------------------------------------------------------------------------------

set(SRC_DIZZY_LIST game.cpp)
set(HDR_DIZZY_LIST )
set(INL_DIZZY_LIST )

set(SRC_LIST ${SRC_DIZZY_LIST})
set(HDR_LIST ${HDR_DIZZY_LIST})
set(INL_LIST ${INL_DIZZY_LIST})
set(LIB_LIST toygine)
set(RES_LIST )
#set(MEDIA_PATH "../../media/lastversion")
#set(OS_DEPENDED_RESOURCES_PATH)
#set(OS_DEPENDED_BINARY_FILES)
set(APP_NAME BubbleDizzyRedux)

source_group("Dizzy" FILES ${SRC_DIZZY_LIST} ${HDR_DIZZY_LIST} ${INL_DIZZY_LIST})
source_group("Resources" FILES ${RES_LIST})

if (TOYGINE_TARGET_PLATFORM STREQUAL "Nintendo Game Boy Advance")

  add_executable(${APP_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST} ${RES_LIST})

  gba_create_rom(${APP_NAME}
      PAD TRUE
      TITLE "BubbleDizzy"
      GAMECODE "BBLD"
      MAKERCODE "DK"
      VERSION "1"
      DEBUG "1"
  )

else ()

  add_executable(${APP_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST} ${RES_LIST})

endif()
#-------------------------------------------------------------------------------------------
