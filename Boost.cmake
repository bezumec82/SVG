macro(get_WIN32_WINNT version)
if (WIN32 AND CMAKE_SYSTEM_VERSION)
    set( ver ${CMAKE_SYSTEM_VERSION} )
    message( "CMAKE_SYSTEM_VERSION : " ${CMAKE_SYSTEM_VERSION} )
    # string(REPLACE <match-string> <replace-string> <out-var> <input>...)
    string( REPLACE "." "" ver ${ver} )
    # string(REGEX REPLACE <match-regex> <replace-expr> <out-var> <input>...)
    string( REGEX REPLACE "([0-9])" "0\\1" ver ${ver} )
    set( ${version} "0x${ver}" )
endif()
endmacro()
get_WIN32_WINNT( ver )
message( "Windows version : " ${ver} )
add_definitions( -D_WIN32_WINNT=${ver} )

set( Boost_DETAILED_FAILURE_MSG ON )
set( Boost_DEBUG ON )
set( Boost_USE_MULTITHREADED ON )
set( Boost_USE_STATIC_RUNTIME OFF )

if( WIN32 )
    set( Boost_USE_STATIC_LIBS ON )
    set( BOOST_ROOT         "c:/Boost" )
    set( BOOST_LIBRARYDIR   "c:/Boost/lib" )
    set( BOOST_INCLUDEDIR   "c:/Boost/include/boost-1_56" )
    set( Boost_ARCHITECTURE "-x64" )
endif()

# message( "${YEL}Provided BOOSTROOT : ${BOOSTROOT}${NORM}" )
find_package( Boost 1.56 REQUIRED )



if( Boost_FOUND )
    message( "Boost headers : " ${Boost_INCLUDE_DIR} )
    message( "Boost libs : " ${Boost_LIBRARY_DIRS} )

    include_directories( ${Boost_INCLUDE_DIR} )
    link_directories( ${Boost_LIBRARY_DIRS} )

    add_definitions( "-DHAS_BOOST" )
else()
    message( "!!! Boost didn't found !!!" )
endif()