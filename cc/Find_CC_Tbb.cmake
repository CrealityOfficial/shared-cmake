# This sets the following variables:
# tbb

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(tbb_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/)
	set(tbb_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(tbb
							   INC tbb/tbb.h
							   DLIB tbb
							   LIB tbb
							   )
else()
endif()

add_definitions(-D__TBB_NO_IMPLICIT_LINKAGE)
__test_import(tbb lib)