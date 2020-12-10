
# Find clipper
#
# This sets the following variables:
# clipper_INCLUDE_DIRS
# clipper_LIBRARIES
# clipper_LIBRARIE_DIRS
# clipper_FOUND

find_path(clipper_INCLUDE_DIR clipper/clipper.hpp
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
if(clipper_INCLUDE_DIR)
	set(clipper_INCLUDE_DIRS ${clipper_INCLUDE_DIR})
endif()

find_library(clipper_LIBRARIES_DEBUG
             NAMES clipper
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(clipper_LIBRARIES_RELEASE
         NAMES clipper
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("clipper_INCLUDE_DIR  ${clipper_INCLUDE_DIR}")
message("clipper_LIBRARIES_DEBUG  ${clipper_LIBRARIES_DEBUG}")
message("clipper_LIBRARIES_RELEASE  ${clipper_LIBRARIES_RELEASE}")

if(clipper_INCLUDE_DIRS AND clipper_LIBRARIES_DEBUG AND clipper_LIBRARIES_RELEASE)
	set(clipper_FOUND "True")
	__import_target(clipper lib)
endif()
