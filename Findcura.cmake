
# Find cura
#
# This sets the following variables:
# cura_INCLUDE_DIRS
# cura_LIBRARIES
# cura_LIBRARIE_DIRS
# cura_FOUND

find_path(cura_INCLUDE_DIR Application.h
    HINTS "$ENV{CX_THIRDPARTY_ROOT}/include/cura"
	PATHS "/usr/include/cura")
	
if(cura_INCLUDE_DIR)
	set(cura_INCLUDE_DIRS ${cura_INCLUDE_DIR})
endif()

find_library(cura_LIBRARIES_DEBUG
             NAMES cura
             HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Debug"
			 PATHS "/usr/lib/Debug")
			 
find_library(cura_LIBRARIES_RELEASE
         NAMES cura
         HINTS "$ENV{CX_THIRDPARTY_ROOT}/lib/Release"
		 PATHS "/usr/lib/Release")
			 
message("cura_INCLUDE_DIR  ${cura_INCLUDE_DIR}")
message("cura_LIBRARIES_DEBUG  ${cura_LIBRARIES_DEBUG}")
message("cura_LIBRARIES_RELEASE  ${cura_LIBRARIES_RELEASE}")

if(cura_INCLUDE_DIRS AND cura_LIBRARIES_DEBUG AND cura_LIBRARIES_RELEASE)
	set(cura_FOUND "True")
	__import_target(cura lib)
endif()
