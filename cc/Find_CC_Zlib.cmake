# This sets the following variables:
# zlib_INCLUDE_DIRS
# zlib_LIBRARIES_DEBUG zlib_LIBRARIES_RELEASE
# zlib target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(zlib_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/zlib/)
	set(zlib_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
elseif(CXZLIB_INSTALL_ROOT)
	set(zlib_INCLUDE_ROOT ${CXZLIB_INSTALL_ROOT}/include/zlib/)
	set(zlib_LIB_ROOT ${CXZLIB_INSTALL_ROOT}/lib/)
endif()

__search_target_components(zlib
						   INC zlib.h
						   DLIB zlib
						   LIB zlib
						   )

__test_import(zlib dll)