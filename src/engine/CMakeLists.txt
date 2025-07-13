cmake_minimum_required(VERSION 3.31.6 FATAL_ERROR)

set(TOYGINE_VERSION_MAJOR       0)
set(TOYGINE_VERSION_MINOR       0)
set(TOYGINE_VERSION_MAINTENANCE 0)
set(TOYGINE_SOURCE_PATH         ${CMAKE_CURRENT_SOURCE_DIR})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(ConfigureEngine)
include(ConfigureCompiler)

add_subdirectory(sources)
