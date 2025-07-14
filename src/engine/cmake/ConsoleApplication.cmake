function(console_application BINARY_NAME SRC_LIST ${HDR_LIST} ${INL_LIST} ${LIB_LIST})

source_group("Source Files" FILES ${SRC_LIST} ${INL_LIST})

add_executable(${BINARY_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST})

if(DEFINED PREPROCESSOR_DEFINITIONS)
  target_compile_definitions(${BINARY_NAME} ${PREPROCESSOR_DEFINITIONS})
endif(DEFINED PREPROCESSOR_DEFINITIONS)

target_link_libraries(${BINARY_NAME} ${LIB_LIST})

endfunction(console_application)
