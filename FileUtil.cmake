macro(__source_recurse dir src)
	file(GLOB_RECURSE _tmp_list ${dir}/*.h ${dir}/*.hpp ${dir}/*.cpp ${dir}/*.c ${dir}/*.inl)
	set(${src} ${_tmp_list})
	#message("${${src}}")
endmacro()

macro(__files_group dir src)   #support 2 level
	file(GLOB _src ${dir}/*.h ${dir}/*.cpp ${dir}/*.cc ${sub_dir}/*.c)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir})
			file(GLOB sub_src ${sub_dir}/*.h ${sub_dir}/*.cpp ${sub_dir}/*.cc ${sub_dir}/*.c)
			source_group(${child} FILES ${sub_src})
			set(_src ${_src} ${sub_src})
		endif()
	endforeach()
	set(${src} ${_src})
endmacro()

macro(__files_group_2 dir folder src)   #support 2 level
	file(GLOB _src ${dir}/*.h ${dir}/*.cpp)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir})
			file(GLOB sub_src ${sub_dir}/*.h ${sub_dir}/*.cpp)
			source_group(${folder}/${child} FILES ${sub_src})
			set(_src ${_src} ${sub_src})
		endif()
	endforeach()
	set(${src} ${_src})
endmacro()

macro(__files_group_c dir src)   #support 2 level
	file(GLOB _src ${dir}/*.c)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir})
			file(GLOB sub_src ${sub_dir}/*.c)
			source_group(${child} FILES ${sub_src})
			set(_src ${_src} ${sub_src})
		endif()
	endforeach()
	set(${src} ${_src})
endmacro()

function(__recursive_add_subdirectory dir)
	file(GLOB children RELATIVE ${dir} ${dir}/*)
	foreach(child ${children})
		set(sub_dir ${dir}/${child})
		if(IS_DIRECTORY ${sub_dir} AND EXISTS ${sub_dir}/CMakeLists.txt)
			add_subdirectory(${sub_dir})
		endif()
	endforeach()
endfunction()

macro(__get_file_name path name)
	STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" ${name} ${path})
endmacro()

macro(__add_all_directory)
	__recursive_add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR})
endmacro()

macro(__build_info_header)
	string(TIMESTAMP BUILD_TIME "%y_%m_%d_%H_%M")
	set(BUILD_INFO_HEAD "${PROJECT_NAME}_${BUILD_TIME}")
	set(DEBUG_RESOURCES_DIR "${BIN_OUTPUT_DIR}/Debug/resources/")
	set(RELEASE_RESOURCES_DIR "${BIN_OUTPUT_DIR}/Release/resources/")
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/buildinfo.h.prebuild
               ${CMAKE_BINARY_DIR}/buildinfo.h)
endmacro()

function(__scope_add tlist item)
	list(APPEND ${tlist} ${item})
	list(REMOVE_DUPLICATES ${tlist})
	#set(${tlist} ${${tlist}} CACHE STRING INTERNAL FORCE)
endfunction()

macro(__duplicates_add tlist item)
	list(APPEND ${tlist} ${item})
	list(REMOVE_DUPLICATES ${tlist})
endmacro()

macro(__assign_source_group dir)
    foreach(_source IN ITEMS ${ARGN})
        if (IS_ABSOLUTE "${_source}")
            file(RELATIVE_PATH _source_rel "${dir}" "${_source}")
        else()
            set(_source_rel "${_source}")
        endif()
        get_filename_component(_source_path "${_source_rel}" PATH)
		
		#message(STATUS ${_source_path})
        string(REPLACE "/" "\\" _source_path_msvc "${_source_path}")
        source_group("${_source_path_msvc}" FILES "${_source}")
    endforeach()
endmacro()

macro(__gather_source dir DEST_SOURCE)
	file(GLOB_RECURSE ${DEST_SOURCE} RELATIVE "${dir}" "*.cpp" "*.h" "*.c" "*.cc" "*.hpp" "*.CPP" "*.hxx" "*.cxx")
endmacro()

macro(__tree_add_source dir src)
	file(GLOB_RECURSE _SRCS RELATIVE "${dir}" "*.cpp" "*.h" "*.c" "*.cc" "*.hpp" "*.CPP" "*.hxx" "*.cxx")
	__assign_source_group(${dir} ${_SRCS})
	
	#message(STATUS ${dir})
	#message(STATUS ${_SRCS})
	#message(STATUS "${${src}}")
	foreach(item ${_SRCS})
		list(APPEND ${src} "${dir}/${item}")
		#message(STATUS "${${src}}")
	endforeach()
	
	#foreach(item ${${src}})
	#	message(STATUS "${item}")
	#endforeach()
		
	#message(STATUS ${${src}})
	if(QT5_ENABLED)
		file(GLOB_RECURSE QRCS RELATIVE "${dir}" "*.qrc")
		set(QRCFILES)
		foreach(item ${QRCS})
			list(APPEND QRCFILES "${dir}/${item}")
		endforeach()
		
		list(LENGTH QRCFILES ARGC)
		#message(STATUS ${ARGC} ${QRCFILES})
		if(${ARGC} GREATER 0)
			qt5_add_resources(QT_QRC ${QRCFILES})
			#message(STATUS ${QRCFILES})
		endif()
		list(APPEND ${src} ${QT_QRC})
	endif()
endmacro()

macro(__tree_add_current src)
	__tree_add_source(${CMAKE_CURRENT_SOURCE_DIR} ${src})
endmacro()

macro(__copy_third_party_dlls dlls)
	if(WIN32)
		add_custom_target(__copy_thirdparty ALL COMMENT "copy third party dll!")
		__set_target_folder(__copy_thirdparty CMakePredefinedTargets)

		foreach(dll ${${dlls}})
			set(_debug_dll "$ENV{CX_THIRDPARTY_ROOT}/bin/Debug/${dll}")
			set(_release_dll "$ENV{CX_THIRDPARTY_ROOT}/bin/Release/${dll}")
			add_custom_command(TARGET __copy_thirdparty PRE_BUILD
				COMMAND ${CMAKE_COMMAND} -E make_directory "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>"
				COMMAND ${CMAKE_COMMAND} -E copy_if_different  
					"$<$<CONFIG:Release>:${_release_dll}>"  
					"$<$<CONFIG:Debug>:${_debug_dll}>" 
					"${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>"
				)	
		endforeach()
	endif()
endmacro()

macro(__copy_files copy_target files)
	add_custom_target(${copy_target} ALL COMMENT "copy third party dll!")
	__set_target_folder(${copy_target} CMakePredefinedTargets)

	add_custom_command(TARGET ${copy_target} PRE_BUILD
			COMMAND ${CMAKE_COMMAND} -E make_directory "${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>"
		)
	foreach(file ${${files}})
		add_custom_command(TARGET ${copy_target} PRE_BUILD
			COMMAND ${CMAKE_COMMAND} -E copy_if_different  
				"$<$<CONFIG:Release>:${file}>"  
				"$<$<CONFIG:Debug>:${file}>" 
				"${BIN_OUTPUT_DIR}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Release>:Release>"
			)	
	endforeach()
endmacro()