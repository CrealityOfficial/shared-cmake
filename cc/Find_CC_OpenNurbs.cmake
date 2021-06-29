# This sets the following variables:
# opennurbs target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(opennurbs_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/opennurbs/opennurbs/)
	set(opennurbs_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(opennurbs
							   INC opennurbs.h
							   DLIB opennurbs
							   LIB opennurbs
							   )
else()
endif()

__test_import(opennurbs dll)