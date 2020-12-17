macro(__enable_cxx17)
	if ( CMAKE_SYSTEM_NAME MATCHES "Windows" )
		set( my_std_pre "/std:" )
	else()
		set( my_std_pre "-std=" )
	endif()

	set( basic_cxx17 "c++17" )
	set( str_cxx17 "${my_std_pre}${basic_cxx17}" )
	
	include( CheckCXXCompilerFlag )
	check_cxx_compiler_flag( "${str_cxx17}" _cpp_17_flag_supported )
	if ( _cpp_17_flag_supported )
		set( CMAKE_CXX_STANDARD 17 )
	endif()
endmacro()

if(NOT WIN32)
	if(NOT CMAKE_BUILD_TYPE)
		set(CMAKE_BUILD_TYPE "Release")
		message(STATUS "Default Build Type ${CMAKE_BUILD_TYPE}")
	endif()
	
	if(CMAKE_BUILD_TYPE STREQUAL "Release")
		add_definitions(-DNDEBUG)
	else()
		add_definitions(-DDEBUG)
		add_definitions(-D_DEBUG)
	endif()
endif()

if(WIN32)
	set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS
		$<$<CONFIG:Debug>:_DEBUG>
		$<$<CONFIG:Release>:NDEBUG>)
	set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS
		$<$<CONFIG:Debug>:CXX_CHECK_MEMORY_LEAKS>)
	set_property(DIRECTORY APPEND PROPERTY COMPILE_DEFINITIONS
		$<$<CONFIG:Debug>:DEBUG>)
endif()