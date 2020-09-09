
# Find clipper
#
# This sets the following variables:
# clipper_INCLUDE_DIRS
# clipper_LIBRARIES
# clipper_LIBRARIE_DIRS
# clipper_FOUND

find_path(clipper_INCLUDE_DIR clipper.hpp
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include")
	
if(clipper_INCLUDE_DIR)
	set(clipper_INCLUDE_DIRS ${clipper_INCLUDE_DIR})
endif()

find_library(clipper_LIBRARIES_DEBUG
             NAMES clipper
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/debug")
			 
find_library(clipper_LIBRARIES_RELEASE
         NAMES clipper
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/release")
			 
if(clipper_INCLUDE_DIRS AND clipper_LIBRARIES_DEBUG AND clipper_LIBRARIES_RELEASE)
	set(clipper_FOUND "True")
	__import_target(clipper)
endif()
