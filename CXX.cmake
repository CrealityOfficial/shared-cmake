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

macro(__enable_mem_leak_check)
	if(WIN32)
		add_definitions(-DCXX_MEMORY_LEAK_CHECK)
	else()
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

macro(__enable_vld)
	if(WIN32)
		message(STATUS "------------${CMAKE_SOURCE_DIR}")
		include_directories(${CMAKE_SOURCE_DIR}/cmake/vld)
		link_directories(${CMAKE_SOURCE_DIR}/cmake/vld)
		add_custom_target(__vld ALL COMMENT "memory leak check!")
		__set_target_folder(__vld CMakePredefinedTargets) 
		add_custom_command(TARGET __vld PRE_BUILD
			COMMAND ${CMAKE_COMMAND} -E make_directory ${BIN_OUTPUT_DIR}/Debug/
			COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/cmake/vld/vld_x64.dll ${BIN_OUTPUT_DIR}/Debug/
			COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/cmake/vld/dbghelp.dll ${BIN_OUTPUT_DIR}/Debug/
			COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/cmake/vld/Microsoft.DTfW.DHL.manifest ${BIN_OUTPUT_DIR}/Debug/
			)
		set(CXX_VLD_ENABLED "ON")
	endif()
endmacro()

if(CMAKE_VLD_ON)
	__enable_vld()
endif()