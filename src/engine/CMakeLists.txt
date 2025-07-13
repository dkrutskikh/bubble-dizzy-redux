cmake_minimum_required(VERSION 3.31.6 FATAL_ERROR)

project(ToyGine)
set(TOYGINE_VERSION_MAJOR       0)
set(TOYGINE_VERSION_MINOR       0)
set(TOYGINE_VERSION_MAINTENANCE 0)
set(TOYGINE_SOURCE_PATH         ${CMAKE_CURRENT_SOURCE_DIR})

# Remove ZERO_TEST at least BUILD_ALL remains
set(CMAKE_SUPPRESS_REGENERATION 1)

# to distinguish between debug and release builds
set(CMAKE_DEBUG_POSTFIX "d")
set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")

# Set generate relative path  ON
set(CMAKE_USE_RELATIVE_PATHS TRUE)
set(CMAKE_SUPPRESS_REGENERATION TRUE)

# Setup configuration types
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)

# Make default 'RelWithDebInfo' build
if(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE "RelWithDebInfo")
endif()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(ConfigureEngine)
include(ConfigureCompiler)

add_subdirectory(sources)
