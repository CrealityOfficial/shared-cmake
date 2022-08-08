list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/conan/")

if(EXISTS ${CMAKE_BINARY_DIR}/conan_paths.cmake)
	include(${CMAKE_BINARY_DIR}/conan_paths.cmake)
	message(STATUS "Conan Use conan_paths.cmake")
	set(HAVE_CONAN_CACHE 1)
elseif(EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo_multi.cmake)
	include(${CMAKE_BINARY_DIR}/conanbuildinfo_multi.cmake)
	message(STATUS "Conan Use conanbuildinfo_multi.cmake")
	set(HAVE_CONAN_CACHE 1)
else()
	message(STATUS "Disable Conan")
	set(HAVE_CONAN_CACHE 0)
	if(CMAKE_USE_CONAN)
		message(STATUS "CMAKE_USE_CONAN, But Disabled")
	endif()
endif()

if(CMAKE_USE_CONAN)
endif()

macro(__conan_find)
	message(STATUS "CONAN ****** Start Find ${ARGN}")
	find_package(_conan_${ARGN})
	message(STATUS "CONAN ****** End Find ${ARGN}")
endmacro()

macro(__conan_import package type)
	cmake_parse_arguments(package "" "" "COMPONENT" ${ARGN})
	set(Components)
	if(package_COMPONENT)
		set(Components ${package_COMPONENT})
	else()
		set(Components ${package})
	endif()
	#message(STATUS "__conan_import ${package} [${Components}]")
	
	string(TOUPPER ${package} UPPER_PACKAGE)
	if(CONAN_${UPPER_PACKAGE}_ROOT_RELEASE OR CONAN_${UPPER_PACKAGE}_ROOT_DEBUG)
		set(DEBUG_ROOT ${CONAN_${UPPER_PACKAGE}_ROOT_DEBUG})
		set(RELEASE_ROOT ${CONAN_${UPPER_PACKAGE}_ROOT_RELEASE})
		
		set(INC_DIRS ${CONAN_INCLUDE_DIRS_${UPPER_PACKAGE}_RELEASE})
		if(CONAN_${UPPER_PACKAGE}_ROOT_DEBUG)
			set(INC_DIRS ${CONAN_INCLUDE_DIRS_${UPPER_PACKAGE}_DEBUG})
		endif()
		
		set(LIB_DEBUG_DIRS ${CONAN_LIB_DIRS_${UPPER_PACKAGE}_DEBUG})
		set(LIB_RELEASE_DIRS ${CONAN_LIB_DIRS_${UPPER_PACKAGE}_RELEASE})
		set(BIN_DEBUG_DIRS ${CONAN_BIN_DIRS_${UPPER_PACKAGE}_DEBUG})
		set(BIN_RELEASE_DIRS ${CONAN_BIN_DIRS_${UPPER_PACKAGE}_RELEASE})
		
		set(LIB_TYPE ${type})
		foreach(_component ${Components})
			if(NOT TARGET ${_component})
				message(STATUS "__conan_import target ${package} [${_component}]")
	
				set(${_component}_INCLUDE_DIRS ${INC_DIRS})
				
				if(CC_BC_WIN)
					set(${_component}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/${_component}.lib")
					set(${_component}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/${_component}.lib")
					set(${_component}_LOC_DEBUG "${BIN_DEBUG_DIRS}/${_component}.dll")
					set(${_component}_LOC_RELEASE "${BIN_RELEASE_DIRS}/${_component}.dll")
				elseif(CC_BC_LINUX)
					if(${type} STREQUAL "dll")
						set(${_component}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/lib${_component}.so")
						set(${_component}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/lib${_component}.so")
						set(${_component}_LOC_DEBUG "${LIB_DEBUG_DIRS}/Debug/lib${_component}.so")
						set(${_component}_LOC_RELEASE "${LIB_RELEASE_DIRS}/Release/lib${_component}.so")
					else()
						set(${_component}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/lib${_component}.a")
						set(${_component}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/lib${_component}.a")
					endif()		
				elseif(CC_BC_EMCC)
					set(${_component}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/lib${_component}.a")
					set(${_component}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/lib${_component}.a")
					set(LIB_TYPE lib)
				endif()
				
				__test_import(${_component} ${LIB_TYPE})
			endif()
		endforeach()
	endif()
endmacro()

macro(__conan_import_one package type)
	cmake_parse_arguments(package "" "NAME;LIB;DLL;INC;INTERFACE_DEF" "" ${ARGN})

	string(TOUPPER ${package} UPPER_PACKAGE)
	if(CONAN_${UPPER_PACKAGE}_ROOT_RELEASE)
		set(DEBUG_ROOT ${CONAN_${UPPER_PACKAGE}_ROOT_DEBUG})
		set(RELEASE_ROOT ${CONAN_${UPPER_PACKAGE}_ROOT_RELEASE})
		
		set(INC_DIRS ${CONAN_INCLUDE_DIRS_${UPPER_PACKAGE}_RELEASE})
		set(LIB_DEBUG_DIRS ${CONAN_LIB_DIRS_${UPPER_PACKAGE}_DEBUG})
		set(LIB_RELEASE_DIRS ${CONAN_LIB_DIRS_${UPPER_PACKAGE}_RELEASE})
		set(BIN_DEBUG_DIRS ${CONAN_BIN_DIRS_${UPPER_PACKAGE}_DEBUG})
		if(NOT EXISTS ${BIN_DEBUG_DIRS})
			set(BIN_DEBUG_DIRS "${CONAN_${UPPER_PACKAGE}_ROOT_DEBUG}/bin")
		endif()
		set(BIN_RELEASE_DIRS ${CONAN_BIN_DIRS_${UPPER_PACKAGE}_RELEASE})
		if(NOT EXISTS ${BIN_RELEASE_DIRS})
			set(BIN_RELEASE_DIRS "${CONAN_${UPPER_PACKAGE}_ROOT_RELEASE}/bin")
		endif()
		
		if(package_LIB AND package_NAME)
			if(${type} STREQUAL "dll" AND NOT package_DLL)
				message(WARNING "__conan_import_one specify DLL")
			else()
				if(NOT TARGET ${package_NAME})
					message(STATUS "__conan_import target ${package} [${package_NAME}]")
		
					set(${package_NAME}_INCLUDE_DIRS ${INC_DIRS})
					if(package_INC)
						set(${package_NAME}_INCLUDE_DIRS ${package_INC})
					endif()
					if(CC_BC_WIN)
						set(${package_NAME}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/${package_LIB}.lib")
						set(${package_NAME}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/${package_LIB}.lib")
						set(${package_NAME}_LOC_DEBUG "${BIN_DEBUG_DIRS}/${package_DLL}.dll")
						set(${package_NAME}_LOC_RELEASE "${BIN_RELEASE_DIRS}/${package_DLL}.dll")
					elseif(CC_BC_LINUX)
						if(${type} STREQUAL "dll")
							set(${package_NAME}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/${package_LIB}.so")
							set(${package_NAME}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/${package_LIB}.so")
							set(${package_NAME}_LOC_DEBUG "${LIB_DEBUG_DIRS}/${package_DLL}.so")
							set(${package_NAME}_LOC_RELEASE "${LIB_RELEASE_DIRS}/lib${package_DLL}.so")
						else()
							set(${package_NAME}_LIBRARIES_DEBUG "${LIB_DEBUG_DIRS}/${package_LIB}.a")
							set(${package_NAME}_LIBRARIES_RELEASE "${LIB_RELEASE_DIRS}/${package_LIB}.a")
						endif()		
					endif()
					
					__test_import(${package_NAME} ${type})
					if(package_INTERFACE_DEF)
						set_property(TARGET ${package_NAME} PROPERTY INTERFACE_COMPILE_DEFINITIONS ${package_INTERFACE_DEF})
					endif()
				endif()
			endif()
		else()
			message(WARNING "__conan_import_one specify LIB and NAME")
		endif()
	endif()
endmacro()
