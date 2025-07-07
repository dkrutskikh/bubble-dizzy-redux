if(TARGET_PLATFORM STREQUAL "Windows Desktop")

  if(MSVC)
      message(STATUS "Compiler: MSVC, version: " ${MSVC_VERSION})

#####################

      # Link incrementally
      add_link_options(
        "$<$<CONFIG:DEBUG>:/INCREMENTAL>"
        "$<$<CONFIG:RELWITHDEBINFO>:/INCREMENTAL:NO>"
        "$<$<CONFIG:RELEASE>:/INCREMENTAL:NO>"
      )

      # Link-time code generation
      add_link_options(
        "$<$<CONFIG:RELWITHDEBINFO>:/LTCG:STATUS>"
        "$<$<CONFIG:RELEASE>:/LTCG:STATUS>"
      )

      # Treat linker warnings as errors
      add_link_options(/WX)

      # Create side-by-side assembly manifest
      add_link_options(/MANIFEST)

      # Manifest lookup
      add_link_options(/ALLOWISOLATION)

      # Embeds UAC information in manifest
      add_link_options(/MANIFESTUAC:"/level='asInvoker' /uiAccess='false'")

      # Generate debug info
      add_link_options(
        "$<$<CONFIG:DEBUG>:/DEBUG:FULL>"
        "$<$<CONFIG:RELWITHDEBINFO>:/DEBUG:FULL>"
        "$<$<CONFIG:RELEASE>:/DEBUG:NONE>"
      )

      # Add DebuggableAttribute
      add_link_options(
        "$<$<CONFIG:DEBUG>:/ASSEMBLYDEBUG>"
        "$<$<CONFIG:RELWITHDEBINFO>:/ASSEMBLYDEBUG:DISABLE>"
        "$<$<CONFIG:RELEASE>:/ASSEMBLYDEBUG:DISABLE>"
      )

      # Handle Large Addresses
      add_link_options(/LARGEADDRESSAWARE)

      # Link-time code generation
      add_link_options(
        "$<$<CONFIG:DEBUG>:/LTCG:OFF>"
        "$<$<CONFIG:RELWITHDEBINFO>:/LTCG>"
        "$<$<CONFIG:RELEASE>:/LTCG>"
      )

      # Disable Safe Exception Handlers
      add_link_options(/SAFESEH:NO)

    # Minimum CPU Architecture select based on https://store.steampowered.com/hwsurvey/

    set(CMAKE_C_FLAGS   "/std:c17 /nologo /Wall /WX /DWIN32 /D_WINDOWS /DUNICODE /D_UNICODE /EHsc /Zc:wchar_t /Zc:forScope /Zc:inline /Zc:rvalueCast /GR- /permissive")
    set(CMAKE_CXX_FLAGS "         /nologo /Wall /WX /DWIN32 /D_WINDOWS /DUNICODE /D_UNICODE /EHsc /Zc:wchar_t /Zc:forScope /Zc:inline /Zc:rvalueCast /GR- /permissive")

    if(CMAKE_SIZEOF_VOID_P MATCHES "8")

      set(CMAKE_C_FLAGS_DEBUG            "/ZI /diagnostics:caret   /sdl                     /fsanitize=fuzzer /Od /Ob0 /Oi-     /Oy-         /D_DEBUG /GF- /RTCc /D_ALLOW_RTCc_IN_STL /RTCsu /MTd /GS  /guard:cf- /Gy  /Qpar- /arch:SSE2 /fp:strict  /fp:except  /hotpatch /Gd")
      set(CMAKE_CXX_FLAGS_DEBUG          "/ZI /diagnostics:caret   /sdl                     /fsanitize=fuzzer /Od /Ob0 /Oi-     /Oy-         /D_DEBUG /GF- /RTCc /D_ALLOW_RTCc_IN_STL /RTCsu /MTd /GS  /guard:cf- /Gy  /Qpar- /arch:SSE2 /fp:strict  /fp:except  /hotpatch /Gd")

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

    set(CMAKE_STATIC_LINKER_FLAGS_DEBUG "")
    set(CMAKE_STATIC_LINKER_FLAGS_RELWITHDEBINFO "/LTCG")
    set(CMAKE_STATIC_LINKER_FLAGS_RELEASE "/LTCG")

    set(CMAKE_EXE_LINKER_FLAGS_DEBUG          "/DEBUG /INCREMENTAL          /SAFESEH:NO")
    set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "/DEBUG /INCREMENTAL:NO /LTCG /SAFESEH:NO")
    set(CMAKE_EXE_LINKER_FLAGS_RELEASE        "       /INCREMENTAL:NO /LTCG /SAFESEH:NO")

    set(STATIC_LIBRARY_FLAGS_RELWITHDEBINFO "/LTCG")
    set(STATIC_LIBRARY_FLAGS_RELEASE "/LTCG")
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

message("STATIC_LIBRARY_FLAGS=${STATIC_LIBRARY_FLAGS}")
message("STATIC_LIBRARY_FLAGS_DEBUG=${STATIC_LIBRARY_FLAGS_DEBUG}")
message("STATIC_LIBRARY_FLAGS_RELWITHDEBINFO=${STATIC_LIBRARY_FLAGS_RELWITHDEBINFO}")
message("STATIC_LIBRARY_FLAGS_RELEASE=${STATIC_LIBRARY_FLAGS_RELEASE}")

message("CMAKE_CXX_LINKER_PREFERENCE=${CMAKE_CXX_LINKER_PREFERENCE}")
message("CMAKE_CXX_LINKER_PREFERENCE_PROPAGATES=${CMAKE_CXX_LINKER_PREFERENCE_PROPAGATES}")
message("CMAKE_CXX_LINK_EXECUTABLE=${CMAKE_CXX_LINK_EXECUTABLE}")

message("LIBRARY_OUTPUT_DIRECTORY=${LIBRARY_OUTPUT_DIRECTORY}")
message("PREPROCESSOR_DEFINITIONS=${PREPROCESSOR_DEFINITIONS}")
message("CMAKE_LIBRARY_OUTPUT_DIRECTORY=${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
