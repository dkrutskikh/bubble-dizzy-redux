if(TARGET_PLATFORM STREQUAL "Windows Desktop")

  if(MSVC)
    message(STATUS "Compiler: MSVC, version: " ${MSVC_VERSION})

    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:Debug>")

    # Minimum CPU Architecture select based on https://store.steampowered.com/hwsurvey/

    set(CMAKE_C_FLAGS   "/std:c17 /nologo /Wall /WX /wd4710 /wd4711 /DWIN32 /D_WINDOWS /DUNICODE /D_UNICODE /EHsc /Zc:wchar_t /Zc:forScope /Zc:inline /Zc:rvalueCast /GR- /permissive")
    set(CMAKE_CXX_FLAGS "         /nologo /Wall /WX /wd4710 /wd4711 /DWIN32 /D_WINDOWS /DUNICODE /D_UNICODE /EHsc /Zc:wchar_t /Zc:forScope /Zc:inline /Zc:rvalueCast /GR- /permissive")

    if(CMAKE_SIZEOF_VOID_P MATCHES "8")

      set(CMAKE_C_FLAGS_DEBUG            "/ZI /diagnostics:caret   /sdl                     /fsanitize=fuzzer /Od /Ob0 /Oi-     /Oy-         /D_DEBUG /GF- /RTCc /D_ALLOW_RTCc_IN_STL /RTCsu /MTd /GS  /guard:cf- /Gy  /Qpar- /arch:SSE2 /fp:strict  /fp:except            /Gr")
      set(CMAKE_CXX_FLAGS_DEBUG          "/ZI /diagnostics:caret   /sdl                     /fsanitize=fuzzer /Od /Ob0 /Oi-     /Oy-         /D_DEBUG /GF- /RTCc /D_ALLOW_RTCc_IN_STL /RTCsu /MTd /GS  /guard:cf- /Gy  /Qpar- /arch:SSE2 /fp:strict  /fp:except            /Gd")

      set(CMAKE_C_FLAGS_RELWITHDEBINFO   "/Zi /diagnostics:column  /sdl  /fsanitize=address /fsanitize=fuzzer /Ox /Ob3 /Oi  /Ot /Oy- /GT /GL /D_DEBUG /GF                                    /MTd /GS  /guard:cf  /Gy- /Qpar- /arch:SSE2 /fp:precise /fp:except            /Gr")
      set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "/Zi /diagnostics:column  /sdl  /fsanitize=address /fsanitize=fuzzer /Ox /Ob3 /Oi  /Ot /Oy- /GT /GL /D_DEBUG /GF                                    /MTd /GS  /guard:cf  /Gy- /Qpar- /arch:SSE2 /fp:precise /fp:except            /Gr")

      set(CMAKE_C_FLAGS_RELEASE          "    /diagnostics:classic /sdl-                                      /Ox /Ob3 /Oi  /Ot /Oy  /GT /GL /DNDEBUG /GF                                    /MT  /GS- /guard:cf- /Gy- /Qpar  /arch:SSE2 /fp:fast    /fp:except-           /Gr")
      set(CMAKE_CXX_FLAGS_RELEASE        "    /diagnostics:classic /sdl-                                      /Ox /Ob3 /Oi  /Ot /Oy  /GT /GL /DNDEBUG /GF                                    /MT  /GS- /guard:cf- /Gy- /Qpar  /arch:SSE2 /fp:fast    /fp:except-           /Gr")

    else()

      set(CMAKE_C_FLAGS_DEBUG            "/ZI /diagnostics:caret   /sdl                     /fsanitize=fuzzer /Od /Ob0 /Oi-     /Oy-         /D_DEBUG /GF- /RTCc /D_ALLOW_RTCc_IN_STL /RTCsu /MTd /GS  /guard:cf- /Gy  /Qpar- /arch:IA32 /fp:strict  /fp:except  /hotpatch /Gd")
      set(CMAKE_CXX_FLAGS_DEBUG          "/ZI /diagnostics:caret   /sdl                     /fsanitize=fuzzer /Od /Ob0 /Oi-     /Oy-         /D_DEBUG /GF- /RTCc /D_ALLOW_RTCc_IN_STL /RTCsu /MTd /GS  /guard:cf- /Gy  /Qpar- /arch:IA32 /fp:strict  /fp:except  /hotpatch /Gd")

      set(CMAKE_C_FLAGS_RELWITHDEBINFO   "/Zi /diagnostics:column  /sdl  /fsanitize=address /fsanitize=fuzzer /Ox /Ob3 /Oi  /Ot /Oy- /GT /GL /D_DEBUG /GF                                    /MTd /GS  /guard:cf  /Gy- /Qpar- /arch:SSE2 /fp:precise /fp:except            /Gr")
      set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "/Zi /diagnostics:column  /sdl  /fsanitize=address /fsanitize=fuzzer /Ox /Ob3 /Oi  /Ot /Oy- /GT /GL /D_DEBUG /GF                                    /MTd /GS  /guard:cf  /Gy- /Qpar- /arch:SSE2 /fp:precise /fp:except            /Gr")

      set(CMAKE_C_FLAGS_RELEASE          "    /diagnostics:classic /sdl-                                      /Ox /Ob3 /Oi  /Ot /Oy  /GT /GL /DNDEBUG /GF                                    /MT  /GS- /guard:cf- /Gy- /Qpar  /arch:SSE2 /fp:fast    /fp:except-           /Gr")
      set(CMAKE_CXX_FLAGS_RELEASE        "    /diagnostics:classic /sdl-                                      /Ox /Ob3 /Oi  /Ot /Oy  /GT /GL /DNDEBUG /GF                                    /MT  /GS- /guard:cf- /Gy- /Qpar  /arch:SSE2 /fp:fast    /fp:except-           /Gr")

    endif()

    set(CMAKE_STATIC_LINKER_FLAGS "/WX")
    set(CMAKE_EXE_LINKER_FLAGS    "/WX /MANIFEST /MANIFESTUAC:\"/level='asInvoker' /uiAccess='false'\" /ALLOWISOLATION /LARGEADDRESSAWARE /SAFESEH:NO")

    set(CMAKE_STATIC_LINKER_FLAGS_DEBUG           "                /LTCG:OFF")
    set(CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO  "                /LTCG")
    set(CMAKE_STATIC_LINKER_FLAGS_RELEASE         "                /LTCG")

    set(CMAKE_EXE_LINKER_FLAGS_DEBUG              "/INCREMENTAL:NO /LTCG:OFF /DEBUG:FULL /ASSEMBLYDEBUG")
    set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO     "/INCREMENTAL:NO /LTCG     /DEBUG:FULL /ASSEMBLYDEBUG")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE            "/INCREMENTAL:NO /LTCG     /DEBUG:NONE /ASSEMBLYDEBUG:DISABLE")
  endif(MSVC)

elseif(TARGET_PLATFORM STREQUAL "Linux Desktop")

elseif(TARGET_PLATFORM STREQUAL "macOS Desktop")

  message(STATUS "Compiler: Xcode, version: " ${XCODE_VERSION})

endif()

add_compile_definitions(TOYGINE_VERSION_MAJOR=${TOYGINE_VERSION_MAJOR})
add_compile_definitions(TOYGINE_VERSION_MINOR=${TOYGINE_VERSION_MINOR})
add_compile_definitions(TOYGINE_VERSION_MAINTENANCE=${TOYGINE_VERSION_MAINTENANCE})

message("CMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
message("CMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG}")
message("CMAKE_C_FLAGS_RELWITHDEBINFO=${CMAKE_C_FLAGS_RELWITHDEBINFO}")
message("CMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE}")
message("CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}")
message("CMAKE_CXX_FLAGS_DEBUG=${CMAKE_CXX_FLAGS_DEBUG}")
message("CMAKE_CXX_FLAGS_RELWITHDEBINFO=${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message("CMAKE_CXX_FLAGS_RELEASE=${CMAKE_CXX_FLAGS_RELEASE}")

message("CMAKE_STATIC_LINKER_FLAGS=${CMAKE_STATIC_LINKER_FLAGS}")
message("CMAKE_STATIC_LINKER_FLAGS_DEBUG=${CMAKE_STATIC_LINKER_FLAGS_DEBUG}")
message("CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO=${CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO}")
message("CMAKE_STATIC_LINKER_FLAGS_RELEASE=${CMAKE_STATIC_LINKER_FLAGS_RELEASE}")

message("CMAKE_EXE_LINKER_FLAGS=${CMAKE_EXE_LINKER_FLAGS}")
message("CMAKE_EXE_LINKER_FLAGS_DEBUG=${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
message("CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO=${CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO}")
message("CMAKE_EXE_LINKER_FLAGS_RELEASE=${CMAKE_EXE_LINKER_FLAGS_RELEASE}")

message("PREPROCESSOR_DEFINITIONS=${PREPROCESSOR_DEFINITIONS}")
