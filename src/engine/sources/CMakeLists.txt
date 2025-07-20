if(TARGET_PLATFORM STREQUAL "Windows Desktop")
  set(TARGET_PLATFORM_CONFIG_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/platforms/windows/platform_config.hpp)
elseif(TARGET_PLATFORM STREQUAL "macOS Desktop")
  set(TARGET_PLATFORM_CONFIG_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/platforms/macos/platform_config.hpp)
else()
  message(FATAL_ERROR "Unsupported TARGET_PLATFORM: ${TARGET_PLATFORM}")
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/core/core.hpp.in ${CMAKE_CURRENT_SOURCE_DIR}/../include/core.hpp @ONLY)

#------------------------------------------------------------------------------------------------------------

set(SRC_CORE_LIST core/core_utils.cpp)
set(HDR_CORE_LIST ../include/core.hpp)
set(INL_CORE_LIST ../include/core_inline.hpp)

#------------------------------------------------------------------------------------------------------------

source_group("Core" FILES ${SRC_CORE_LIST} ${HDR_CORE_LIST} ${INL_CORE_LIST})

set(SRC_LIST ${SRC_LIST} ${SRC_CORE_LIST})
set(HDR_LIST ${HDR_LIST} ${HDR_CORE_LIST})
set(INL_LIST ${INL_LIST} ${INL_CORE_LIST})
set(LIB_LIST ${LIB_LIST})

set(LIBRARY_NAME toygine)

add_library(${LIBRARY_NAME} STATIC ${SRC_LIST} ${HDR_LIST} ${INL_LIST})

if(DEFINED PREPROCESSOR_DEFINITIONS)
  target_compile_definitions(${LIBRARY_NAME} ${PREPROCESSOR_DEFINITIONS})
endif(DEFINED PREPROCESSOR_DEFINITIONS)

target_link_libraries(${LIBRARY_NAME} ${LIB_LIST})
