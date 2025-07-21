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

#------------------------------------------------------------------------------------------------------------
# User-provided options
#------------------------------------------------------------------------------------------------------------

# Setup configuration types
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)

# Make default 'RelWithDebInfo' build
if(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE "RelWithDebInfo")
endif()

# Compilation options

option(ENABLE_TEST "Enable compilation of unit tests" OFF)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(ConfigureEngine)
include(ConfigureCompiler)

if(TARGET_PLATFORM STREQUAL "Windows Desktop")
  set(TARGET_PLATFORM_CONFIG_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/sources/platforms/windows/platform_config.hpp)
elseif(TARGET_PLATFORM STREQUAL "macOS Desktop")
  set(TARGET_PLATFORM_CONFIG_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/sources//platforms/macos/platform_config.hpp)
else()
  message(FATAL_ERROR "Unsupported TARGET_PLATFORM: ${TARGET_PLATFORM}")
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/sources/core/core.hpp.in ${CMAKE_CURRENT_SOURCE_DIR}/include/core.hpp @ONLY)

#------------------------------------------------------------------------------------------------------------

set(SRC_CORE_LIST sources/core/core_utils.cpp)
set(HDR_CORE_LIST include/core.hpp)
set(INL_CORE_LIST include/core_inline.hpp)

#------------------------------------------------------------------------------------------------------------

source_group("Core" FILES ${SRC_CORE_LIST} ${HDR_CORE_LIST} ${INL_CORE_LIST})

set(SRC_LIST ${SRC_LIST} ${SRC_CORE_LIST})
set(HDR_LIST ${HDR_LIST} ${HDR_CORE_LIST})
set(INL_LIST ${INL_LIST} ${INL_CORE_LIST})
set(LIB_LIST ${LIB_LIST})

set(LIBRARY_NAME toygine)

add_library(${LIBRARY_NAME} STATIC ${SRC_LIST} ${HDR_LIST} ${INL_LIST})

target_include_directories(${LIBRARY_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(DEFINED PREPROCESSOR_DEFINITIONS)
  target_compile_definitions(${LIBRARY_NAME} ${PREPROCESSOR_DEFINITIONS})
endif(DEFINED PREPROCESSOR_DEFINITIONS)

target_link_libraries(${LIBRARY_NAME} ${LIB_LIST})

#------------------------------------------------------------------------------------------------------------
# Tests block
#------------------------------------------------------------------------------------------------------------

if(ENABLE_TEST)
  Include(FetchContent)

  FetchContent_Declare(
    Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG        v3.8.1 # or a later release
  )

  FetchContent_MakeAvailable(Catch2)

	add_executable(tests test/stub.test.cpp)
  target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)

  include(CTest)
  include(Catch)
  catch_discover_tests(tests)
endif()
