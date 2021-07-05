list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/cc/")

macro(__cc_find)
	message(STATUS "CC ****** Start Find ${ARGN}")
	find_package(_CC_${ARGN})
	message(STATUS "CC ****** End Find ${ARGN}")
endmacro()

function(__test_import target type)
	if(${target}_INCLUDE_DIRS AND ${target}_LIBRARIES_DEBUG AND ${target}_LIBRARIES_RELEASE)
		set(${target}_FOUND 1)
		__import_target(${target} ${type})
		message(STATUS "import ${target} success.")
	else()
		message(STATUS "import ${target} failed.")
	endif()
endfunction()

function(__search_target_components target)
	cmake_parse_arguments(search "" "" "INC;DLIB;LIB" ${ARGN})
	
	find_path(${target}_INCLUDE_DIRS
			NAMES ${search_INC}
			HINTS "${${target}_INCLUDE_ROOT}"
			PATHS "/usr/include/${target}"
			NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			)

	find_library(${target}_LIBRARIES_DEBUG
				NAMES ${search_DLIB}
				HINTS "${${target}_LIB_ROOT}/Debug"
				PATHS "/usr/lib/Debug"
				NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
				)
				
	find_library(${target}_LIBRARIES_RELEASE
			NAMES ${search_LIB}
			HINTS "${${target}_LIB_ROOT}/Release"
			PATHS "/usr/lib/Release"
			NO_SYSTEM_ENVIRONMENT_PATH NO_CMAKE_SYSTEM_PATH NO_CMAKE_PATH NO_CMAKE_ENVIRONMENT_PATH
			)
				
	message("${target}_INCLUDE_DIRS  ${${target}_INCLUDE_DIRS}")
	message("${target}_LIBRARIES_DEBUG  ${${target}_LIBRARIES_DEBUG}")
	message("${target}_LIBRARIES_RELEASE  ${${target}_LIBRARIES_RELEASE}")
endfunction()