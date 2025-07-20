cmake_minimum_required(VERSION 3.31.6 FATAL_ERROR)

set(BINARY_NAME bubble-dizzy)

include(ConsoleApplication)

#------------------------------------------------------------------------------------------------------------

set(SRC_LIST hello.cpp)
set(HDR_LIST )
set(INL_LIST )

set(LIB_LIST toygine)

#------------------------------------------------------------------------------------------------------------

console_application(${BINARY_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST} ${LIB_LIST})

#------------------------------------------------------------------------------------------------------------

set(PACKAGE_NAME_SUFFIX "" CACHE STRING "Suffix for CPack package name")
set(PACKAGE_FILE_NAME "" CACHE STRING "Override for CPack package filename")

if("${PACKAGE_NAME_SUFFIX}" STREQUAL "")
	set(CPACK_PACKAGE_NAME "BubbleDizzyRedux")
else()
	set(CPACK_PACKAGE_NAME "BubbleDizzyRedux ${PACKAGE_NAME_SUFFIX}")
endif()

set(CPACK_PACKAGE_VENDOR "Toyman Interactive")

set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")

if("${PACKAGE_FILE_NAME}" STREQUAL "")
	set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
else()
	set(CPACK_PACKAGE_FILE_NAME "${PACKAGE_FILE_NAME}")
endif()

set(CPACK_GENERATOR TGZ)

include(CPack)
