cmake_minimum_required (VERSION 3.0)
project (WinHTTP-HEAD)

add_definitions(-DUNICODE -D_UNICODE)
add_executable(winhttp-head WIN32 winhttp-head.cpp)

target_link_libraries(winhttp-head
  winhttp
)

set_target_properties(winhttp-head PROPERTIES 
  LINK_FLAGS "/SUBSYSTEM:CONSOLE"
  COMPILE_DEFINITIONS "_CONSOLE"
)

install (TARGETS winhttp-head DESTINATION bin)