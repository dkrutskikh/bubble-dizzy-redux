#
# Stuff the average programmer needs to change #
set(SRC_LIST hello.cpp)
set(HDR_LIST )
set(INL_LIST )
set(LIB_LIST toygine)
set(BINARY_NAME bubble-dizzy)

console_application(${BINARY_NAME} ${SRC_LIST} ${HDR_LIST} ${INL_LIST} ${LIB_LIST})
