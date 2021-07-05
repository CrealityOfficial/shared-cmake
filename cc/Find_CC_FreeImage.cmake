# This sets the following variables:
# freeImage target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(freeImage_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/freeImage/)
	set(freeImage_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(freeImage
							   INC FreeImageIO.h
							   DLIB freeImage
							   LIB freeImage 
							   )
else()
endif()

__test_import(freeImage dll)