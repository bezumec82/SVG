cmake_minimum_required(VERSION 3.14)

if(NOT WIN32)
  string(ASCII 27 ESC)
  set( NORM "${ESC}[39m" )
  set( RED  "${ESC}[31m" ) 
  set( GRN  "${ESC}[32m" )
  set( CYN  "${ESC}[36m" )
  set( MAG  "${ESC}[35m" )
  set( YEL  "${ESC}[33m" )
  set( BLU  "${ESC}[34m" )
endif()

set( CMAKE_DISABLE_IN_SOURCE_BUILD ON )
set( CMAKE_DISABLE_SOURCE_CHANGES  ON )

if( "${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}" )
  message( SEND_ERROR "In-source builds are not allowed." )
endif ()

project( SVG LANGUAGES C CXX )

# set( CMAKE_VERBOSE_MAKEFILE ON )
set( CMAKE_COLOR_MAKEFILE ON )

# Version number
set( SVG_VERSION_MAJOR 1 )
set( SVG_VERSION_MINOR 0 )

########
### Misc
########
if ( UNIX )
    ### Get it from 'build.sh'
    # set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread -std=c++17 -O0 -DLINUX_TERMINAL" )
elseif( MINGW )
    message( "Compile using MINGW compiler : " ${MSVC_TOOLSET_VERSION} )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -pthread -Wa,-mbig-obj -std=c++17 -O0" )
elseif( MSVC )
    # set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17" )
    set_directory_properties(PROPERTIES COMPILE_DEFINITIONS _VARIADIC_MAX=10 ) 
endif()

set( CMAKE_BUILD_TYPE Debug )
set( CMAKE_INSTALL_PREFIX           ${CMAKE_CURRENT_SOURCE_DIR}/out )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/out )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/out )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/out )

#############
### Libraries
#############
include(  ${CMAKE_CURRENT_SOURCE_DIR}/Boost.cmake )
add_subdirectory( ${CMAKE_CURRENT_SOURCE_DIR}/svgpp/src/samples )
add_subdirectory( ${CMAKE_CURRENT_SOURCE_DIR}/svgpp/src/demo/render )