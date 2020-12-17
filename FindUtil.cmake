macro(__required_find_package package)
	find_package(${package} REQUIRED)
	if(NOT DEFINED ${package}_FOUND)
		message(FATAL_ERROR "${package} not found!")
	else()
		message(STATUS "${package} include : ${${package}_INCLUDE_DIRS}")
	endif()
endmacro()

macro(__find_gtest)
	__find_one_package(gtest gtest/gtest.h lib CX_ANALYSIS_ROOT)
	__find_one_package(gtest_main gtest/gtest.h lib CX_ANALYSIS_ROOT)
endmacro()

