if(TARGET_PLATFORM STREQUAL "macOS Desktop")
  set(TARGET_PLATFORM_CONFIG_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/platforms/macos/platform_config.h)
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/core/core.h.in ${CMAKE_CURRENT_SOURCE_DIR}/../include/core.h @ONLY)
