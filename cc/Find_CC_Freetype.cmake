# This sets the following variables:
# FREETYPE_LIBRARIES
# freetype target

if(THIRD0_INSTALL_ROOT)
	message(STATUS "Specified THIRD0_INSTALL_ROOT : ${THIRD0_INSTALL_ROOT}")
	set(freetype_INCLUDE_ROOT ${THIRD0_INSTALL_ROOT}/include/freetype2/)
	set(freetype_LIB_ROOT ${THIRD0_INSTALL_ROOT}/lib/)
	__search_target_components(freetype
							   INC ft2build.h
							   DLIB freetype
							   LIB freetype
							   )
elseif(CXFREETYPE_INSTALL_ROOT)
	set(freetype_INCLUDE_ROOT ${CXFREETYPE_INSTALL_ROOT}/include/freetype2/)
	set(freetype_LIB_ROOT ${CXFREETYPE_INSTALL_ROOT}/lib/)
	__search_target_components(freetype
							   INC ft2build.h
							   DLIB freetype
							   LIB freetype
							   )
endif()

__test_import(freetype dll)

set(FREETYPE_LIBRARIES freetype)
set(FREETYPE_VERSION_STRING "1.1.1")