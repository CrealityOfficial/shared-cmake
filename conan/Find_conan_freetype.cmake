# freetype target
if(CONAN_FREETYPE_ROOT_RELEASE)
	set(FREETYPE_INCLUDE_DIRS "${CONAN_FREETYPE_ROOT_RELEASE}/include/freetype2/")
endif()
__conan_import(freetype lib)
