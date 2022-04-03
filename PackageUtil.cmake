set(PROJECT_VERSION_MAJOR)
set(PROJECT_VERSION_MINOR)
set(PROJECT_VERSION_PATCH)
set(PROJECT_BUILD_ID)
set(PROJECT_VERSION_EXTRA)
if(NOT (${PROJECT_VERSION_MAJOR} MATCHES "^[0-9]*$"))
	set(PROJECT_VERSION_MAJOR 0)
	set(PROJECT_VERSION_MINOR 0)
	set(PROJECT_VERSION_PATCH 1)
	set(PROJECT_BUILD_ID 0)
	set(PROJECT_VERSION_EXTRA "Alpha")
endif()

message(STATUS "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
__build_info_header()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
	message(STATUS "CMAKE_INSTALL_PREFIX Default.")
	SET(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install/)
endif()

message(STATUS "CMAKE INSTALL PREFIX ${CMAKE_INSTALL_PREFIX}")

macro(__set_install_project)
	SET(CMAKE_INSTALL_PREFIX $ENV{USR_INSTALL_ROOT})
	__set_not_install_import()
	
	message("__set_install_project -> prefix : ${CMAKE_INSTALL_PREFIX}")
endmacro()

if(CC_BC_WIN)
	include(package/win_package)
elseif(CC_BC_MAC)
	include(package/macx_package)
endif()

macro(__package_project)
	if(WIN32)
		INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.lib")
		if(EXISTS ${BIN_OUTPUT_DIR})
			INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.dll")
			INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.pdb")
		endif()
	else()
		INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . )
		if(EXISTS ${BIN_OUTPUT_DIR})
			message("install ${BIN_OUTPUT_DIR}")
			INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . )
		endif()
	endif()

    set(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}.0")
    set(CPACK_GENERATOR "NSIS")
    set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
    set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
    set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
	set(CPACK_PACKAGE_NAME ${PROJECT_NAME})
    set(CPACK_PACKAGE_EXECUTABLES "${PROJECT_NAME}" "${PROJECT_NAME}")
    set(CPACK_PACKAGE_INSTALL_DIRECTORY "${PROJECT_NAME}")
		
    include(CPack)
endmacro()

macro(__default_package)
	if (CMAKE_BUILD_TYPE MATCHES "Release")
		if(CC_BC_WIN)
			include(package/win_package)
		elseif(CC_BC_MAC)
			include(package/macx_package)
		elseif(CC_BC_LINUX)
		endif()
		include(CPack)
	endif()	
endmacro()

macro(__simple_package)
	IF (CMAKE_BUILD_TYPE MATCHES "Release")
		SET(PROJECT_VERSION "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}.0")
		SET(CPACK_GENERATOR "NSIS")
		SET(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
		SET(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
		SET(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
		SET(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
		SET(CPACK_PACKAGE_VENDOR "${PROJECT_VENDOR}")
		IF(WIN32)
			SET(CPACK_GENERATOR "WIX")
			SET(CPACK_PACKAGE_EXECUTABLES "${PROJECT_NAME}" "${PROJECT_NAME}")
			SET(CPACK_PACKAGE_INSTALL_DIRECTORY "${PROJECT_NAME}")
			set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
			set(CPACK_PACKAGE_VENDOR "Creality")
			set(CPACK_WIX_CULTURES "en-US")
			if(CMAKE_CL_64)
				set(CPACK_SYSTEM_NAME "win64")
			else()
				set(CPACK_SYSTEM_NAME "win32")
			endif()
			if(EXISTS "${CMAKE_SOURCE_DIR}/wixConfig.wxs")
				set(CPACK_WIX_PATCH_FILE "${CMAKE_SOURCE_DIR}/wixConfig.wxs")
			endif()
		ELSEIF(APPLE)
			 SET(CPACK_GENERATOR "DragNDrop")
			 SET(CPACK_DMG_FORMAT "UDBZ")
			 SET(CPACK_DMG_VOLUME_NAME "${PROJECT_NAME}")
			 SET(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}")
		ELSEIF(UNIX)
			SET(CPACK_GENERATOR "DEB")
			set(CPACK_DEBIAN_PACKAGE_MAINTAINER "hemiao")
			set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "Creative3D Slice Program")
			set(CPACK_DEBIAN_PACKAGE_VERSION ${PROJECT_VERSION})
			set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
			set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.3.1-6), libc6 (<< 3)")
		ENDIF()

		set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}-v${PROJECT_VERSION}-${CPACK_SYSTEM_NAME}")
		INCLUDE(CPack)
	ENDIF()
endmacro()
