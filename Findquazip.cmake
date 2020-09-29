
# Find quazip
#
# This sets the following variables:
# quazip_INCLUDE_DIRS
# quazip_LIBRARIES
# quazip_LIBRARIE_DIRS
# quazip_FOUND

find_path(quazip_INCLUDE_DIR quazip/quazip.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
if(quazip_INCLUDE_DIR)
	set(quazip_INCLUDE_DIRS ${quazip_INCLUDE_DIR})
endif()

find_library(quazip_LIBRARIES_DEBUG
             NAMES quazip
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(quazip_LIBRARIES_RELEASE
         NAMES quazip
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("quazip_INCLUDE_DIR  ${quazip_INCLUDE_DIR}")
message("quazip_LIBRARIES_DEBUG  ${quazip_LIBRARIES_DEBUG}")
message("quazip_LIBRARIES_RELEASE  ${quazip_LIBRARIES_RELEASE}")

if(quazip_INCLUDE_DIRS AND quazip_LIBRARIES_DEBUG AND quazip_LIBRARIES_RELEASE)
	set(quazip_FOUND "True")
	__import_target(quazip lib)
endif()
