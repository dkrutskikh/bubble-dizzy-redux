cmake_minimum_required(VERSION 3.31.6 FATAL_ERROR)

project(BubbleDizzyRedux VERSION 0.1.2 LANGUAGES C CXX)

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

#------------------------------------------------------------------------------------------------------------
# User-provided options
#------------------------------------------------------------------------------------------------------------

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
		"Choose the type of build, options are: ${CMAKE_CONFIGURATION_TYPES}. Default is RelWithDebInfo."
		FORCE)
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${CMAKE_CONFIGURATION_TYPES})
endif()

#------------------------------------------------------------------------------------------------------------
# Compile and linking options
#------------------------------------------------------------------------------------------------------------

# Enable C++20 Globally
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable C 17 Globally
set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/src/engine/cmake")
include(ConfigureEngine)
include(ConfigureCompiler)

add_subdirectory(src/engine)
add_subdirectory(src/game)

#------------------------------------------------------------------------------------------------------------
# Packaging section
#------------------------------------------------------------------------------------------------------------

set(PACKAGE_NAME_SUFFIX "" CACHE STRING "Suffix for CPack package name")
set(PACKAGE_FILE_NAME "" CACHE STRING "Override for CPack package filename")
mark_as_advanced(PACKAGE_NAME_SUFFIX PACKAGE_FILE_NAME)
