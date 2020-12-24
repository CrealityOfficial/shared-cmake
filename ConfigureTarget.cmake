set(BIN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/../bin")
set(LIB_OUTPUT_DIR "${CMAKE_BINARY_DIR}/../lib")
set(LIB_DEBUG_PATH ${LIB_OUTPUT_DIR}/Debug/)
set(LIB_RELEASE_PATH ${LIB_OUTPUT_DIR}/Release/)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
#config targets, separate src, lib, bin

set(global_all_targets)
set(global_all_targets "" CACHE STRING INTERNAL FORCE)

if(${CMAKE_VERSION} VERSION_LESS 3.4)
	include(CMakeParseArguments)
endif()

macro(configure_target target)
	set_target_properties(${target} PROPERTIES
						LIBRARY_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
						ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
						RUNTIME_OUTPUT_DIRECTORY_DEBUG "${BIN_OUTPUT_DIR}/Debug/"
						LIBRARY_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
						ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
						RUNTIME_OUTPUT_DIRECTORY_RELEASE "${BIN_OUTPUT_DIR}/Release/"
						)
endmacro()

macro(add_top_target target)
	list(APPEND global_all_targets ${target})
	list(REMOVE_DUPLICATES global_all_targets)
endmacro()

macro(__add_target target)
	list(APPEND global_all_targets ${target})
	list(REMOVE_DUPLICATES global_all_targets)
	set(global_all_targets ${global_all_targets} CACHE STRING INTERNAL FORCE)
endmacro()

macro(__configure_all)
	foreach(target ${global_all_targets})
		configure_target(${target})
	endforeach()
endmacro()

macro(__debug_all_configurations)
	foreach(target ${global_all_targets})
		get_target_property(DEBUG_RUNTIME_DIR ${target} RUNTIME_OUTPUT_DIRECTORY_DEBUG)
		get_target_property(RELEASE_RUNTIME_DIR ${target} RUNTIME_OUTPUT_DIRECTORY_RELEASE)
		message(STATUS "${target} ${DEBUG_RUNTIME_DIR}")
		message(STATUS "${target} ${RELEASE_RUNTIME_DIR}")
	endforeach()
endmacro()

include(Dependency)
#target function
function(__add_real_target target type)
	cmake_parse_arguments(target "" "" "SOURCE;INC;LIB;DEF;DEP;INTERFACE;FOLDER;PCH" ${ARGN})
	if(target_SOURCE)
		#target
		#message(STATUS "target_SOURCE ${target_SOURCE}")
		set(ExtraSrc)
		if(CXX_VLD_ENABLED STREQUAL "ON")
			list(APPEND ExtraSrc ${CMAKE_SOURCE_DIR}/cmake/source/__vld.cpp)
		endif()
		
		if(${type} STREQUAL "exe")
			add_executable(${target} ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "winexe")
			add_executable(${target} WIN32 ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "dll")
			add_library(${target} SHARED ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "lib")
			add_library(${target} STATIC ${target_SOURCE} ${ExtraSrc})
		else()
			add_executable(${target} ${target_SOURCE} ${ExtraSrc})
		endif()
		__add_target(${target})
		#libs
		if(target_LIB)
			foreach(lib ${target_LIB})
				target_link_libraries(${target} PRIVATE ${lib})
				#message(STATUS ${lib}) 	
			endforeach()
		endif()
		#incs
		if(target_INC)
			foreach(inc ${target_INC})
				target_include_directories(${target} PRIVATE ${inc})
				#message(STATUS ${inc}) 	
			endforeach()
		endif()
		#def
		if(target_DEF)
			foreach(def ${target_DEF})
				target_compile_definitions(${target} PRIVATE ${def})
				#message(STATUS ${def}) 	
			endforeach()
		endif()
		#dep
		if(target_DEP)
			__add_target_dependency(${target} DEP ${target_DEP})
		endif()
		if(target_INTERFACE)
			set_property(TARGET ${target} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${target_INTERFACE})
		endif()
		if(target_FOLDER)
			set_target_properties(${target} PROPERTIES FOLDER ${target_FOLDER})
		endif()
		if(target_PCH)
			set(pchs)
			foreach(pch ${target_PCH})
				list(APPEND pchs ${pch})	
			endforeach()
			target_precompile_headers(${target} PUBLIC ${pchs})
			target_compile_definitions(${target} PRIVATE ${target}_USE_PCH)
		endif()
		
		if(ENABLE_CXX_PCH)
			target_precompile_headers(${target} PUBLIC ${CMAKE_SOURCE_DIR}/cmake/source/leak.h)
			target_compile_definitions(${target} PRIVATE ${target}_USE_PCH)
		endif()
				
		if(CXX_VLD_ENABLED STREQUAL "ON")
			add_dependencies(${target} __vld)
		endif()
		
		configure_target(${target})
	else(target_SOURCE)
		message("add target ${target} without sources")
	endif(target_SOURCE)
endfunction()

function(build_inner target)
	__add_target(${target})
	cmake_parse_arguments(build_inner "" "" "SOURCE;LIB;DEF" ${ARGN})
	if(build_inner_LIB)
		foreach(lib ${build_inner_LIB})
			target_link_libraries(${target} PRIVATE ${lib})
			#message(STATUS ${lib}) 	
		endforeach()
	endif()
	if(build_inner_DEF)
		foreach(def ${build_inner_DEF})
			target_compile_definitions(${target} PRIVATE ${def})
			#message(STATUS ${def}) 	
		endforeach()
	endif()
endfunction()

function(__add_executable target)
	cmake_parse_arguments(target_description "" "" "SOURCE;LIB;DEF" ${ARGN})
	if(target_description_SOURCE)
		#message(STATUS ${target_description_SOURCE})
		add_executable(${target} ${target_description_SOURCE})
		build_inner(${target} ${ARGN})
	else(target_description_SOURCE)
		message(FATAL_ERROR "add target ${target} without sources")
	endif()
endfunction()

function(__add_shared_lib target)
	cmake_parse_arguments(target_description "" "" "SOURCE;LIB;DEF" ${ARGN})
	if(target_description_SOURCE)
		add_library(${target} SHARED ${target_description_SOURCE})
		build_inner(${target} ${ARGN})
	else(target_description_SOURCE)
		message(FATAL_ERROR "add target ${target} without sources")
	endif()
endfunction()

macro(__import_target target type)
	message("${target}...........")
	if (NOT TARGET ${target})		
		if(${type} STREQUAL "dll")
			add_library(${target} SHARED IMPORTED)
		else()
			add_library(${target} STATIC IMPORTED)
		endif()
		
		set_property(TARGET ${target} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${${target}_INCLUDE_DIRS})
		set_property(TARGET ${target} APPEND PROPERTY IMPORTED_CONFIGURATIONS "Debug")
		set_property(TARGET ${target} APPEND PROPERTY IMPORTED_CONFIGURATIONS "Release")
		
		set_target_properties(${target} PROPERTIES IMPORTED_IMPLIB_DEBUG ${${target}_LIBRARIES_DEBUG})
		set_target_properties(${target} PROPERTIES IMPORTED_IMPLIB_RELEASE ${${target}_LIBRARIES_RELEASE})
		
		set_target_properties(${target} PROPERTIES IMPORTED_LOCATION_DEBUG ${${target}_LIBRARIES_DEBUG})
		set_target_properties(${target} PROPERTIES IMPORTED_LOCATION_RELEASE ${${target}_LIBRARIES_RELEASE})
	endif()
endmacro()

macro(__find_simple_package target type)
	if(${target}_INCLUDE_DIR)
		set(${target}_INCLUDE_DIRS ${${target}_INCLUDE_DIR})
	endif()

	find_library(${target}_LIBRARIES_DEBUG
				 NAMES ${target}
				 HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
				 PATHS "/usr/lib/Debug")
				 
	find_library(${target}_LIBRARIES_RELEASE
			 NAMES ${target}
			 HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
			 PATHS "/usr/lib/Release")
				 
	message("${target}_INCLUDE_DIR  ${${target}_INCLUDE_DIR}")
	message("${target}_LIBRARIES_DEBUG  ${${target}_LIBRARIES_DEBUG}")
	message("${target}_LIBRARIES_RELEASE  ${${target}_LIBRARIES_RELEASE}")

	if(${target}_INCLUDE_DIRS AND ${target}_LIBRARIES_DEBUG AND ${target}_LIBRARIES_RELEASE)
		set(${target}_FOUND "True")
		__import_target(${target} ${type})
	endif()
endmacro()

macro(__find_one_package target inc type env)
	message(STATUS ${target})
	find_path(${target}_INCLUDE_DIR ${inc}
		HINTS  "$ENV{${env}}/include"
		PATHS "/usr/include")
	
	if(${target}_INCLUDE_DIR)
		set(${target}_INCLUDE_DIRS ${${target}_INCLUDE_DIR})
	endif()
	
	find_library(${target}_LIBRARIES_DEBUG
				 NAMES ${target}
				 HINTS "$ENV{${env}}/lib/Debug"
				 PATHS "/usr/lib/Debug")
				 
	find_library(${target}_LIBRARIES_RELEASE
			 NAMES ${target}
			 HINTS "$ENV{${env}}/lib/Release"
			 PATHS "/usr/lib/Release")
				 
	message("${target}_INCLUDE_DIR  ${${target}_INCLUDE_DIR}")
	message("${target}_LIBRARIES_DEBUG  ${${target}_LIBRARIES_DEBUG}")
	message("${target}_LIBRARIES_RELEASE  ${${target}_LIBRARIES_RELEASE}")
	
	if(${target}_INCLUDE_DIRS AND ${target}_LIBRARIES_DEBUG AND ${target}_LIBRARIES_RELEASE)
		set(${target}_FOUND "True")
		__import_target(${target} ${type})
	endif()
endmacro()

macro(__find_vld)
	if(WIN32)
		find_path(vld_INCLUDE_DIR vld/vld.h
			HINTS  "$ENV{CX_THIRDPARTY_ROOT}/include/"
			PATHS "/usr/include")
		
		if(vld_INCLUDE_DIR)
			set(vld_INCLUDE_DIRS ${vld_INCLUDE_DIR})
		endif()
		
		find_library(vld_LIBRARIES_DEBUG
					NAMES vld
					HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
					PATHS "/usr/lib/Debug")
					
		find_library(vld_LIBRARIES_RELEASE
				NAMES vld
				HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
				PATHS "/usr/lib/Release")
					
		message("vld_INCLUDE_DIR  ${vld_INCLUDE_DIRS}")
		message("vld_LIBRARIES_DEBUG  ${vld_LIBRARIES_DEBUG}")
		message("vld_LIBRARIES_RELEASE  ${vld_LIBRARIES_RELEASE}")
		
		if(vld_INCLUDE_DIRS AND vld_LIBRARIES_DEBUG AND vld_LIBRARIES_RELEASE)
			__import_target(vld dll)
		endif()
	endif()
endmacro()


