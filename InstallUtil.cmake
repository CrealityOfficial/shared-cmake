macro(__install_bin)
	if(WIN32)
		INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.lib")
		INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.dll")
		INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . FILES_MATCHING PATTERN "*.pdb")
	else()
		INSTALL(DIRECTORY "${LIB_OUTPUT_DIR}" DESTINATION . )
		INSTALL(DIRECTORY "${BIN_OUTPUT_DIR}" DESTINATION . )
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

macro(__install_directory_specif source dest)
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.h")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.hpp")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.hxx")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.ipp")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.lxx")
	INSTALL(DIRECTORY ${source} DESTINATION include/${dest}/ FILES_MATCHING PATTERN "*.gxx")
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

macro(__specific_sdk_root)
	if(DEFINED ENV{CC_SDK_ROOT})
		message(STATUS "specific roots from Env CC_SDK_ROOT : $ENV{CC_SDK_ROOT}")
		set(LUXCORE_SDK_ROOT $ENV{CC_SDK_ROOT}/luxsdk/)
	else()
		message(STATUS "not specific Env CC_SDK_ROOT")
	endif()
endmacro()