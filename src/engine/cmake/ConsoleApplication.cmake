function(console_application BINARY_NAME ${SRC_LIST} ${HDR_LIST} ${INL_LIST} ${LIB_LIST})

add_definitions(${PREPROCESSOR_DEFINITIONS})
source_group("Source Files" FILES ${SRC_LIST} ${INL_LIST})
add_executable(${BINARY_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST})
target_link_libraries(${BINARY_NAME} ${LIB_LIST})

endfunction(console_application)
