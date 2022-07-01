macro(__install_bin)
	if(CC_BC_WIN)
		if(EXISTS ${LIB_OUTPUT_DIR})
			INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.lib")
		endif()
		if(EXISTS ${BIN_OUTPUT_DIR})
			INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.dll")
		endif()
	elseif(CC_BC_MAC)
		if(EXISTS ${LIB_OUTPUT_DIR})
			INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . )
		endif()
		if(EXISTS ${BIN_OUTPUT_DIR})
			INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . )
		endif()
	elseif(CC_BC_LINUX)
		message(STATUS "__install_bin CC_BC_LINUX do nothing.")
	endif()
endmacro()

macro(__install_runtime)
	if(CC_BC_WIN)
	elseif(CC_BC_MAC)
	elseif(CC_BC_LINUX)
		if(EXISTS ${BIN_OUTPUT_DIR})
			INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}/Release/lib/" DESTINATION . )
		endif()	
	endif()
endmacro()

macro(__install_binary)
	if(WIN32)
		INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.dll")
	else()
		INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.so")
		INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.so")
	endif()
endmacro()

macro(__install_inc_directory source)
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.h")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.hpp")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.hxx")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.ipp")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.isph")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.lxx")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING PATTERN "*.gxx")
	INSTALL(DIRECTORY ${source} DESTINATION include FILES_MATCHING REGEX "/[^.]+$")
endmacro()

macro(__install_linux_binary target)
	if(NOT WIN32)
		INSTALL(TARGETS ${target}
						LIBRARY DESTINATION lib
						ARCHIVE DESTINATION .
						RUNTIME DESTINATION bin)
	endif()
endmacro()

macro(__install_directory_specif source dest)
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.h")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.hpp")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.hxx")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.ipp")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.lxx")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.gxx")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING REGEX "/[^.]+$")
endmacro()

macro(__install_directory_specif2 source dest)
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.tcc")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING REGEX "/[^.]+$")
endmacro()

function(__install_files source dest)
	INSTALL(FILES ${source} DESTINATION ${dest})
endfunction()

function(__install_inc_files dest)
	cmake_parse_arguments(file "" "" "SOURCE" ${ARGN})
	if(file_SOURCE)
		INSTALL(FILES ${file_SOURCE} DESTINATION include/${dest})
	endif()
endfunction()

macro(__specific_install_root)
	if(DEFINED ENV{CC_INSTALL_ROOT})
		message(STATUS "specific roots from Env CC_INSTALL_ROOT : $ENV{CC_INSTALL_ROOT}")
		set(HEADER_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/header/install/)
		set(BOOST_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/boost/install/)
		set(CGAL_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/cgal/cgal/cgal/include/)
		set(THIRD0_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/third0/install/)
		set(THIRD1_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/third1/install/)
		set(ANALYSIS_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/analysiscc/install/)
		set(OPENEXR_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/openexr/install/)
		set(EMBREE_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/embree/install/)
		set(OPENVDB_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/openvdb/install/)
		set(OPENSUBDIV_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/opensubdiv/install/)
		set(OIIO_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/oiio/install/)
		set(OCC_INSTALL_ROOT $ENV{CC_INSTALL_ROOT}/opencascad/install/)
	else()
		message(STATUS "not specific Env CC_INSTALL_ROOT")
	endif()
endmacro()

macro(__specific_package_root)
	if(DEFINED ENV{CX_BOOST_ROOT})
		message(STATUS "specific roots from Env CX_BOOST_ROOT : $ENV{CX_BOOST_ROOT}")
		set(BOOST_INSTALL_ROOT $ENV{CX_BOOST_ROOT}/)
	else()
		message(STATUS "not specific Env CX_BOOST_ROOT")
	endif()
	
	if(DEFINED ENV{CX_THIRDPARTY_ROOT})
		message(STATUS "specific roots from Env CX_THIRDPARTY_ROOT : $ENV{CX_THIRDPARTY_ROOT}")
		set(CXSTB_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT}/include/)
		set(CXRAPIDJSON_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT}/include/)
		set(CXVCG_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT}/include/vcglib/)
		set(CXEIGEN_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT}/include/eigen/)
		set(CXTRIMESH2_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXCLIPPER_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXZLIB_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXQUAZIP_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXQHULL_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXOPENSSL_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXLIBREVENGE_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXTINYXML_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXFREETYPE_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXDXFLIB_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXCGAL_INSTALL_ROOT $ENV{CX_CGAL_ROOT})
		set(CXSPDLOG_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXALIYUNOSS_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXGTEST_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
		set(CXCURA_INSTALL_ROOT $ENV{CX_THIRDPARTY_ROOT})
	else()
		message(STATUS "not specific Env CX_THIRDPARTY_ROOT")
	endif()
endmacro()

macro(__specific_occ_install_root install_root)
	if(DEFINED ${install_root})
		message(STATUS "specific occ install roots to : $${install_root}")
		set(OCC_INSTALL_ROOT $${install_root})
		set(OPENNURBS_INSTALL_ROOT $${install_root})
	else()
		message(STATUS "not specific occ install roots to : $${install_root}")
	endif()
endmacro()

macro(__specific_sdk_root)
	if(DEFINED ENV{CC_SDK_ROOT})
		message(STATUS "specific roots from Env CC_SDK_ROOT : $ENV{CC_SDK_ROOT}")
		set(LUXCORE_SDK_ROOT $ENV{CC_SDK_ROOT}/luxsdk/)
	else()
		message(STATUS "not specific Env CC_SDK_ROOT")
	endif()
endmacro()

if(INSTALL_CC_GLOBAL)
	__install_directory_specif(${CMAKE_MODULE_SOURCE_DIR}/ccglobal/ ccglobal)
	__install_directory_specif2(${CMAKE_MODULE_SOURCE_DIR}/ccglobal/ ccglobal)
endif()

macro(__install_import_targets targets)
	message(STATUS "__install_import_targets -> [${${targets}}]")
	foreach(target ${${targets}})
		get_target_property(IMPORT_LOC_RELEASE ${target} IMPORTED_LOCATION_RELEASE)

		if(IMPORT_LOC_RELEASE AND EXISTS ${IMPORT_LOC_RELEASE})
			INSTALL(FILES ${IMPORT_LOC_RELEASE} DESTINATION .)
		endif()
	endforeach()
endmacro()
