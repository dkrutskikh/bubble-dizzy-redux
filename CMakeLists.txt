cmake_minimum_required(VERSION 3.31.6)

project(bubble-dizzy-redux VERSION 0.0.0 LANGUAGES C CXX)

# to distinguish between debug and release builds
set(CMAKE_DEBUG_POSTFIX "d")
set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")

# ################################# #
# Compile and linking options       #
# ################################# #

# Enable C++17 Globally
set(CMAKE_CXX_STANDARD 17)

# Enable C 17
set(CMAKE_C_STANDARD 17)

add_executable(bubble-dizzy hello.cpp)

include(CTest)
enable_testing()
