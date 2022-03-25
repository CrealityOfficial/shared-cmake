set(USER_BINARY_DIR ${CMAKE_BINARY_DIR}/..)

set(BIN_OUTPUT_DIR "${USER_BINARY_DIR}/bin")
set(LIB_OUTPUT_DIR "${USER_BINARY_DIR}/lib")
set(LIB_DEBUG_PATH ${LIB_OUTPUT_DIR}/Debug/)
set(LIB_RELEASE_PATH ${LIB_OUTPUT_DIR}/Release/)

message(STATUS "bin : ${BIN_OUTPUT_DIR}")
message(STATUS "lib : ${LIB_OUTPUT_DIR}")

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR})
#config targets, separate src, lib, bin

set(global_all_targets)
set(global_all_targets "" CACHE STRING INTERNAL FORCE)

set(MACOS_PREFIX "${PROJECT_NAME}.app/Contents")
set(MACOS_INSTALL_RUNTIME_DIR "${MACOS_PREFIX}/MacOS")
set(MACOS_INSTALL_CMAKE_DIR "${MACOS_PREFIX}/Resources")
set(MACOS_INSTALL_PLUGIN_DIR "${MACOS_PREFIX}/PlugIns")
set(MACOS_INSTALL_LIB_DIR "${MACOS_PREFIX}/Frameworks")
		
if(${CMAKE_VERSION} VERSION_LESS 3.4)
	include(CMakeParseArguments)
endif()

if(ANDROID)
	find_library(log-lib log)
	find_library(libandroid android)
	
	message(STATUS "Android find log ${log-lib}")
	set(ANDROID_LIBS ${log-lib} ${libandroid})
endif()

macro(configure_target target)
	if(CC_BC_WIN)
		set_target_properties(${target} PROPERTIES
							LIBRARY_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
							ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
							RUNTIME_OUTPUT_DIRECTORY_DEBUG "${BIN_OUTPUT_DIR}/Debug/"
							LIBRARY_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
							ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
							RUNTIME_OUTPUT_DIRECTORY_RELEASE "${BIN_OUTPUT_DIR}/Release/"
							)
	elseif(CC_BC_MAC)
		set_target_properties(${target} PROPERTIES
						LIBRARY_OUTPUT_DIRECTORY_DEBUG "${BIN_OUTPUT_DIR}/Debug/"
						ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
						RUNTIME_OUTPUT_DIRECTORY_DEBUG "${BIN_OUTPUT_DIR}/Debug/"
						LIBRARY_OUTPUT_DIRECTORY_RELEASE "${BIN_OUTPUT_DIR}/Release/"
						ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
						RUNTIME_OUTPUT_DIRECTORY_RELEASE "${BIN_OUTPUT_DIR}/Release/"
						)
	elseif(CC_BC_ANDROID)
		set_target_properties(${target} PROPERTIES
						LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
						ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
						RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
						)
	elseif(CC_BC_LINUX)
		set_target_properties(${target} PROPERTIES
					LIBRARY_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
					ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${LIB_OUTPUT_DIR}/Debug/"
					RUNTIME_OUTPUT_DIRECTORY_DEBUG "${BIN_OUTPUT_DIR}/Debug/"
					LIBRARY_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
					ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${LIB_OUTPUT_DIR}/Release/"
					RUNTIME_OUTPUT_DIRECTORY_RELEASE "${BIN_OUTPUT_DIR}/Release/"
					)
	endif()
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
	cmake_parse_arguments(target "SOURCE_FOLDER;OPENMP;DEPLOYQT;MAC_DEPLOYQT" "" "SOURCE;INC;LIB;DEF;DEP;INTERFACE;FOLDER;PCH;OBJ;QTUI;QTQRC;MAC_ICON;MAC_OUTPUTNAME;MAC_GUI_IDENTIFIER" ${ARGN})
	if(target_SOURCE)
		#target
		#message(STATUS "target_SOURCE ${target_SOURCE}")
		set(ExtraSrc)
		if(CXX_VLD_ENABLED STREQUAL "ON")
			list(APPEND ExtraSrc ${CMAKE_SOURCE_DIR}/cmake/source/__vld.cpp)
		endif()
		
		message(STATUS "add test __add_real_target ${target}-----------------------> ${type}")
		
		if(target_SOURCE_FOLDER)
			__collect_assign_source_group(${target_SOURCE})
		endif()
		if(target_QTUI AND TARGET Qt${QT_VERSION_MAJOR}::Core)
			qt5_wrap_ui(UI_VAR ${target_QTUI})
			list(APPEND target_SOURCE ${UI_VAR})
			message(STATUS "QTUI ${UI_VAR}")
		endif()
		if(target_QTQRC AND TARGET Qt${QT_VERSION_MAJOR}::Core)
			qt5_add_resources(QT_QRC ${target_QTQRC})
			list(APPEND target_SOURCE ${QT_QRC})
		endif()
		
		if(target_OPENMP)
			if(TARGET OpenMP::OpenMP_CXX)
				set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
				set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
				set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
			endif()
		endif()
		
		if(CC_BC_MAC)
			if(target_MAC_ICON)
				set_source_files_properties(${target_MAC_ICON} PROPERTIES
					MACOSX_PACKAGE_LOCATION "Resources")
				list(APPEND ExtraSrc ${target_MAC_ICON})
			endif()
		endif()
			
		if(${type} STREQUAL "exe")
			add_executable(${target} ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "winexe")
			add_executable(${target} WIN32 ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "bundle")
			add_executable(${target} MACOSX_BUNDLE ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "dll")
			add_library(${target} SHARED ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "lib")
			add_library(${target} STATIC ${target_SOURCE} ${ExtraSrc})
		elseif(${type} STREQUAL "obj")
			add_library(${target} OBJECT ${target_SOURCE})
		else()
			add_library(${target} STATIC ${target_SOURCE} ${ExtraSrc})
		endif()
		__add_target(${target})
		
		#message(STATUS "${target} set mac properties MACOSX_BUNDLE_GUI_IDENTIFIER ${target_MAC_GUI_IDENTIFIER}")
		#if(target_MAC_DEPLOYQT)
		#	message(STATUS "${target} target_MAC_DEPLOYQT")
		#endif()
        if(CC_BC_MAC)			
		    set_target_properties(${target} PROPERTIES
				MACOSX_BUNDLE TRUE
			)
			if(target_MAC_OUTPUTNAME)
				message(STATUS "${target} set mac properties OUTPUT_NAME ${target_MAC_OUTPUTNAME}")
				set_target_properties(${target} PROPERTIES
						OUTPUT_NAME ${target_MAC_OUTPUTNAME}
				)
			endif()
			if(target_MAC_GUI_IDENTIFIER)
				message(STATUS "${target} set mac properties MACOSX_BUNDLE_GUI_IDENTIFIER ${target_MAC_GUI_IDENTIFIER}")
				set_target_properties(${target} PROPERTIES
					MACOSX_BUNDLE_GUI_IDENTIFIER ${target_MAC_GUI_IDENTIFIER}
				)
			endif()
			if(target_MAC_DEPLOYQT AND TARGET Qt${QT_VERSION_MAJOR}::Core)
				if(${type} STREQUAL "exe")
					message(STATUS "Mac ${target} deploy qt.")
					__mac_deploy_target_qt(${target})
				else()
					message(STATUS "Mac not support depoly qt except bundle.")
				endif()
			endif()
        endif()
		#libs
		if(target_AUTOQT)
			set_target_properties(${target} PROPERTIES 
											AUTOMOC ON
											AUTORCC ON
											AUTOUIC ON
											)
		endif()
		if(target_LIB)
			foreach(lib ${target_LIB})
				target_link_libraries(${target} PRIVATE ${lib})
				#message(STATUS ${lib}) 	
			endforeach()
		endif()
		if(ANDROID)
			target_link_libraries(${target} PRIVATE ${log-lib})
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
		
		if(target_OPENMP)
			if(TARGET OpenMP::OpenMP_CXX)
				target_link_libraries(${target} PRIVATE OpenMP::OpenMP_CXX)
			endif()
		endif()
		
		if(NOT CC_BC_MAC AND target_DEPLOYQT AND TARGET Qt${QT_VERSION_MAJOR}::Core)
			__deploy_target_qt(${target})
		endif()
		
		if(ENABLE_CXX_PCH)
			target_precompile_headers(${target} PUBLIC ${CMAKE_SOURCE_DIR}/cmake/source/leak.h)
			target_compile_definitions(${target} PRIVATE ${target}_USE_PCH)
		endif()
				
		if(CXX_VLD_ENABLED STREQUAL "ON")
			add_dependencies(${target} __vld)
		endif()
		
		if(SPYCC_LIB)
			target_link_libraries(${target} PRIVATE ${SPYCC_LIB})
		endif()

		configure_target(${target})
		
		get_property(NOT_INSTALL_IMPORT GLOBAL PROPERTY GLOBAL_NOT_INSTALL_IMPORT)
		if((CMAKE_BUILD_TYPE MATCHES "Release") AND (NOT NOT_INSTALL_IMPORT) AND (NOT ${type} STREQUAL "lib"))
			if(WIN32)
				INSTALL(TARGETS ${target} RUNTIME DESTINATION .)
			elseif(APPLE)
				INSTALL(TARGETS ${target}
					BUNDLE DESTINATION . COMPONENT Runtime
					RUNTIME DESTINATION ${MACOS_INSTALL_RUNTIME_DIR}
					FRAMEWORK DESTINATION ${MACOS_INSTALL_LIB_DIR}
					ARCHIVE DESTINATION ${MACOS_INSTALL_LIB_DIR}
					LIBRARY DESTINATION ${MACOS_INSTALL_LIB_DIR}
				)
			elseif(UNIX)
				#INSTALL(TARGETS ${target} RUNTIME DESTINATION bin LIBRARY DESTINATION lib)
			endif()
		endif()
	else(target_SOURCE)
		message("add target ${target} without sources")
	endif(target_SOURCE)
endfunction()

macro(__add_real_library target)
	if(BUILD_SHARED_LIBS)
		__add_real_target(${target} dll ${ARGN})
	else()
		__add_real_target(${target} lib ${ARGN})
	endif()
endmacro()

macro(__add_platform_library target)
	cmake_parse_arguments(target "OPENMP" "" "" ${ARGN})
	if(target_OPENMP)
		if(TARGET OpenMP::OpenMP_CXX)
			list(APPEND LIBS OpenMP::OpenMP_CXX)
			set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
			set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
			set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
		endif()
	endif()
	if(NOT INTERFACES)
		set(INTERFACES ${CMAKE_CURRENT_SOURCE_DIR})
		if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include")
			list(APPEND INTERFACES ${CMAKE_CURRENT_SOURCE_DIR}/include)
		endif()
	endif()
	
	if(CC_BUILD_IPHONE_PLATFORM OR CC_PLATFORM_STATIC_BUILD)
		__add_real_target(${target} lib SOURCE ${SRCS} 
										LIB ${LIBS}
										INC ${INCS}
										DEF ${DEFS}
										INTERFACE ${INTERFACES}
										SOURCE_FOLDER
										)
	else()
		string(TOUPPER ${target} UpperName)
		list(APPEND DEFS ${UpperName}_DLL)
		__add_real_target(${target} dll SOURCE ${SRCS} 
										LIB ${LIBS}
										INC ${INCS}
										DEF ${DEFS}
										INTERFACE ${INTERFACES}
										SOURCE_FOLDER
										)
	endif()
endmacro()

function(__add_exe_target target)
	__add_real_target(${target} exe ${ARGN})
	if(WIN32)
		set_target_properties(${target} PROPERTIES LINK_FLAGS_RELEASE "/SUBSYSTEM:WINDOWS /ENTRY:mainCRTStartup")
		set_target_properties(${target} PROPERTIES LINK_FLAGS_DEBUG "/SUBSYSTEM:CONSOLE /ENTRY:mainCRTStartup")
	endif()
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
	if (NOT TARGET ${target})		
		if(${type} STREQUAL "dll")
			add_library(${target} SHARED IMPORTED GLOBAL)
		else()
			add_library(${target} STATIC IMPORTED GLOBAL)
		endif()
		
		set_property(TARGET ${target} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${${target}_INCLUDE_DIRS})
		set_property(TARGET ${target} APPEND PROPERTY IMPORTED_CONFIGURATIONS "Debug")
		set_property(TARGET ${target} APPEND PROPERTY IMPORTED_CONFIGURATIONS "Release")
		
		if(NOT CC_BC_LINUX)
			set_target_properties(${target} PROPERTIES IMPORTED_IMPLIB_DEBUG ${${target}_LIBRARIES_DEBUG})
			set(IMPORT_LOC_DEBUG ${${target}_LIBRARIES_DEBUG})
		endif()
		
		set_target_properties(${target} PROPERTIES IMPORTED_IMPLIB_RELEASE ${${target}_LIBRARIES_RELEASE})
		set(IMPORT_LOC_RELEASE ${${target}_LIBRARIES_RELEASE})

		if(WIN32 AND ${type} STREQUAL "dll")
			set(IMPORT_LOC_DEBUG "$ENV{USR_INSTALL_ROOT}/bin/Debug/${target}.dll")
			set(IMPORT_LOC_RELEASE "$ENV{USR_INSTALL_ROOT}/bin/Release/${target}.dll")
			if(${target}_LOC_DEBUG)
				set(IMPORT_LOC_DEBUG ${${target}_LOC_DEBUG})
			endif()
			if(${target}_LOC_RELEASE)
				set(IMPORT_LOC_RELEASE ${${target}_LOC_RELEASE})
			endif()
		endif()
		
		if(NOT CC_BC_LINUX)
			message(STATUS "${target} IMPORTED_LOCATION_DEBUG -> [${IMPORT_LOC_DEBUG}]")
			set_target_properties(${target} PROPERTIES IMPORTED_LOCATION_DEBUG ${IMPORT_LOC_DEBUG})
		endif()
		
		message(STATUS "${target} IMPORTED_LOCATION_RELEASE -> [${IMPORT_LOC_RELEASE}]")
		set_target_properties(${target} PROPERTIES IMPORTED_LOCATION_RELEASE ${IMPORT_LOC_RELEASE})
		
		get_property(NOT_INSTALL_IMPORT GLOBAL PROPERTY GLOBAL_NOT_INSTALL_IMPORT)
		message(STATUS "GLOBAL_NOT_INSTALL_IMPORT ---->[${NOT_INSTALL_IMPORT}]")
		if((${type} STREQUAL "dll") AND NOT NOT_INSTALL_IMPORT)
			__copy_find_targets(${target})
		endif()
	endif()
endmacro()

macro(__import_target_signle target type)
	message("${target}...........")
	if (NOT TARGET ${target})		
		if(${type} STREQUAL "dll")
			add_library(${target} SHARED IMPORTED)
		else()
			add_library(${target} STATIC IMPORTED)
		endif()
		
		set_property(TARGET ${target} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${${target}_INCLUDE_DIRS})
		
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

macro(__find_one_package target inc prefix type env)
	find_path(${target}_INCLUDE_DIR ${inc}
		HINTS  "$ENV{${env}}/include/${prefix}"
		PATHS "/usr/include/${prefix}" "/usr/local/include/${prefix}"
		NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH
		)
	
	if(${target}_INCLUDE_DIR)
		set(${target}_INCLUDE_DIRS ${${target}_INCLUDE_DIR})
	endif()
	
	find_library(${target}_LIBRARIES_DEBUG
				 NAMES ${target}
				 HINTS "$ENV{${env}}/lib/Debug"
				 PATHS "/usr/lib/Debug" "/usr/local/lib/Debug" "/usr/lib/x86_64-linux-gnu"
				 NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH)
				 
	find_library(${target}_LIBRARIES_RELEASE
			 NAMES ${target}
			 HINTS "$ENV{${env}}/lib/Release"
			 PATHS "/usr/lib/Release" "/usr/local/lib/Release" "/usr/lib/x86_64-linux-gnu"
			 NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH)
				 
	message("${target}_INCLUDE_DIR  ${${target}_INCLUDE_DIR}")
	message("${target}_LIBRARIES_DEBUG  ${${target}_LIBRARIES_DEBUG}")
	message("${target}_LIBRARIES_RELEASE  ${${target}_LIBRARIES_RELEASE}")
	
	if(${target}_INCLUDE_DIRS AND ${target}_LIBRARIES_DEBUG AND ${target}_LIBRARIES_RELEASE)
		set(${target}_FOUND "True")
		__import_target(${target} ${type})
		message(STATUS "${target} include : ${${target}_INCLUDE_DIRS}")
		message(STATUS "${target} lib debug : ${${target}_LIBRARIES_DEBUG}")
		message(STATUS "${target} lib release : ${${target}_LIBRARIES_RELEASE}")
	else()
		message(FATAL_ERROR "${target} not found!")
	endif()
endmacro()

macro(__include_dir target inc prefix env)
	find_path(${target}_INCLUDE_DIR ${inc}
		HINTS  "$ENV{${env}}/include/${prefix}"
		PATHS "/usr/include/${prefix}")
	
	if(${target}_INCLUDE_DIR)
		message(STATUS "${target} include : ${${target}_INCLUDE_DIR}")
	else()
		message(FATAL_ERROR "${target} include not found!")
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

macro(__assert_target target)
	if(NOT TARGET ${target})
		message(FATAL_ERROR "assert ${target} exist.")
	endif()
endmacro()

macro(__check_target_return target)
	if(TARGET ${target})
		return()
	endif()
endmacro()

macro(__remap_target_debug_2_release targets)
	foreach(target ${${targets}})
		#message(STATUS "__remap_target_debug_2_release : ${target}")
		if(TARGET ${target})
			get_target_property(DEBUG_IMPORTED_LIB ${target} "IMPORTED_IMPLIB_DEBUG")
			get_target_property(RELEASE_IMPORTED_LIB ${target} "IMPORTED_IMPLIB_RELEASE")
			message(STATUS "remap target ${target} implib ${DEBUG_IMPORTED_LIB} --> ${RELEASE_IMPORTED_LIB}")
			set_target_properties(${target} PROPERTIES "IMPORTED_IMPLIB_DEBUG" ${RELEASE_IMPORTED_LIB})
		endif()
	endforeach()
endmacro()

function(__add_emcc_target target)
	cmake_parse_arguments(target "DEBUG" "IDLS;IDLINCS" "CSOURCE;LIBRARIES;WSAM_ARGS;" ${ARGN})
	set(LIBRARIES)
	if(target_LIBRARIES)
		#message(STATUS "__add_emcc_target LIBRARIES : ${target_LIBRARIES}")
		
		foreach(LIB ${target_LIBRARIES})
			list(APPEND LIBRARIES $<TARGET_FILE:${LIB}>)
		endforeach()
	endif()
	
	if(target_CSOURCE)
		#message(STATUS "__add_emcc_target CSOURCE : ${target_CSOURCE}")
		set(INTERFACE_LIBS)
		if(target_LIBRARIES)
			set(INTERFACE_LIBS ${target_LIBRARIES})
		endif()
		__add_real_target(${target}_interface lib SOURCE ${target_CSOURCE}
												  LIB ${INTERFACE_LIBS}
												  INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
												  )
												  
		list(APPEND LIBRARIES $<TARGET_FILE:${target}_interface>)
	endif()
	
	message(STATUS "__add_emcc_target LIBRARIES : ${LIBRARIES}")
	
	set(EXTRA_ARGS -s EXPORT_NAME="${target}")
	if(target_DEBUG)
		list(APPEND EXTRA_ARGS -gseparate-dwarf=${target}.debug.wasm)
	endif()
	
	if(target_IDLS AND NOT MSVC)
		message(STATUS "__add_emcc_target IDLS : ${target_IDLS}")
		
		set(GLUE_ARGS -c
					  -I${CMAKE_BINARY_DIR}
					  -I${CMAKE_CURRENT_BINARY_DIR}
					  -I${CMAKE_CURRENT_SOURCE_DIR}
					  -I${CMAKE_SOURCE_DIR}/cmake
					  )
		
		if(target_IDLINCS)
			message(STATUS "__add_emcc_target IDLINCS : ${target_IDLINCS}")
			list(APPEND GLUE_ARGS -include${target_IDLINCS})
		endif()
		
		if(target_LIBRARIES)
			foreach(LIB ${target_LIBRARIES})
				get_target_property(INCLUDE_DIRS ${LIB} INTERFACE_INCLUDE_DIRECTORIES)
				if(INCLUDE_DIRS)
					foreach(inc ${INCLUDE_DIRS})
						list(APPEND GLUE_ARGS -I${inc})
					endforeach()
				endif()
			endforeach()
		endif()
		
		message(STATUS "__add_emcc_target GLUE_ARGS : ${GLUE_ARGS}")
		add_custom_command(
			OUTPUT ${target_IDLS}.cpp ${target_IDLS}.js
			BYPRODUCTS parser.out WebIDLGrammar.pkl
			COMMAND ${PYTHON} ${WEBIDL_BINDER_SCRIPT} ${CMAKE_CURRENT_SOURCE_DIR}/${target_IDLS} ${target_IDLS}
			COMMENT "Generating ${target_IDLS} WebIDL bindings"
			VERBATIM)
		
		add_custom_command(
			OUTPUT ${target_IDLS}.o
			COMMAND emcc ${target_IDLS}.cpp ${GLUE_ARGS} -o ${target_IDLS}.o
			DEPENDS ${target_IDLS}.cpp
			COMMENT "Building bindings"
			VERBATIM)	
		
		list(APPEND LIBRARIES ${target_IDLS}.o)
		set(EXTRA_ARGS --post-js ${target_IDLS}.js ${EXTRA_ARGS})
		message(STATUS ${EXTRA_ARGS})
	endif()
	
	set(WARGS  #default args
	    #-Wl,--shared-memory,--no-check-features
		-s MODULARIZE=1
		-s ALLOW_MEMORY_GROWTH=1
		#-s TOTAL_MEMORY=512MB
		-s ALLOW_TABLE_GROWTH=1
		-s EXPORTED_RUNTIME_METHODS=["addFunction","UTF8ToString","FS"]
		-s DISABLE_EXCEPTION_CATCHING=1
		-s EXCEPTION_DEBUG=1
		#-s USE_PTHREADS=0
		#-s PTHREAD_POOL_SIZE_STRICT=0
		-s SUPPORT_LONGJMP=1
		-s ASSERTIONS=1
		-s SAFE_HEAP=1
		-s USE_SDL=0
		-s ENVIRONMENT=worker
		-s NO_FILESYSTEM=0)
		
	if(target_WSAM_ARGS)
		#message(STATUS "__add_emcc_target WSAM_ARGS : ${target_WSAM_ARGS}")
		set(WARGS ${WARGS} ${target_WSAM_ARGS})
	endif()
	
	if(NOT MSVC)
		add_custom_command(
			OUTPUT ${target}.js ${target}.wasm
			COMMAND emcc ${LIBRARIES} ${EXTRA_ARGS} ${WARGS} -o ${target}.js
			DEPENDS ${LIBRARIES}
			COMMENT "Building ${target} WASM"
			VERBATIM)
		add_custom_target(${target} 
			ALL 
			DEPENDS ${target}.js ${target}.wasm)
		if(target_DEBUG)
			add_custom_command(
				TARGET ${target}
				POST_BUILD
				COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.js
					${BIN_OUTPUT_DIR}/Debug/${target}.js
				COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.wasm
					${BIN_OUTPUT_DIR}/Debug/${target}.wasm
				COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.debug.wasm
					${BIN_OUTPUT_DIR}/Debug/${target}.debug.wasm	    
				)
		else()
		add_custom_command(
			TARGET ${target}
			POST_BUILD
			COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.js
				${BIN_OUTPUT_DIR}/Release/${target}.js
			COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/${target}.wasm
				${BIN_OUTPUT_DIR}/Release/${target}.wasm    
			)
		endif()
	endif()
endfunction()

