set(BINARY_NAME bubble-dizzy)

#------------------------------------------------------------------------------------------------------------

set(SRC_LIST hello.cpp)
set(HDR_LIST )
set(INL_LIST )

set(LIB_LIST toygine)

#------------------------------------------------------------------------------------------------------------

console_application(${BINARY_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST} ${LIB_LIST})
