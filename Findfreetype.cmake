
# Find freetype
#
# This sets the following variables:
# freetype_INCLUDE_DIRS
# freetype_LIBRARIES
# freetype_LIBRARIE_DIRS
# freetype_FOUND

find_path(freetype_INCLUDE_DIR ft2build.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/freetype2"
	PATHS "/usr/include/freetype2")
	
if(freetype_INCLUDE_DIR)
	set(freetype_INCLUDE_DIRS ${freetype_INCLUDE_DIR})
endif()

find_library(freetype_LIBRARIES_DEBUG
             NAMES freetype
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(freetype_LIBRARIES_RELEASE
         NAMES freetype
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("freetype_INCLUDE_DIR  ${freetype_INCLUDE_DIR}")
message("freetype_LIBRARIES_DEBUG  ${freetype_LIBRARIES_DEBUG}")
message("freetype_LIBRARIES_RELEASE  ${freetype_LIBRARIES_RELEASE}")

if(freetype_INCLUDE_DIRS AND freetype_LIBRARIES_DEBUG AND freetype_LIBRARIES_RELEASE)
	set(freetype_FOUND "True")
	__import_target(freetype dll)
endif()
