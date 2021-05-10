# This sets the following variables:
# gtest target
# gtest main

if(ANALYSIS_INSTALL_ROOT)
	message(STATUS "Specified ANALYSIS_INSTALL_ROOT : ${ANALYSIS_INSTALL_ROOT}")
	set(gtest_INCLUDE_ROOT ${ANALYSIS_INSTALL_ROOT}/include/)
	set(gtest_LIB_ROOT ${ANALYSIS_INSTALL_ROOT}/lib/)
	__search_target_components(gtest
							   INC gtest/gtest.h
							   DLIB gtest
							   LIB gtest
							   )
							   
	set(gtest_main_INCLUDE_ROOT ${ANALYSIS_INSTALL_ROOT}/include/)
	set(gtest_main_LIB_ROOT ${ANALYSIS_INSTALL_ROOT}/lib/)
	__search_target_components(gtest_main
							   INC gtest/gtest.h
							   DLIB gtest_main
							   LIB gtest_main
							   )
else()
endif()

__test_import(gtest lib)
__test_import(gtest_main lib)