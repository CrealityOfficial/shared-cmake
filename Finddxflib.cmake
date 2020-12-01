
# Find zlib
#
# This sets the following variables:
# dxflib_INCLUDE_DIRS
# dxflib_LIBRARIES
# dxflib_LIBRARIE_DIRS
# dxflib_FOUND

find_path(dxflib_INCLUDE_DIR dxf/dl_attributes.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
if(dxflib_INCLUDE_DIR)
	set(dxflib_INCLUDE_DIRS ${dxflib_INCLUDE_DIR})
endif()

find_library(dxflib_LIBRARIES_DEBUG
             NAMES dxflib
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(dxflib_LIBRARIES_RELEASE
         NAMES dxflib
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("dxflib_INCLUDE_DIR  ${dxflib_INCLUDE_DIR}")
message("dxflib_LIBRARIES_DEBUG  ${dxflib_LIBRARIES_DEBUG}")
message("dxflib_LIBRARIES_RELEASE  ${dxflib_LIBRARIES_RELEASE}")

if(dxflib_INCLUDE_DIRS AND dxflib_LIBRARIES_DEBUG AND dxflib_LIBRARIES_RELEASE)
	set(dxflib_FOUND "True")
	__import_target(dxflib lib)
endif()
