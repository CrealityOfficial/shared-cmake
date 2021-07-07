# This sets the following variables:
# librevenge_INCLUDE_DIRS
# librevenge_LIBRARIES_DEBUG librevenge_LIBRARIES_RELEASE
# librevenge target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(zlib_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/zlib/)
	set(zlib_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(zlib
							   INC zlib.h
							   DLIB zlib
							   LIB zlib
							   )
elseif(CXLIBREVENGE_INSTALL_ROOT)
	set(librevenge_INCLUDE_ROOT ${CXLIBREVENGE_INSTALL_ROOT}/include/librevenge/)
	set(librevenge_LIB_ROOT ${CXLIBREVENGE_INSTALL_ROOT}/lib/)
	__search_target_components(librevenge
							   INC librevenge/librevenge.h
							   DLIB librevenge
							   LIB librevenge
							   )
endif()

__test_import(librevenge dll)