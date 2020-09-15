
# Find freeglut
#
# This sets the following variables:
# freeglut_INCLUDE_DIRS
# freeglut_LIBRARIES
# freeglut_LIBRARIE_DIRS
# freeglut_FOUND

find_path(freeglut_INCLUDE_DIR GL/freeglut.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/"
	PATHS "/usr/include/")
	
if(freeglut_INCLUDE_DIR)
	set(freeglut_INCLUDE_DIRS ${freeglut_INCLUDE_DIR})
endif()

find_library(freeglut_LIBRARIES_DEBUG
             NAMES freeglut
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(freeglut_LIBRARIES_RELEASE
         NAMES freeglut
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("freeglut_INCLUDE_DIR  ${freeglut_INCLUDE_DIR}")
message("freeglut_LIBRARIES_DEBUG  ${freeglut_LIBRARIES_DEBUG}")
message("freeglut_LIBRARIES_RELEASE  ${freeglut_LIBRARIES_RELEASE}")

if(freeglut_INCLUDE_DIRS AND freeglut_LIBRARIES_DEBUG AND freeglut_LIBRARIES_RELEASE)
	set(freeglut_FOUND "True")
	__import_target(freeglut dll)
endif()
