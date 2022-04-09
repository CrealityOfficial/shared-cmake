macro(__build_unit_testing_from_directory directory)
	file(GLOB  ALL_TESTS "${directory}/*.cpp")
	
	if(CC_BC_WIN)
		set(SHELL ${CMAKE_SOURCE_DIR}/cmake/ci/shell/executeUnitTesting.bat)
	elseif(CC_BC_LINUX)
	endif()
	
	set(EXECUTE_DIR $<$<CONFIG:Release>:${BIN_OUTPUT_DIR}/Release/>$<$<CONFIG:Debug>:${BIN_OUTPUT_DIR}/Debug/>)
	
	add_custom_target(__unit_testing ALL 
		COMMAND ${SHELL} ${EXECUTE_DIR}
		COMMENT "execute all unit testing.")
	__set_target_folder(__unit_testing unitTesting)
	#message(STATUS "global_cache_libs : ${global_cache_libs}")
	#message(STATUS "ALL_TESTS : ${ALL_TESTS}")
	
	foreach(TEST ${ALL_TESTS})
		STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" RELATIVE_TEST ${TEST})
		#message(STATUS "build unit testing : ${RELATIVE_TEST}")
		__add_real_target(${RELATIVE_TEST} exe SOURCE ${TEST}
												LIB ${global_cache_libs}
												FOLDER unitTesting
												)
		add_dependencies(__unit_testing ${RELATIVE_TEST})
	endforeach()

endmacro()

macro(__enable_unit_testing)
	if(CC_UNIT_TESTING)
		__cc_find(Gtest)
		__cc_find(Boost)
		__assert_target(gtest)
		__assert_target(gtest_main)
		if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/unitTesting/)
			#add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/unitTesting/)
			__build_unit_testing_from_directory(${CMAKE_CURRENT_SOURCE_DIR}/unitTesting/)
		else()
			message(FATAL_ERROR "CC_UNIT_TESTING is enabled, but ${CMAKE_CURRENT_SOURCE_DIR}/unitTesting/ not exists!")
		endif()
	endif()
endmacro()