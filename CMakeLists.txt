cmake_minimum_required(VERSION 3.31.6 FATAL_ERROR)

project(BubbleDizzyRedux VERSION 0.0.0 LANGUAGES C CXX)

# to distinguish between debug and release builds
set(CMAKE_DEBUG_POSTFIX "d")
set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")

set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo" CACHE STRING "" FORCE)

################################################
#            User-provided options             #
################################################

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
		"Choose the type of build, options are: ${CMAKE_CONFIGURATION_TYPES}. Default is RelWithDebInfo."
		FORCE)
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS ${CMAKE_CONFIGURATION_TYPES})
endif()

################################################
#         Compile and linking options          #
################################################

# Enable C++17 Globally
set(CMAKE_CXX_STANDARD 17)

# Enable C 17
set(CMAKE_C_STANDARD 17)

add_subdirectory(src/engine)

add_executable(bubble-dizzy hello.cpp)

include(CTest)
enable_testing()
